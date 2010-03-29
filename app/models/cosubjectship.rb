class Cosubjectship < ActiveRecord::Base
  belongs_to :subject
  belongs_to :cosubject, :class_name => "Subject", :foreign_key => "cosubject_id"

  def to_s
    cosubject.term
  end

  def to_l
    cosubject
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
end
