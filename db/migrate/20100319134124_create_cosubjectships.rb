class CreateCosubjectships < ActiveRecord::Migration
  def self.up
    create_table :cosubjectships do |t|
      t.integer :subject_id
      t.integer :cosubject_id
      t.integer :articles_count, :limit => 3
      t.integer :start_year,      :default => 0,  :limit => 2
      t.integer :end_year,        :default => 0,  :limit => 2
      t.text    :articles_counts
    end
    add_index :cosubjectships, [:subject_id, :articles_count]
  end

  def self.down
    drop_table :cosubjectships
  end
end
