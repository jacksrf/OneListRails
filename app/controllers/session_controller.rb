class SessionController < ApplicationController
  def new
    render :new
  end

  def create
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            @message = false
            session[:user_id] = user.id
            session[:username] = params[:username]
            redirect_to '/'
        else
            @error = true
            render :new
        end
    end

  def destroy
    reset_session
    @message = false
    redirect_to '/login'
  end
end
