class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :show, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  include UsersHelper
  def new
    @user = User.new
  end

  def index
    @users = User.where(activated: FILL_IN).paginate page: params[:page]
  end

  def show
    @user = User.find_by params[:id]
    redirect_to root_url and return unless FILL_IN
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t"usercontroller.check"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = User.find_by params[:id]
  end

  def update
    @user = User.find_by params[:id]
    if @user.update_attributes user_params
      flash[:sucess] = t"usercontroller.sucess"
    else
      render :edit
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = t"userindex.delete"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t"usercontroller.please"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by params[:id]
    redirect_to root_url unless @user == current_user
  end

  # Confirms an admin user.
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end


