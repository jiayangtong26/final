class Tag < ActiveRecord::Base
	has_many :preferences, :inverse_of => :tag
	has_many :users, :through => :preferences
	has_many :subjects, :inverse_of => :tag
	has_many :reports, :through => :subjects
	validates :tag_name, presence: true ,uniqueness: true
end
