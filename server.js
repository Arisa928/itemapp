const express = require('express');
const app = express();
const port = process.env.PORT || 3000; // ポート番号を設定

// 静的ファイルの提供（例：CSS、JavaScript、画像など）
app.use(express.static('public'));

// トップページのルートを設定
app.get('/', (req, res) => {
  res.render('top.html.erb'); 
});

// サーバーを起動
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
