class ApiTagDef < ActiveRecord::Base

  # so we can coexist with other
  # versions of the cookbook
  set_table_name "api_tag_defs_14"

  hobo_model # Don't put anything above this

  def to_param
    to_s
  end

  fields do
    tag               :string, :name => true, :index => true
    extension         :boolean
    polymorphic       :boolean
    for_type          :string

    short_description :html
    description       :html
    tag_attributes    :serialized, :class => Array
    tag_parameters    :serialized, :class => Array

    merge_attrs       :string
    merge_params      :string

    source            :text

    edit_link         :string

    timestamps
  end

  attr_accessible :tag, :extension, :polymorphic, :for_type, :short_description, :description, :tag_attributes, :tag_parameters, :merge_attrs, :merge_params, :source, :edit_link, :taglib, :taglib_id

  belongs_to :taglib, :class_name => "ApiTaglib"
  has_many   :comments, :class_name => "ApiTagComment", :dependent => :destroy

  #named_scope :no_for_type, :conditions => "for_type is null"
  scope :no_for_type, where("for_type is null")

  set_search_columns :tag, :short_description, :description, :source

  children :comments

  def full_name
    if taglib.plugin.name == taglib.name
      "#{tag} (#{taglib.name})"
    else
      "#{tag} (#{taglib.plugin.name}/#{taglib.name})"
    end
  end

  def def_line
    "<#{extension? ? 'extend' : 'def'} tag='#{tag}'#{' polymorphic' if polymorphic?}#{' for=\'' + for_type + '\'' if for_type}>"
  end

  def short_def_line
    "<#{full_name}#{' for=\'' + for_type + '\'' if for_type}>"
  end

  def short_short_def_line
    "<#{tag}#{' for=\'' + for_type + '\'' if for_type}>"
  end

  def typed_variants
    return [] if for_type
    ApiTagDef.find :all, :conditions => ["tag = ? AND (for_type is not null)", tag]
  end

  def all_attributes
    tag_attributes | merged_attributes
  end

  def merge_attrs_tagdef
    @merged_attrs_tagdef ||= ApiTagDef.find_by_tag(merge_attrs)
  end

  def merge_params_tagdef
    @merged_attrs_tagdef ||= ApiTagDef.find_by_tag(merge_attrs)
  end

  def merged_attributes
    merge_attrs_tagdef._?.all_attributes || []
  end

  def documented?
    !(description.blank? && short_description.blank?)
  end

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

