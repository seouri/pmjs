class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_params
  
  def set_params
    @year = (params[:year] || 0).to_i
    @per_page = 30
    @offset = (params[:o] || 0).to_i
  end
end
