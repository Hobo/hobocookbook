
class Blog < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title :string, :null => false
    body  :text, :null => false, :limit => 1.megabyte
    slug  :string, :null => false, :index => true
    metadata  :serialized
    edit_link :string
    timestamps
  end
  attr_accessible :title, :body, :slug, :metadata, :edit_link
  default_scope order('created_at DESC')

  def next
    Blog.where("created_at < ?", created_at).limit(1).first
  end

  def previous
    Blog.unscoped.where("created_at > ?", created_at).order('created_at ASC').limit(1).first
  end

  def to_param
    slug
  end

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
