import { WebSocketServer } from "ws";
import { prismaClient } from "db/client"

const wss = new WebSocketServer({port: 3002})

console.log('WebSocket server started on port 3002');

interface messageTypes{
    type: 'seeTodo' | 'createTodo' | 'createUser', 
    task?: string, 
    userId ?: string,
    username?: string,
    password?: string
}
wss.on('connection', (socket)=>{
    console.log('WebSocket client connected');
    socket.on('message', async (message)=>{
        try {
            const req : messageTypes = JSON.parse(message.toString());
            console.log('Received message:', req);
            
            if(req.type == 'seeTodo'){
                const todos = await prismaClient.todo.findMany({
                    include: {
                        user: true
                    }
                });
                socket.send(JSON.stringify(todos))
            }
            else if(req.type == 'createTodo'){
                if (!req.task || !req.userId) {
                    socket.send(JSON.stringify({error: "task and userId are required"}));
                    return;
                }
                
                // Check if user exists, if not create one
                let user = await prismaClient.user.findUnique({
                    where: { id: req.userId }
                });
                
                if (!user) {
                    // Create user if it doesn't exist
                    user = await prismaClient.user.create({
                        data: {
                            id: req.userId,
                            username: `user_${req.userId.slice(0, 8)}`,
                            password: "default_password"
                        }
                    });
                    console.log('Created new user:', user);
                }
                
                const todo = await prismaClient.todo.create({
                    data: {
                        task: req.task, 
                        userId: req.userId
                    }
                });
                socket.send(JSON.stringify({success: "Todo Created!!!", todo}));
            }
            else if(req.type == 'createUser'){
                if (!req.username || !req.password) {
                    socket.send(JSON.stringify({error: "username and password are required"}));
                    return;
                }
                
                const user = await prismaClient.user.create({
                    data: {
                        username: req.username,
                        password: req.password
                    }
                });
                socket.send(JSON.stringify({success: "User Created!!!", user}));
            }
            else{
                socket.send(JSON.stringify({error: "Unknown message type", received: message.toString()}));
            }
        } catch (error) {
            console.error('Error processing message:', error);
            const errorMessage = error instanceof Error ? error.message : 'Unknown error';
            socket.send(JSON.stringify({error: "Internal server error", details: errorMessage}));
        }
    })
    
    socket.on('close', () => {
        console.log('WebSocket client disconnected');
    });
})