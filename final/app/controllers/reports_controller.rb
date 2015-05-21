class ReportsController < ApplicationController

	before_action :get_user, :only => [:index, :show, :edit, :new, :create]

  def get_user
    @current_user = User.find_by(:id => session["current_user_id"])
  end

	def index
		if not session.has_key?(:current_user_id)
			redirect_to root_url, flash: {login_err: 'Please login first'}
		end
		prefer_tag = Preference.where(:user_ID => session["current_user_id"])
    subject_list = Subject.where(:tag_ID => prefer_tag.select("tag_ID"))
    @highlight_report_list = Report.where(:id => subject_list.select("report_ID"))
    @report_type_prompt = 'suggested report'
    @latest_report_list = Report.order(posted_date: :desc).first(5)
	end

	def create
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
		if not session.has_key?(:current_user_id)
			redirect_to root_url, flash: {login_err: 'Please login first'}
		end
    if @current_user.user_type == 'reader'
      redirect_to reports_url, flash: {error: 'Cannot post report'}
    end
	end

	def edit
		if not session.has_key?(:current_user_id)
			redirect_to root_url, flash: {login_err: 'Please login first'}
		end
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
		if not session.has_key?(:current_user_id)
			redirect_to root_url, flash: {login_err: 'Please login first'}
		end
		@report = Report.find_by(:id => params["id"])
    @author = User.find_by(:id => @report.user_ID)
    subject_related = Subject.where(:report_ID => params["id"])
    @tag_list = Tag.where(:id => subject_related.select("tag_ID"))
	end

	def update
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
    report_del = Report.find_by(:id => params["id"], :user_ID => session["current_user_id"])
    if not report_del.nil?
      report_del.destroy
      redirect_to reports_url
    else
    	redirect_to reports_url, flash: {error: 'Cannot delete the report'}
    end
	end
end
