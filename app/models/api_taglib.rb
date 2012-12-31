class ApiTaglib < ActiveRecord::Base

  # so we can coexist with other
  # versions of the cookbook
  set_table_name "api_taglibs_14"

  hobo_model # Don't put anything above this

  def self.find(*args)
    if args.first.is_a?(String) && args.first =~ /[a-zA-Z0-9_-]+/
      find_by_name args.first
    else
      super
    end
  end

  def to_param
    to_s
  end

  fields do
    name        :string, :index => true
    short_description :html
    description :html
    edit_link :string
    timestamps
  end
  attr_accessible :name, :short_description, :description, :edit_link, :plugin, :plugin_id, :tags

  belongs_to :plugin, :class_name => "ApiPlugin"
  has_many :tags, :class_name => "ApiTagDef", :foreign_key => "taglib_id"

  set_default_order "name"

  # --- Hobo Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(attribute)
    true
  end

end
