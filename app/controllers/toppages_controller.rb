class ToppagesController < ApplicationController
  def index
    if logged_in?
      @plan = current_user.plans.build  # form_for 用
      @plans = current_user.feed_plans.order('created_at DESC').page(params[:page])
      
      
      @user = current_user
      @plan = current_user.plans.build  # form_for 用
      @plans = current_user.feed_followoing_plans.order('created_at DESC').page(params[:page])
      #ログインユーザなら全て表示、そうでなければ公開設定のものだけ表示
    end
  end
end