class CreateBlog < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string   :title, :null => false
      t.text     :body, :null => false, :limit => 1048576
      t.string   :slug, :null => false
      t.text     :metadata
      t.string   :edit_link
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :blogs, [:slug]
    add_index :blogs, [:created_at]
  end

  def self.down
    drop_table :blogs
  end
end
