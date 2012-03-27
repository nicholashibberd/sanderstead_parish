class ApplicationController < ActionController::Base
  helper Cms::Engine.helpers  
  protect_from_forgery
end
