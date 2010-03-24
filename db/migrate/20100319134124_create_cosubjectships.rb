class CreateCosubjectships < ActiveRecord::Migration
  def self.up
    create_table :cosubjectships do |t|
      t.integer :subject_id
      t.integer :cosubject_id
      t.integer :articles_count
    end
    add_index :cosubjectships, [:subject_id, :articles_count]
  end

  def self.down
    drop_table :cosubjectships
  end
end
