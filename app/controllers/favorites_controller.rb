class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @plan = Plan.find(params[:plan_id])
    unless @plan.favoriting?(current_user)
      @plan.favoriting(current_user)
      @plan.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
    redirect_back(fallback_location: root_path)
    
    #flash[:success] = '栞をお気に入りに追加しました'
    #redirect_to user
  end

  def destroy
    @plan = Favorite.find(params[:id]).plan
    if @plan.favoriting?(current_user)
      @plan.unfavorite(current_user)
      @plan.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
    redirect_back(fallback_location: root_path)
    
    #flash[:success] = '栞のお気に入りを解除しました。'
    #redirect_to user
  end
end
