# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100319134124) do

  create_table "cosubjectships", :force => true do |t|
    t.integer "subject_id"
    t.integer "cosubject_id"
    t.integer "articles_count", :limit => 3
  end

  add_index "cosubjectships", ["subject_id", "articles_count"], :name => "index_cosubjectships_on_subject_id_and_articles_count"

  create_table "journal_subjects", :force => true do |t|
    t.integer "journal_id"
    t.integer "year",                      :limit => 2, :default => 0
    t.integer "subject_id"
    t.integer "direct_articles_count",     :limit => 2, :default => 0
    t.integer "descendant_articles_count", :limit => 3, :default => 0
    t.integer "articles_count",            :limit => 3, :default => 0
  end

  add_index "journal_subjects", ["journal_id", "year", "direct_articles_count", "articles_count"], :name => "index_journal_subjects_on_journal_id_year_direct_articles_count"
  add_index "journal_subjects", ["subject_id", "year", "direct_articles_count", "articles_count"], :name => "index_journal_subjects_on_subject_id_year_direct_articles_count"

  create_table "journals", :force => true do |t|
    t.string  "abbr",            :limit => 128
    t.integer "articles_count",  :limit => 3,   :default => 0
    t.integer "start_year",      :limit => 2,   :default => 0
    t.integer "end_year",        :limit => 2,   :default => 0
    t.text    "articles_counts"
  end

  add_index "journals", ["abbr"], :name => "index_journals_on_abbr"
  add_index "journals", ["articles_count"], :name => "index_journals_on_articles_count"

  create_table "mesh_trees", :force => true do |t|
    t.string  "tree_number", :limit => 64
    t.integer "subject_id"
    t.integer "parent_id"
  end

  add_index "mesh_trees", ["parent_id"], :name => "index_mesh_trees_on_parent_id"

  create_table "subjects", :force => true do |t|
    t.string  "term",                       :limit => 128
    t.integer "direct_articles_count",      :limit => 3,   :default => 0
    t.integer "descendant_articles_count",                 :default => 0
    t.integer "articles_count",                            :default => 0
    t.integer "start_year",                 :limit => 2,   :default => 0
    t.integer "end_year",                   :limit => 2,   :default => 0
    t.text    "direct_articles_counts"
    t.text    "descendant_articles_counts"
    t.text    "articles_counts"
  end

  add_index "subjects", ["articles_count"], :name => "index_subjects_on_articles_count"
  add_index "subjects", ["direct_articles_count"], :name => "index_subjects_on_direct_articles_count"
  add_index "subjects", ["term"], :name => "index_subjects_on_term"

end
