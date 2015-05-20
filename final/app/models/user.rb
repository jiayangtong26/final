class User < ActiveRecord::Base
	has_many :preferences, :dependent => :destroy, :inverse_of => :user
	has_many :tags, :through => :preferences
	has_many :reports, :dependent => :destroy, :inverse_of => :user
	validates :email, presence: true ,uniqueness: true
	validates :user_name, presence: true ,uniqueness: true
	validates :pass_word, presence: true
	validates :user_type, presence: true
end
