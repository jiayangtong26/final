class SessionsController < ApplicationController
  def new
    if session.has_key?(:current_user_id)
      # if already logged in, redirect to the main page
      redirect_to reports_url
    end
  end

  def create
    user = User.find_by(user_name: params[:user_name])
    if user.nil? or not user.authenticate(params[:pass_word])
      redirect_to root_url, flash: {login_err: 'Login Error: Wrong username or password!'}
    else
      session[:current_user_id] = user.id
      session[:current_user_name] = user.user_name
      session[:current_user_type] = user.user_type
      redirect_to reports_url
    end
  end

  def destroy
    if session.has_key?(:current_user_id)
      session.delete(:current_user_id)
      session.delete(:current_user_name)
      session.delete(:current_user_type)
      redirect_to root_url
    end
  end

  def info
  end

end
