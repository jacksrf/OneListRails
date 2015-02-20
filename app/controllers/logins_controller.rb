class LoginsController < ApplicationController

  def new
    @login = Login.new
  end

  def create
    @login = Login.create(login_params)
    @user = User.find_by(email: @login.email)
    @random_password = Array.new(10).map { (65 + rand(58)).chr }.join
    @user.password = @random_password
    binding.pry
    @user.save!
    UserNotifier.send_reset_email(@user,@random_password).deliver
    @message = "true"
    redirect_to '/login'
  end

private
    def login_params
      params.require(:login).permit(:email)
    end

end
