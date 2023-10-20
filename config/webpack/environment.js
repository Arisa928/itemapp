const { environment } = require('@rails/webpacker')

environment.config.node = {
  __dirname: true,
  __filename: true
}

module.exports = environment
