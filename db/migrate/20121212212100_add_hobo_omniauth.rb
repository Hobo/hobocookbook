class AddHoboOmniauth < ActiveRecord::Migration
  def self.up
    add_column :users, :uid, :string, :required => true
    remove_column :users, :state
    add_index :users, [:uid], :unique => true

    add_index :api_plugins_14, [:name]

    add_index :api_taglibs_14, [:name]

    add_index :api_tag_defs_14, [:tag]

    create_table :authorizations
  end

  def self.down
    add_column :users, :state, :string, :limit => 255, :default => "pending"
    remove_column :users, :uid
  end
end
