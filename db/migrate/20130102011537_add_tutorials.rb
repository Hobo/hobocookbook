class AddTutorials < ActiveRecord::Migration
  def self.up
    create_table :tutorials do |t|
      t.string   :title, :null => false
      t.text     :body, :null => false
      t.string   :slug, :null => false
      t.string   :edit_link
      t.integer  :position
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :tutorials, [:slug]
  end

  def self.down
    drop_table :tutorials
  end
end
