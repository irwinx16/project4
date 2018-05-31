class ApplicationController < Sinatra::Base 
  require 'bundler'
  Bundler.require()

  before do
    payload_body = request.body.read

    next if payload_body.empty?

    @payload = JSON.parse(payload_body).symbolize_keys

    puts "-----------------------------------------------HERE IS OUR PAYLOAD"
    pp @payload
    puts "-----------------------------------------------------------------"
  end

  ActiveRecord::Base.establish_connection(
    adapter:  'postgresql',
    database: 'inventory'
  )

  use(
    Rack::Session::Cookie,
    key:    'rack.session',
    path:   '/',
    secret: 'your_secret'
  )
  
  get '/' do
    {
      success: false,
      message: "Please consult the API documentation."
    }.to_json
  end

  not_found do
    halt 404
  end

  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
  end

  set :allow_origin, :any
  set :allow_methods, [:get, :post, :options, :put, :patch, :delete]
  set :allow_credentials, true

  options '*' do
      response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE'
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  end

end
