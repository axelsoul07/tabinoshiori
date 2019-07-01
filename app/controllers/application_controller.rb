class ApplicationController < ActionController::Base
  before_action :basic if Rails.env.production?

  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_plans = user.plans.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end

  def basic
    authenticate_or_request_with_http_basic do |user, pass|
      user == 'tabino' && pass == 'shiori'
    end
  end

end
