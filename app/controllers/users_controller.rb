class UsersController < ApplicationController
  before_action :check_authentication, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    
      @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          session[:user_id] = @user.id
          UserMailer.with(user: @user).signup.deliver_later
          format.html { redirect_to "/admin", notice: I18n.t('notice.success_user') }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params_edit)
        format.html { redirect_to show_user_path , notice: t('notice.success_update_user') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def verify
    email = URI.decode(params[:email])
    id = params[:id]
    secrets = Rails.application.secrets[:secret_key_base]
    key = email + secrets
    sha2 = Digest::SHA2.new(256).hexdigest key
    if id == sha2
      user = User.find_by(email: email)
      if user.status == 0
        user.status = 1
        user.save()
        redirect_to "/admin/login", notice: t('notice.account_active')
      else
        redirect_to "/admin/login", notice: t('notice.wasActive')
      end
    else
      redirect_to "/admin/login", notice: t('notice.wrong_active_code')
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(current_user.id)
    end

    # check use has access to this data or not
    def check_authentication
      unless session[:user_id]
        session[:user_id] = nil
        redirect_to "/admin/login", notice: t('notice.ask_login') 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end

    def user_params_edit
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
