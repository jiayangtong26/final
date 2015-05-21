class UsersController < ApplicationController

  before_action :get_user, :only => [:edit, :update]

  def get_user
    @current_user = User.find_by(:id => session["current_user_id"])
  end

  def create
    user_exist = User.find_by(:user_name => params['user_name'])
    if not user_exist.nil?
      redirect_to login_url, notice: 'Username already used'
    elsif params['pass_word'] != params['confirm_pw']
      redirect_to login_url, notice: 'password does not match'
    else
      user = User.new
      user.user_name = params['user_name']
      user.pass_word = params['pass_word']
      user.email = params['email_add']
      user.user_type = params['user_type']
      user.save

      params['preference'].split(';').each do |input_tag_name|
        tag_prefer = Tag.find_by(:tag_name => input_tag_name)
        if not tag_prefer.nil?
          prefer_new = Preference.new
          prefer_new.user_ID = user.id
          prefer_new.tag_ID = tag_prefer.id
          prefer_new.save
        end
      end

      session[:current_user_id] = user.id
      redirect_to reports_url
    end
  end

  def edit
    if not session.has_key?(:current_user_id)
      redirect_to root_url, flash: {login_err: 'Please login first'}
    end

    @tag_list = ''
    prefer_list = Preference.where(:user_ID => @current_user.id)
    tag_list = Tag.where(:id => prefer_list.select('tag_ID'))

    tag_list.each do |tag_prefer|
      if @tag_list == ''
        @tag_list = tag_prefer.tag_name
      else
        @tag_list = @tag_list + ';' + tag_prefer.tag_name
      end
    end
  end

  def update
    if params['pass_word'] != params['confirm_pw']
      redirect_to edit_user_url, notice: 'password does not match'
    else
      @current_user.email = params['email_add']
      @current_user.pass_word = params['pass_word']
      @current_user.save

      prefer_del = Preference.where(:user_ID => @current_user.id)
      prefer_del.delete_all

      params['preference'].split(';').each do |tag_new|
        tag_got = Tag.find_by(:tag_name => tag_new)
        if not tag_got.nil?
          prefer_new = Preference.new
          prefer_new.user_ID = @current_user.id
          prefer_new.tag_ID = tag_got.id
          prefer_new.save
        end
      end
      redirect_to reports_url
    end
  end
end
