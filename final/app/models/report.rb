class Report < ActiveRecord::Base

	has_many :subjects, :dependent => :destroy, :inverse_of => :report
	has_many :tags, :through => :subjects

    has_many :favorites, :dependent => :destroy, :inverse_of => :report
	has_many :users, :through => :favorites

	validates :title, presence: true
	validates :content, presence: true
	belongs_to :user, foreign_key: "user_ID"
	validates :user, presence: true
end
