class CreateJournalSubjects < ActiveRecord::Migration
  def self.up
    create_table :journal_subjects do |t|
      t.integer :journal_id
      t.integer :year,                      :default => 0, :limit => 2
      t.integer :subject_id
      t.integer :direct_articles_count,     :default => 0, :limit => 2
      t.integer :descendant_articles_count, :default => 0, :limit => 3
      t.integer :articles_count,            :default => 0, :limit => 3
    end
    add_index :journal_subjects, [:journal_id, :year, :direct_articles_count, :articles_count], :name => 'index_journal_subjects_on_journal_id_year_direct_articles_count'
    add_index :journal_subjects, [:subject_id, :year, :direct_articles_count, :articles_count], :name => 'index_journal_subjects_on_subject_id_year_direct_articles_count'
  end

  def self.down
    drop_table :journal_subjects
  end
end
