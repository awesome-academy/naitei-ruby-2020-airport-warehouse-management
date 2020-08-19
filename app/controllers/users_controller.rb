class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index destroy)
  before_action :admin_user, only: :destroy
  before_action :find_user, only: :show

  def index
    @users = User.page(params[:page]).per Settings.pagination
  end

  def show
    return if @user

    flash[:warning] = t ".alert.user_not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "shared.welcome_to_the_sample_app"
      redirect_to @user
    else
      flash[:error] = t "shared.error_signup"
      render :new
    end
  end

  def destroy
    if User.find_by(id: params[:id])&.destroy
      flash[:success] = t ".alert.user_deleted"
    else
      flash[:error] = t ".alert.user_not_found"
    end

    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:error] = t ".alert.please_login."
    redirect_to login_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
  end
end