class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery prepend: true, with: :exception
    helper_method :current_user    
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        else
            @current_user = nil
        end
    end

    private

    def user_not_authorized(exception)
        policy_name = exception.policy.class.to_s.underscore
        flash[:notice] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
        redirect_to(request.referrer || root_path)
    end

end
