class Song < ActiveRecord::Base
	belongs_to :user
	has_many :votes
	validates :Song_title, :Author, :URL, presence: true

end