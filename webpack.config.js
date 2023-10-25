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
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
  resolve: {
    alias: {
      'channels': path.resolve(__dirname, 'app/javascript/channels/index.js'),
    },
  },
};
