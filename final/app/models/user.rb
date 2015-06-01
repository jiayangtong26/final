class User < ActiveRecord::Base

	has_secure_password

	has_many :preferences, :dependent => :destroy, :inverse_of => :user
	has_many :tags, :through => :preferences

	has_many :reports, :dependent => :destroy, :inverse_of => :user

	has_many :favorites, :dependent => :destroy, :inverse_of => :user
	has_many :favored_reports, :through => :favorites, :source => :reports

	validates :email, presence: true ,uniqueness: true
	validates :user_name, presence: true ,uniqueness: true
	validates :password, presence: true
	validates :user_type, presence: true
end
