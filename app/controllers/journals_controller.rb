class JournalsController < ApplicationController
  def index
    @journals = Journal.order("articles_count desc").limit(@per_page).offset(@offset)
    @journals = @journals.where("abbr like ?", params[:q] + '%') if params[:q]
  end

  def show
    @journal = Journal.find(params[:id])
  end
end