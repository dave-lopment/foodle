class UsersController < ApplicationController
  before_action only: [:index, :edit, :show] do
    allow_only_admin(new_user_session_path)
  end
  before_action :correct_user, only: [:update]

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    if user_signed_in?
      if current_user.try(:admin?) || current_user.id == params[:id]
        User.find(params[:id]).destroy
        redirect_to users_path
      end
    else
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def profile_edit
    @user = current_user
  end 

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :postal, :city, :street, :password, :password_confirmation)
    end

    def correct_user
      if current_user
        @user = User.find(params[:id])
	redirect_to(new_user_session_path) unless (current_user[:admin] == true || @user == current_user)
      else
        redirect_to(new_user_session_path)
      end
    end
end
