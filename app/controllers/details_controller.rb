class DetailsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update, :destroy]
  
  def new
    @plan = Plan.find(params[:id])
    @detail = @plan.details.build
  end

  def create
    @plan = Plan.find(params[:id])
    @detail = @plan.details.build(detail_params)
    
    if @detail.save
      flash[:success] = '栞にイベントを追加しました'
      redirect_to plan_path
    else
      flash.now[:danger] = 'イベントの追加に失敗しました。'
      render :new
    end

  end

  def edit
    @plan = Plan.find(params[:id])
    @detail = Detail.find(params[:detail_id])
  end

  def update
    @plan = Plan.find(params[:id])
    
    @detail = @plan.details.build(detail_params)
    @detail = Detail.find(params[:detail_id])
    if @detail.update(detail_params)
      flash[:success] = 'イベントは正常に更新されました'
      redirect_to plan_path
    else
      flash.now[:danger] = 'イベントの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @detail = Detail.find(params[:detail_id])
    @detail.destroy
    flash[:success] = 'イベントを削除しました'
    redirect_back(fallback_location: plan_path)
  end
  
  private

  def detail_params
    params[:detail].permit(:destination, :amount, :content, :start_at, :end_at, :site_url, :phone, :address)
  end
  
  def correct_user
    @plan = current_user.plans.find_by(id: params[:id])
    unless @plan
      redirect_to root_url
    end  
  end
  

end
