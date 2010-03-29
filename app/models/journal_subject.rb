class JournalSubject < ActiveRecord::Base
  belongs_to :journal
  belongs_to :subject
  
  scope :top, lambda {|decade| where(:year => decade).order("direct_articles_count desc, articles_count desc").limit(15)}

  def to_s
    
  end

  def to_l
    
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
