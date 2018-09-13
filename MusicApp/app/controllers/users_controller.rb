class UsersController < ApplicationController

  def new
    @user = User.new #so we can not break forms?
    render :new # need to make this new view in users foler
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new #we want to render the login page again, with the errors
    end
  end

  def show
    @user = current_user
    render :show
  end

end
