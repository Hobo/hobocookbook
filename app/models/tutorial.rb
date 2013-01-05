class Tutorial < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title :string, :null => false
    body  :text, :null => false, :limit => 1.megabyte
    slug  :string, :null => false, :index => true
    edit_link :string
    position  :integer
    timestamps
  end
  attr_accessible :title, :body, :slug, :edit_link, :position
  set_search_columns :title, :body

  scope :visible, lambda { where("position IS NOT NULL").order_by("position") }

  # --- Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    false
  end

  def destroy_permitted?
    false
  end

  def view_permitted?(field)
    true
  end

end
