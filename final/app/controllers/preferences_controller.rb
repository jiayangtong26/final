class PreferencesController < ApplicationController

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

    tag_prefered = Tag.find_by(:id => params['tag_id'])
    if not tag_prefered.nil?
      prefer_new = Preference.new
      prefer_new.user_ID = session['current_user_id']
      prefer_new.tag_ID = params['tag_id']
      prefer_new.save
      if params.has_key?('return_report')
        redirect_to report_url(params['return_report'])
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

end
