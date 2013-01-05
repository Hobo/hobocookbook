class UseMediumtext < ActiveRecord::Migration
  def up
    change_column :manual_sections, :body, :text, :limit => 1.megabyte
    change_column :manual_subsections, :body, :text, :limit => 1.megabyte
    change_column :tutorials, :body, :text, :limit => 1.megabyte
  end

  def down
  end
end
