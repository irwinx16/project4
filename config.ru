require 'sinatra/base'
require 'sinatra/activerecord'

# models
require './models/UserModel'
require './models/ProductModel'

# controllers
require './controllers/ApplicationController'
require './controllers/UserController'
require './controllers/ProductController'

# routes
map('/') {
  run ApplicationController
}
map('/user') {
  run UserController
}
map('/product') {
  run ProductController
}
