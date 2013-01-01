class AddManual < ActiveRecord::Migration
  def self.up
    create_table :manual_sections do |t|
      t.string   :title, :null => false
      t.text     :body, :null => false
      t.string   :slug, :null => false
      t.string   :edit_link
      t.integer  :position
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :manual_sections, [:slug]

    create_table :manual_subsections do |t|
      t.string   :title, :null => false
      t.text     :body, :null => false
      t.string   :slug, :null => false
      t.string   :edit_link
      t.integer  :position
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :manual_section_id
    end
    add_index :manual_subsections, [:slug]
    add_index :manual_subsections, [:manual_section_id]
  end

  def self.down
    drop_table :manual_sections
    drop_table :manual_subsections
  end
end
