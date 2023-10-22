const path = require('path');

module.exports = {
  entry: {
    application: 'server.js',
  },
  output: {
    path: path.resolve(__dirname, 'dist'), // バンドルされたファイルの出力先ディレクトリ
    filename: 'bundle.js',
  },
  mode: 'production',
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          'style-loader',  // CSSをHTMLファイル内に注入
          'css-loader',    // CSSファイルを読み込む
          'sass-loader'    // SCSSをCSSに変換
        ]
      }
    ]
  },
  resolve: {
    alias: {
      'channels': path.resolve(__dirname, 'app/javascript/channels/index.js'),
    }
  }
};
