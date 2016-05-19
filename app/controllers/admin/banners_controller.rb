class Admin::BannersController < ApplicationController
  layout "admin"
  http_basic_authenticate_with :name => "medicalboss", :password => "BOSSmedical54321"  

  skip_before_filter :require_login


  # GET /admin/banners
  # GET /admin/banners.json
  def index
    @admin_banners = Admin::Banner.all

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @admin_banners }
    end
  end

  # GET /admin/banners/1
  # GET /admin/banners/1.json
  def show
    @admin_banner = Admin::Banner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_banner }
    end
  end

  # GET /admin/banners/new
  # GET /admin/banners/new.json
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

    respond_to do |format|
      if @admin_banner.save
        format.html { redirect_to @admin_banner, notice: 'Banner was successfully created.' }
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

    respond_to do |format|
      if @admin_banner.update_attributes(params[:admin_banner])
        format.html { redirect_to @admin_banner, notice: 'Banner was successfully updated.' }
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
end
