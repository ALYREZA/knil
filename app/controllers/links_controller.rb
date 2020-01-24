class LinksController < ApplicationController
  before_action :checkUser, except: [:goto, :addToAnalytics, :api ]  
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    @links = Link.where(user_id: current_user.id)
  end

  # GET /links/1
  # GET /links/1.json
  def show
    nowTime = Time.now
    fiveDayAgo = nowTime - 5.days
    @thisTime = fiveDayAgo()
    @analytic = Analytic.where(link_id: @link.id, user_id: @current_user.id)
                        .where("created_at >= ?", fiveDayAgo)
                        .to_json(:except => [:id,:link_id, :user_id,:updated_at])
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.build(link_params)
    authorize @link
    respond_to do |format|
      if @link.save
        format.html { redirect_to link_path(@link.uuid), notice: t('notice.success_create_link') }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    authorize @link
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_path(@link.uuid), notice: t('notice.success_update_link') }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: t('notice.success_destroy_link') }
      format.json { head :no_content }
    end
  end


  def goto
    link = Link.find_by(uuid: params[:id])
    begin
      redirect_to link.url, status: 301
      use_link(link.url)
      addToAnalytics(link)
    rescue => exception
      render plain: exception
    end
  end

  def api
    begin
      @user = User.find_by!(username: params[:username])
      @links = @user.links
      render :api, layout: "linksPage"
    rescue
      redirect_to "/"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find_by(uuid: params[:id])
    end

    def fiveDayAgo
      days = Array.new
      now = Time.now
      days << now.to_f * 1000
      puts "salam"
      for dd in (1...5)
        newDays = now - dd.days
        convertDays = newDays.to_f * 1000
        days << convertDays
      end
      return days.to_json
    end

    def use_link(link)
      client = DeviceDetector.new(request.user_agent)
      splitUrl = URI.split(link)
      p "#{splitUrl[2]} #{client.device_type} #{client.device_name}"
    end

    def addToAnalytics(linkModel)
      client = DeviceDetector.new(request.user_agent)
      anal = Analytic.new
      anal.ip = request.remote_ip
      anal.link_id = linkModel.id
      anal.user_id = linkModel.user_id
      anal.device = client.device_name
      anal.device_type= client.device_type
      anal.os= client.os_name
      anal.browser= client.name
      anal.async.save()
    end

    def checkUser
      unless current_user
        session[:user_id] = nil
        redirect_to "/admin/login", notice: t('notice.ask_login')
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :url)
    end
end
