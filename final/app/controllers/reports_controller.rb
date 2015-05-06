class ReportsController < ApplicationController

  def index
    @reports_list = Report.all
  end

  def show
    @report = Report.find_by(:id => params['id'])
  end

  def new
  end

  def create
    report = Report.new
    report.title = params[:title]
    report.content = params[:content]
    report.save
    redirect_to reports_url
  end

  def edit
    @report = Report.find_by(:id => params['id'])
  end

  def update
    report = Report.find_by(:id => params['id'])
    report.title = params[:title]
    report.content = params[:content]
    report.save
    redirect_to report_url(params['id'])
  end

  def destroy
    report = Report.find_by(:id => params['id'])
    report.delete
    redirect_to reports_url
  end

end
