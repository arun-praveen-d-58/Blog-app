class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_user_email.subject
  #
  def new_user_email(user)
     @greeting = "Hi"
      @user = user
     @email = mail(to: user.email, subject: 'Welcome to My Awesome App')
  end
end
