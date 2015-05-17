class Preference < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_ID"
  validates :user, presence: true
  belongs_to :tag, foreign_key: "tag_ID"
  validates :tag, presence: true
end
