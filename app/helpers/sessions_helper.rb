module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    #!を2回、値があればnotnotでtrueを返す
    !!current_user
  end
end
