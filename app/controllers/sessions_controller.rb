class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :checkUser, except: [:goto, :addToAnalytics, :api, :destroy ]

  def new
  end

  def create
    begin
      user = User.find_by_email!(params[:email])
      user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/admin", notice: t('notice.loggedIn')
    rescue => exception
      flash.now[:alert] = "Email or password is invalid"
        render "new"
    end
  end  
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: t('notice.loggedOut')
  end

  private

  def checkUser
    if session[:user_id]
      redirect_to "/admin", notice: t('notice.wasLogin') 
    end
  end

end
