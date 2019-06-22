class ToppagesController < ApplicationController
  def index
    if logged_in?
      @plan = current_user.plans.build  # form_for 用
      @plans = current_user.plans.order('created_at DESC').page(params[:page])
    end
  end
end
