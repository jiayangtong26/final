class ReportsController < ApplicationController

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

	def index

    # check and get current user id via before_action

    latest_report_count = 5
    report_each_page = 3

    if not params.has_key?("current_page")
      @current_page = 1
    else
      @current_page = params["current_page"].to_i
    end

    if (not params.has_key?("search_key_word")) || (not params.has_key?("search_by")) || (params['search_by'] != 'tag' && params['search_by'] != 'title' && params['search_by'] != 'favorite')
      prefer_tag = Preference.where(:user_ID => session["current_user_id"])
      subject_list = Subject.where(:tag_ID => prefer_tag.select("tag_ID")).limit(100)
      check_report_list = Report.where(:id => subject_list.select("report_ID")).order(posted_date: :desc).limit(report_each_page + 1).offset((@current_page - 1) * report_each_page)
      @highlight_report_list = check_report_list.order(posted_date: :desc).first(report_each_page)
      @report_type_prompt = 'Recommanded News'
      flash['search_by'] = nil
      
    elsif params['search_by'] == 'tag'
      @report_type_prompt = 'Search by Tag'
      tag_got = Tag.find_by(:tag_name => params[:search_key_word])
      if not tag_got.nil?
        subject_list = Subject.where(:tag_ID => tag_got.id).limit(100)
        check_report_list = Report.where(:id => subject_list.select('report_ID')).order(posted_date: :desc).limit(report_each_page + 1).offset((@current_page - 1) * report_each_page)
        @highlight_report_list = check_report_list.order(posted_date: :desc).first(report_each_page)
      end
      flash['search_by'] = 'tag'
      flash['key_word'] = params['search_key_word']
    elsif params['search_by'] == 'title'
      @report_type_prompt = 'Search by Title'
      check_report_list = Report.where("title like ?", "%#{params[:search_key_word]}%").order(posted_date: :desc).limit(report_each_page + 1).offset((@current_page - 1) * report_each_page)
      @highlight_report_list = check_report_list.order(posted_date: :desc).first(report_each_page)
      flash['search_by'] = 'title'
      flash['key_word'] = params['search_key_word']
    elsif params['search_by'] == 'favorite'
      @report_type_prompt = 'Favorite News'
      flash['search_by'] = 'favorite'
      my_favorite = Favorite.where(:user_ID => @current_user.id).limit(100)
      check_report_list = Report.where(:id => my_favorite.select("report_ID")).order(posted_date: :desc).limit(report_each_page + 1).offset((@current_page - 1) * report_each_page)
      @highlight_report_list = check_report_list.order(posted_date: :desc).first(report_each_page)
    end

    if check_report_list.nil? or check_report_list.count < (report_each_page + 1)
      @last_page = true
    else
      @last_page = false
    end

    @latest_report_list = Report.order(posted_date: :desc).first(latest_report_count)
	end

	def create

    # check and get current user id via before_action

		report_new = Report.new
    report_new.title = params["title"]
    report_new.content = params["content"]
    report_new.posted_date = Time.now
    report_new.user_ID = @current_user.id
    report_new.save

    params["tags"].split(';').each do |contained_tag|
        tag_got = Tag.find_by(:tag_name => contained_tag)
        if tag_got.nil?
          tag_got = Tag.new
          tag_got.tag_name = contained_tag
          tag_got.save
        end

        subject_new = Subject.new
        subject_new.report_ID = report_new.id
        subject_new.tag_ID = tag_got.id
        subject_new.save
    end

    redirect_to report_url(report_new.id)
	end

	def new

    # check and get current user id via before_action

    if @current_user.user_type == 'reader'
      redirect_to reports_url, flash: {error: 'Cannot post report'}
    end
	end

	def edit

		# check and get current user id via before_action

    @report_old = Report.find_by(:id => params["id"], :user_ID => session["current_user_id"])
    if not @report_old.nil?
      @tag_str = ''
      subject_contained = Subject.where(:report_ID => @report_old.id)
      tag_list = Tag.where(:id => subject_contained.select('tag_ID'))
      tag_list.each do |tag_old|
        if @tag_str == ''
          @tag_str = tag_old.tag_name
        else
          @tag_str = @tag_str + ';' + tag_old.tag_name
        end
      end
    else
      redirect_to reports_url, flash: {error: 'Cannot edit the report'}
    end
	end

	def show

    # check and get current user id via before_action

		@report = Report.find_by(:id => params["id"])
    @author = User.find_by(:id => @report.user_ID)
    subject_related = Subject.where(:report_ID => params["id"])
    @tag_list = Tag.where(:id => subject_related.select("tag_ID"))
    preference_list = Preference.where(:user_ID => session['current_user_id'])
    @suggested_tag = @tag_list.where.not(:id => preference_list.select("tag_ID"))
    @current_report_id = params["id"]
    favorite_check = Favorite.where(:user_ID => session["current_user_id"], :report_ID => @report.id)
    if favorite_check.nil? || favorite_check.count < 1
      @my_favorite = false
    else
      @my_favorite = true
    end
	end

	def update

    # check and get current user id via before_action
    
    report_update = Report.find_by(:id => params["id"], :user_ID => session["current_user_id"])
    if not report_update.nil?
      report_update.title = params['title']
      report_update.content = params['content']
      report_update.save
      subject_old = Subject.where(:report_ID => report_update.id)
      subject_old.delete_all

      params['tags'].split(';').each do |tag_new|
        tag_got = Tag.find_by(:tag_name => tag_new)
        if tag_got.nil?
          tag_got = Tag.new
          tag_got.tag_name = tag_new
          tag_got.save
        end
        subject_new = Subject.new
        subject_new.report_ID = report_update.id
        subject_new.tag_ID = tag_got.id
        subject_new.save
      end
      redirect_to report_url(report_update.id)
    else
      redirect_to reports_url, flash: {error: 'Cannot update the report'}
    end
	end

	def destroy

    # check and get current user id via before_action

    report_del = Report.find_by(:id => params["id"], :user_ID => session["current_user_id"])
    if (not report_del.nil?) && (not @current_user.nil?) && @current_user.id == report_del.user_ID
      report_del.destroy
      redirect_to reports_url
    else
    	redirect_to reports_url, flash: {error: 'Cannot delete the report'}
    end
	end
end
