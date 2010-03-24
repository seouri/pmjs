class SubjectsController < ApplicationController
  def index
    @subjects = Subject.order("direct_articles_count desc").limit(@per_page).offset(@offset)
    @subjects = @subjects.where("term like ?", params[:q] + '%') if params[:q]
  end

  def show
    @subject = Subject.find(params[:id])
  end
end
