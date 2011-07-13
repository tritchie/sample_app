class UsersController < ApplicationController
  before_filter :authenticate, :only => [ :edit, :update, :index, :destroy ]
  before_filter :correct_user, :only => [ :edit, :update ]
  before_filter :admin_user,   :only => :destroy
  before_filter :different_user, :only => :destroy
  before_filter :not_signed_in, :only => [ :new, :create]

  def new
    @user = User.new
    @title = "Sign up"
    @button_name = 'Submit'
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def index
    @title = "All Users"
    @users = User.paginate(:page => params[:page])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample app!"
      redirect_to @user
    else
      @title = 'Sign up'
      @user.password = ''
      @user.password_confirmation = ''
      render 'new'
    end
  end

  def edit
    @title = 'Edit user'
    @button_name = 'Update'
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User has been updated"
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted."
    redirect_to users_path
  end
  private
  def not_signed_in
    redirect_to(root_path) if signed_in?
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  def different_user
    @user = User.find(params[:id])
    redirect_to(users_path) if current_user?(@user)
  end
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
