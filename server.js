// 必要なモジュールをインポート
const http = require('http');

// サーバーオブジェクトの作成
const server = http.createServer((req, res) => {
  // リクエストを処理するコードをここに記述
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello, World!\n');
});

// サーバーを指定のポートでリスニング
const port = process.env.PORT || 3000;
server.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
