const path = require('path');

module.exports = {
  entry: {
    application: '/itemapp/app/javascript/packs/application.js',
  },
  output: {
    path: path.resolve(__dirname, 'dist'), // バンドルされたファイルの出力先ディレクトリ
    filename: 'bundle.js',
  }
};
