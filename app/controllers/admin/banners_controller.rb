# encoding: utf-8

class Admin::BannersController < ApplicationController
  layout "admin"
  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"  

  skip_before_filter :require_login

  # after_filter  :active, :only => [ :update ]
  before_filter :banner_params
  before_filter :expired_banners
  
  # GET /admin/banners
  # GET /admin/banners.json
  def index
    @admin_banners = Admin::Banner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_banners }
    end
  end

  def new
    @admin_banner = Admin::Banner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_banner }
    end
  end

  # GET /admin/banners/1/edit
  def edit
    @admin_banner = Admin::Banner.find(params[:id])
  end

  # POST /admin/banners
  # POST /admin/banners.json
  def create
    @admin_banner = Admin::Banner.new(params[:admin_banner])
    banner_params[:active] ? @admin_banner.started_at = DateTime.now() : @admin_banner.started_at = nil

    respond_to do |format|
      if @admin_banner.save
        format.html { redirect_to admin_banners_url, notice: "Баннер был успешно создан" }
        format.json { render json: @admin_banner, status: :created, location: @admin_banner }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/banners/1
  # PUT /admin/banners/1.json
  def update
    @admin_banner = Admin::Banner.find(params[:id])
    #params[:admin_banner][:active] ? @admin_banner.started_at = DateTime.now() : @admin_banner.started_at = nil
    banner_params[:active] ? @admin_banner.started_at = DateTime.now() : @admin_banner.started_at = nil
 
    respond_to do |format|
      if @admin_banner.update_attributes(params[:admin_banner])
        format.html { redirect_to admin_banners_url, notice: "Баннер был успешно обновлен" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/banners/1
  # DELETE /admin/banners/1.json
  def destroy
    @admin_banner = Admin::Banner.find(params[:id])
    @admin_banner.destroy

    respond_to do |format|
      format.html { redirect_to admin_banners_url }
      format.json { head :no_content }
    end
  end

  def banner_params
    params[:admin_banner]
  end

  def expired_banners
   @expired_banners = Admin::Banner.where("started_at < ?", (DateTime.now() - 1.month)).all
   @expired_banners.each do |e|
     e.update_attribute(:active, 'false')
   end
  end 

end

