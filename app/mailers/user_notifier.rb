class UserNotifier < ApplicationMailer
  default :from => 'onelistupdates@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end

  def send_invite_email(invite,sender)
    @invite = invite
    @user = sender
    mail( :to => @invite.email,
    :subject => 'Youve been invited to a group! Go to onelist.io/signup to join!',
    :other => @user )
  end

  def send_reset_email(user,password)
    @user = user
    mail( :to => @user.email,
    :subject => 'Reset your OneList. password!',
    :other => @random_password)
  end

end
