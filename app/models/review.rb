class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  # default_scope order('updated_at DESC')
end
