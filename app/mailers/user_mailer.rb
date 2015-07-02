class UserMailer < ActionMailer::Base
  default from: 'Your To Do List App'

  def welcome_email(user)
    #any instance variable defined in a method are available to the views
    @user = user
    mail(to: @user.email, subject: 'Welcome to the To Do App')
  end
end
