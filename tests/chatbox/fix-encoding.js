const http = require('http');

async function fixWelcomeMessage() {
  // 1. Login Admin
  const loginData = JSON.stringify({
    email: 'admin@bookstore.com',
    password: 'Admin@123'
  });

  const token = await new Promise((resolve, reject) => {
    const req = http.request({
      hostname: 'localhost',
      port: 5193,
      path: '/api/auth/login',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(loginData)
      }
    }, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        const json = JSON.parse(body);
        resolve(json.data.token);
      });
    });
    req.on('error', reject);
    req.write(loginData);
    req.end();
  });

  // 2. PUT ChatSettings with pure UTF-8
  const settingsData = JSON.stringify({
    isEnabled: true,
    welcomeMessage: 'Xin chào bạn! 👋 Mình là trợ lý AI của BookStore. Bạn cần tìm sách gì hoặc muốn giải đáp thắc mắc về chính sách không ạ?',
    systemNotice: ''
  });

  const result = await new Promise((resolve, reject) => {
    const req = http.request({
      hostname: 'localhost',
      port: 5193,
      path: '/api/chat/admin/settings',
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Content-Length': Buffer.byteLength(settingsData, 'utf8'),
        'Authorization': `Bearer ${token}`
      }
    }, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => resolve(JSON.parse(body)));
    });
    req.on('error', reject);
    req.write(Buffer.from(settingsData, 'utf8'));
    req.end();
  });

  console.log('Result:', JSON.stringify(result, null, 2));
}

fixWelcomeMessage().catch(console.error);
