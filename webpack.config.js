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
          options: {
            presets: ['@babel/preset-env']
          }
        }
      }
    ]
  },
  resolve: {
    // import時の拡張子が不要になる
    // import SumType from "app/src/sumType.js"の.jsの部分
    extensions: [".js", ".jsx", ".ts", ".tsx"],
    alias: {
      'channels': path.resolve(__dirname, 'app/javascript/channels/index.js'),
    },
  },
  // ES5(IE11等)向けの指定
  target: ["web", "es5"],
};
