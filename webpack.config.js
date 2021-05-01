const path = require('path');
const { readdirSync } = require('fs');

const SRC_DIR = 'handlers'
const entry = readdirSync(SRC_DIR)
.filter(item => /\.(t|j)s$/.test(item))
.filter(item => !/\.d\.(t|j)s$/.test(item))
.reduce((acc, fileName) => ({
  ...acc,
  [fileName.replace(/\.(t|j)s$/, '')]: `./${SRC_DIR}/${fileName}`
}), {})

module.exports = {
  entry,
  externals: [
    'aws-sdk'
  ],
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].js',
    library: '[name]',
    libraryTarget: 'commonjs2',
  },
  resolve: {
    modules: ['node_modules'],
    extensions: [ '.tsx', '.ts', '.js', '.json' ],
  },
  target: 'node',
  stats: 'minimal',
  optimization: {
    usedExports: true,
  },
  mode: 'production',
  devtool: 'source-map',
};
