import { WebSocketServer } from "ws";
import { prismaClient } from "db/client"

const wss = new WebSocketServer({port: 3002})
interface messageTypes{
    type: 'seeTodo' | 'createTodo', 
    task?: string, 
    userId ?: string
}
wss.on('connection', (socket)=>{
    socket.on('message', async (message)=>{
        const req : messageTypes = JSON.parse(message.toString());
        if(req.type == 'seeTodo'){
            const todos = await prismaClient.todo.findMany({});
            socket.send(JSON.stringify(todos))
        }
        else if(req.type == 'createTodo'){
            if (!req.task || !req.userId) {
                socket.send("Error: task and userId are required");
                return;
            }
            await prismaClient.todo.create({
                data: {
                    task: req.task, 
                    userId: req.userId
                }
            })
            socket.send("Todo Created!!!")
        }
        else{
            socket.send(message.toString())
        }
    })
})