class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup.subject
  #
  def signup
    @user = params[:user]
    @dir = I18n.locale == :fa ? "right" : "left"
    secrets = Rails.application.secrets[:secret_key_base]
    key = @user.email + secrets
    @sha2 = Digest::SHA2.new(256).hexdigest key
    
    mail(to: @user.email, subject: "Wellcome to Knil.ir - Verify email address")
  end
end
