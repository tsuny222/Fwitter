class PostComment < ApplicationRecord
	validates :comment, {presence:true, length: {maximum: 120}}
	belongs_to :user
	belongs_to :post
end
