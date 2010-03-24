class JournalSubject < ActiveRecord::Base
  belongs_to :journal
  belongs_to :subject
  
  scope :top, lambda {|year| where(:year => year).order("direct_articles_count desc, articles_count desc").limit(20)}
end
