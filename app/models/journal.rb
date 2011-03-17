class Journal < ActiveRecord::Base
  has_many :journal_subjects
  has_many :subjects, :through => :journal_subjects

  def to_s
    abbr
  end

  def to_l
    self
  end

  def articles
    articles_counts.split(/\|/).map {|s| s.to_i}
  end

  def top(year=0, offset=0)
    journal_subjects.top(year).includes(:subject).offset(offset)
  end
end
