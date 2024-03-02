const express = require("express");
const expressWs = require("express-ws");
const { createServer } = require("http");
const { GoogleGenerativeAI } = require("@google/generative-ai");
const dotenv = require("dotenv");

dotenv.config();

const genAI = new GoogleGenerativeAI(process.env.GOOGLE_API_KEY);
const PORT = process.env.PORT || 3000;

async function run(prompt) {
  const model = genAI.getGenerativeModel({ model: "gemini-pro" });
  const prompt1 = prompt;
  const result = await model.generateContent(prompt1);
  const response = await result.response;
  const text = response.text();
  return text;
}

const app = express();
const server = createServer(app);
expressWs(app, server);

app.ws("/", (ws, req) => {
  console.log("Client connected");

  ws.on("message", async (message) => {
    const output = await run(message);
    console.log(`Output: ${output}`);

    // Send the output back to the client
    ws.send(output);
  });
});

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
