class UserController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      UserNotifier.welcome_email(@user).deliver
      redirect_to(@user, :notice => 'User created')
    else
      render :action => 'new'
    end
  end
end
