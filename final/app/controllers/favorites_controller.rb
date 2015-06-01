class FavoritesController < ApplicationController

  before_action :check_user

  def check_user
    if not session.has_key?(:current_user_id)
      redirect_to root_url, flash: {login_err: 'Please login first'}
    else
      @current_user = User.find_by(:id => session["current_user_id"])
      if @current_user.nil?
        session.delete(:current_user_id)
        session.delete(:current_user_name)
        session.delete(:current_user_type)
        redirent_to root_url
      end
    end
  end

  def create  
    favorite_new = Favorite.new
    favorite_new.user_ID = @current_user.id
    favorite_new.report_ID = params['report_id']
    favorite_new.save
    redirect_to report_url(params['report_id'])
  end

  def destroy
    favorite_del = Favorite.find_by(:user_ID => @current_user.id, :report_ID => params['report_id'])
    favorite_del.destroy
    redirect_to report_url(params['report_id'])
  end

end
