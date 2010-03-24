class CreateJournals < ActiveRecord::Migration
  def self.up
    create_table :journals do |t|
      t.string  :abbr,                            :limit => 128
      t.integer :articles_count,  :default => 0,  :limit => 3
      t.integer :start_year,      :default => 0,  :limit => 2
      t.integer :end_year,        :default => 0,  :limit => 2
      t.text    :articles_counts
    end
    add_index :journals, :abbr
    add_index :journals, :articles_count
  end

  def self.down
    drop_table :journals
  end
end
