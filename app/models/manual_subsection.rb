class ManualSubsection < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title :string, :null => false
    body  :html, :null => false
    slug  :string, :index => true, :null => false
    edit_link :string
    position  :integer
    timestamps
  end
  belongs_to :manual_section
  attr_accessible :title, :body, :slug, :manual_section, :manual_section_id

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
