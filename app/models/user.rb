class User < ActiveRecord::Base

  hobo_user_model # Don't put anything above this

  fields do
    username :string
    email_address :email_address, :login => true, :validate => false, :null => false
    administrator :boolean, :default => false, :null => false
    timestamps
  end
  attr_accessible :email_address, :username, :nickname
  set_search_columns

  include HoboOmniauth::UserAuth

  # This gives admin rights to the first sign-up.
  # Just remove it if you don't want that
  before_create { |user| user.administrator = true if user.class.count == 0 }

  children :recipes, :questions, :answers

  scope :administrator, :conditions => {:administrator => true}

  has_many :recipes, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  #named_scope :recently_active, :order => "(select created_at from recipes where recipes.user_id = users.id order by created_at limit 1)",
  #                              :limit => 6
  scope :recently_active,  order("(select created_at from recipes where recipes.user_id = users.id order by created_at limit 1)").limit(6)

  def account_active?
    true
  end

  # alias, omniauth uses nickname for the username
  def nickname=(s)
    self.username=s
  end

  # --- Hobo Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    acting_user.administrator? || (acting_user == self && only_changed?(:crypted_password, :email_address))
    # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end

