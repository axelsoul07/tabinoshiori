class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :likes, :destroy]
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @plan = @user.plans.build
    @plans = @user.plans.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      #redirect_toでshowアクションを実行
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user = User.find(session[:user_id])
    @user.destroy
    session[:user_id] = nil
    flash[:success] = 'アカウントを削除しました'
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.favoritings.page(params[:page])
    counts(@user)
    @plan = @user.plans.build
    @plans = @user.feed_favorite_plans.order('created_at DESC').page(params[:page])
  end
  
  begin
    def favoritings
      @user = User.find(params[:id])
      @favoritings = @user.favoritings.page(params[:page])
      counts(@user)
    end
    
    def favoriters
      @user = User.find(params[:id])
      @favoriters = @user.favoriters.page(params[:page])
      counts(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
