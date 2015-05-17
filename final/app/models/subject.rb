class Subject < ActiveRecord::Base
	belongs_to :report, foreign_key: "report_ID"
	validates :report, presence: true
	belongs_to :tag, foreign_key: "tag_ID"
	validates :tag, presence: true
end
