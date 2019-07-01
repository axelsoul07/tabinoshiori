class PlansController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      flash[:success] = '旅行プランを作成しました'
      redirect_to root_url
    else
      @plans = current_user.feed_plans.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '旅行プランの作成に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def show
    require_user_public
    @plan = Plan.find(params[:id])
    @details = @plan.details.order('start_at ASC')
  end
  
  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])

    if @plan.update(plan_params)
      flash[:success] = '旅の栞名は正常に更新されました'
      redirect_to plan_path
    else
      flash.now[:danger] = '旅の栞名の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @plan.destroy
    flash[:success] = 'プランを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def plan_params
    params.require(:plan).permit(:title, :public)
  end
  
  def correct_user
    @plan = current_user.plans.find_by(id: params[:id])
    unless @plan
      redirect_to root_url
    end  
  end
  
  def plan_id
    params[:id]
  end
  
  def require_user_public
    @plan = Plan.find(params[:id])
    if (current_user.id != @plan.user_id) && (@plan.public == false)
      redirect_to root_url
    end
  end
end
