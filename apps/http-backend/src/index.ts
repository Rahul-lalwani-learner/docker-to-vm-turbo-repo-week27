import express from "express"
import {prismaClient} from "db/client"
import cors from "cors"

const app = express();

app.use(cors());
app.use(express.json());

// Health check endpoint
app.get("/health", (req, res) => {
    res.status(200).json({ status: "healthy", timestamp: new Date().toISOString() });
});

app.get("/", async (req, res)=>{
    const user = await prismaClient.user.findMany({});
    res.json({
        "message": "get endpoint", 
        "user": user
    })
})

app.post("/", async (req , res)=>{
    await prismaClient.user.create({
        data: {
            username: Math.random().toString(), 
            password: Math.random().toString()
        }
    })
    res.json({
        "message": "user created", 
    })
})

app.listen(3001, ()=>{
    console.log("app is listening to port 3001")
})