class AuthController < ApplicationController
  def create
    username = params[:username]
    password = params[:password]
    user = User.create(username: username, password: password, token: SecureRandom.urlsafe_base64(nil, false))

    if user.persisted?
      render json: {
        id: user.id,
        username: user.username
      }
    else
      render json: {
        error: 'Cannot register user'
      }
    end
  end

  def login
    username = params[:username]
    password = params[:password]

    user = User.find_by(username: username)
    if user && user.authenticate(password)
      user.token = SecureRandom.urlsafe_base64(nil, false)
      user.save
      render json: {
        id: user.id,
        username: user.username,
        token: user.token
      }
    else
      render json: {
        error: 'Login failed'
      }
    end
  end
end
