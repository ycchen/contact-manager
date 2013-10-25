class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from AbstractController::ActionNotFound, :with => :not_found
  rescue_from ActionController::RoutingError, :with => :not_found
  
  before_filter :global_user

  helper_method :is_admin?
  
  def global_user
     Contact.login_user = current_user
  end

  def not_found
    show_error('Object is not found!')
  end

  def show_error(msg='Object does not exist!')
    flash[:notice] = msg
    redirect_to root_path
  end

  def is_admin?
    unless current_user && current_user.admin?
      flash[:notice] = "You are not authroize to access this page!"
      redirect_to root_path
    end
  end


end
