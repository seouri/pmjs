class Subject < ActiveRecord::Base
  has_many :journal_subjects
  has_many :journals, :through => :journal_subjects
  has_many :mesh_trees
  has_many :cosubjectships
  has_many :cosubjects, :through => :cosubjectships, :order => "articles_count desc"

  def to_s
    term
  end

  def articles
    articles_counts.split(/\|/).map {|s| s.to_i}
  end

  def direct_articles
    direct_articles_counts.split(/\|/).map {|s| s.to_i}
  end

  def descendant_articles
    descendant_articles_counts.split(/\|/).map {|s| s.to_i}
  end

  def top(year)
    journal_subjects.top(year).includes(:journal)
  end

  def top_cosubjects
    cosubjectships.order("`cosubjectships`.articles_count desc").limit(20).includes(:subject)
  end
end
