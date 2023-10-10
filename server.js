// 必要なモジュールをインポート
const http = require('http');

// サーバーオブジェクトの作成
const server = http.createServer((req, res) => {
  // リクエストを処理するコードをここに記述
  res.statusCode = 200;
  res.render('top.html.erb');
});

// サーバーを指定のポートでリスニング
const port = process.env.PORT || 3000;
server.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
