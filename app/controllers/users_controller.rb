class UsersController < ApplicationController
  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    #flash[:success] = "User deleted"
    redirect_to users_path
  end
end
