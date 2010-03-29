class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_params
  
  def set_params
    @decade = (params[:decade] || 0).to_i
    @per_page = 15
    @offset = (params[:o] || 0).to_i
  end
end
