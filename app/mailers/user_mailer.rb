class UserMailer < ApplicationMailer
  default from: "tookiti@gmail.com"

  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'TookiTi! activate your account'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'TookiTi! reset your password'
  end
end
