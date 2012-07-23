class AdminController < ApplicationController
  include SessionsHelper
  protect_from_forgery

  layout 'admin'
  before_filter :login_required

  def login_required
    if signed_in?
      return true
    end
    flash[:error] = 'Please login to continue'
    redirect_to signin_path
  end
  
  def church_home
    
  end
end