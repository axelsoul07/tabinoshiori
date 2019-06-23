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

  def destroy
    @plan.destroy
    flash[:success] = 'プランを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def plan_params
    params.require(:plan).permit(:title)
  end
  
  def correct_user
    @plan = current_user.plans.find_by(id: params[:id])
    unless @plan
      redirect_to root_url
    end  
  end
end
