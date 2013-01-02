class Answer < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    body     OptionalMarkdown
    markdown :boolean
    timestamps
  end
  
  belongs_to :recipe
  belongs_to :question

  set_search_columns #none
  include OwnedModel

end
