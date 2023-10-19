module.exports = {
  entry: {
    application: '/itemapp/app/javascript/packs/application.js',
  },
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist'), // バンドルされたファイルの出力先ディレクトリ
  },
};
