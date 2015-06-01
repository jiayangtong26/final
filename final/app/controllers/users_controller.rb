class UsersController < ApplicationController

  before_action :get_user, :only => [:edit, :update]

  def get_user
    if not session.has_key?(:current_user_id)
      redirect_to root_url, flash: {login_err: 'Login Error: Please login first!'}
    else
      @current_user = User.find_by(:id => session["current_user_id"])
    end
  end

  def create
    user_exist = User.find_by(:user_name => params['user_name'])
    if not user_exist.nil?
      redirect_to login_url, flash: {signup_err: 'Signup Error: Username already exists!'}
    elsif params['pass_word'] != params['confirm_pw']
      redirect_to login_url, flash: {signup_err: 'Signup Error: Password does not match!'}
    else
      user = User.new
      user.user_name = params['user_name']
      user.password = params['pass_word']
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
      session[:current_user_name] = user.user_name
      session[:current_user_type] = user.user_type
      redirect_to reports_url
    end
  end

  def edit
    # check and get current user id via before_action

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
    # check and get current user id via before_action

    if params['pass_word'] != params['confirm_pw']
      redirect_to edit_user_url, flash: {update_err: 'User Update Error: Password does not match!'}
    else
      @current_user.email = params['email_add']
      @current_user.password = params['pass_word']
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
