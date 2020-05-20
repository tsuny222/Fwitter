class Post < ApplicationRecord
	validates :body, {presence:true, length: {maximum: 120}}
	attachment :image
	belongs_to :user,optional: true
	has_many :post_comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end
end
