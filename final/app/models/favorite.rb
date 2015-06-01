class Favorite < ActiveRecord::Base
	belongs_to :report, foreign_key: "report_ID"
	validates :report, presence: true
	belongs_to :user, foreign_key: "user_ID"
	validates :user, presence: true
end
