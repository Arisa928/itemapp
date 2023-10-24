const path = require('path');

module.exports = {
  entry: {
    application: './app/javascript/packs/application.js',
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
        loader : 'babel-loader',
        exclude: /node_modules/,
        use: [
          'style-loader',  // CSSをHTMLファイル内に注入
          'css-loader',    // CSSファイルを読み込む
          'sass-loader'    // SCSSをCSS変換
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
