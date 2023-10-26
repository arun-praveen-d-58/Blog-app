class SignUpEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserMailer.new_user_email(user).deliver_now
  end
end


