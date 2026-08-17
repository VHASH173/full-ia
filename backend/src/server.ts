import express from 'express';
import cors from 'cors';
import { Server } from 'socket.io';
import { createServer } from 'http';
import { exec } from 'child_process';
import { Octokit } from 'octokit';

const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer, { cors: { origin: '*' } });

app.use(cors());
app.use(express.json());

// Terminal WebSocket
io.on('connection', (socket) => {
  console.log('Terminal connected');
  
  socket.on('command', (cmd) => {
    exec(cmd, { cwd: '/tmp' }, (error, stdout, stderr) => {
      socket.emit('output', error ? stderr : stdout);
    });
  });
});

// GitHub OAuth
app.get('/auth/github', (req, res) => {
  const url = `https://github.com/login/oauth/authorize?client_id=${process.env.GITHUB_CLIENT_ID}&scope=repo`;
  res.redirect(url);
});

// Clonar repo
app.post('/clone', async (req, res) => {
  const { repo, token } = req.body;
  exec(`git clone https://${token}@github.com/${repo}.git /tmp/${repo}`, (err) => {
    res.json({ success: !err });
  });
});

// Build app
app.post('/build', (req, res) => {
  const { projectPath, type } = req.body;
  
  const command = type === 'flutter' 
    ? `cd ${projectPath} && flutter build apk --release`
    : `cd ${projectPath} && docker build -t app .`;
    
  exec(command, (err, stdout) => {
    res.json({ 
      success: !err, 
      output: stdout,
      downloadUrl: err ? null : `/download/${Date.now()}.apk`
    });
  });
});

httpServer.listen(3000, () => console.log('Server on port 3000'));
