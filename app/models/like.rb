class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :prototype
  validates :user_id, presence: true
  validates :prototype_id, presence: true
end
