class Question < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    subject     :string, :name => true
    description :optional_markdown
    markdown    :boolean
    timestamps
  end
  
  has_many :answers, :dependent => :destroy
  has_many :recipes, :through => :answers, :uniq => true

  set_search_columns # to none

  children :answers

  include OwnedModel

end
