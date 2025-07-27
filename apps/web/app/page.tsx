import axios from "axios"
import { prismaClient } from "db/client";

async function getUsers(){
  try {
    const response = await axios.get("http://localhost:3001/");
    return response.data;
  } catch (error) {
    console.error("Failed to fetch users:", error);
    return { message: "Backend not available", users: [] };
  }
}

export default async function Home() {
  const users = await getUsers();
  const todos = await prismaClient.todo.findMany({});

  return <>
    <div>Users: {JSON.stringify(users)}</div>
    <div>Todos: {JSON.stringify(todos)}</div>
  </>
}


// export const revalidate = 60 // revalidate every 60 seconds and static generate

// or 
 
// this will force it to be a dynamic page 
// now it is not getting data on while building
export const dynamic = 'force-dynamic'

