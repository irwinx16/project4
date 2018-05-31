class UserController < ApplicationController
  # get route
  get '/' do 
    users = User.all
    {
      success: true,
      message: "This is your #{users.length} User.",
      users: users
    }.to_json
  end

  # logout route
  get '/logout' do
    username = session[:username]
    session.destroy
    {
      success: true,
      message: "#{username} has logged out."
    }.to_json
  end

  # register route
  post '/register' do
    user = User.new
    user.username = @payload[:username]
    user.password = @payload[:password]
    user.save

    session[:logged_in] = true
    session[:username] = user.username
    session[:user_id] = user.id

    {
      success: true,
      message: "Thank you for register #{user.username}."
    }.to_json
  end

  # login route
  post '/login' do
    username = @payload[:username]
    password = @payload[:password]

    user = User.find_by username: username

    if user && user.authenticate(password)
      session[:logged_in] = true
      session[:username] = username
      session[:user_id] = user.id

      {
        success: true,
        user_id: user.id,
        username: username,
        message: "Login successful #{user.username}."
      }.to_json
    else 
      {
        success: false,
        message: "Invalid Username or Password."
      }.to_json
    end
  end

  # show route
  get '/:id' do
    show_user = User.find params[:id]
    {
      success: true,
      message: "Here's more information about #{show_user.username}.",
      show_user: show_user
    }.to_json
  end

  # edit route
  put '/:id' do
    updated_user = User.find params[:id]
    updated_user.username = @payload[:username]

    # not sure if this actually will update the password when they login, but it works in json
    updated_user.password = @payload[:password]
    updated_user.save
    {
      success: true,
      message: "#{updated_user.username} successfully updated.",
      updated_user: updated_user
    }.to_json
  end

# delete route
  delete '/:id' do
    deleted_user = User.find params[:id]
    deleted_user.destroy
    {
      success: true,
      message: "#{deleted_user.username} successfully deleted."
    }.to_json
  end

end
