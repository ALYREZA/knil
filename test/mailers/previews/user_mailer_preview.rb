# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/signup
  def signup
    user = User.find(1)
    UserMailer.with(user: user).signup
  end

end
