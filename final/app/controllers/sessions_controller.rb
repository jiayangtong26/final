class SessionsController < ApplicationController
  def new
    if session.has_key?(:current_user_id)
      # if already logged in, redirect to the main page
      redirect_to reports_url
    end
  end

  def create
    user = User.find_by(user_name: params[:user_name])
    if user.nil? or user.pass_word != params[:pass_word]
      redirect_to root_url, flash: {login_err: 'Wrong username or password'}
    else
      session[:current_user_id] = user.id
      redirect_to reports_url
    end
  end

  def destroy
    if session.has_key?(:current_user_id)
      session.delete(:current_user_id)
      #session[:currrent_user_id] = nil
      redirect_to root_url, flash: {login_err: 'Logoff successfully'}
    else
      redirect_to root_url, flash: {login_err: 'No need to Logoff'}
    end
  end

end
