class Journal < ActiveRecord::Base
  has_many :journal_subjects
  has_many :subjects, :through => :journal_subjects

  def to_s
    abbr
  end

  def top(year=0)
    journal_subjects.top(year).includes(:subject)
  end
end
