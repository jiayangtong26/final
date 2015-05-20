class Tag < ActiveRecord::Base
	has_many :preferences, :dependent => :nullify, :inverse_of => :tag
	has_many :users, :through => :preferences
	has_many :subjects, :dependent => :nullify, :inverse_of => :tag
	has_many :reports, :through => :subjects
	validates :tag_name, presence: true ,uniqueness: true
end
