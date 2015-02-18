class UserNotifier < ApplicationMailer
  default :from => 'jacksrf@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end

  def send_invite_email(invite)
    @invite = invite
    mail( :to => @invite.email,
    :subject => 'Youve been invited to a group! Go to onelist.io/signup to join!' )
  end
end