class User < ApplicationRecord
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :name, {presence:true, length: {maximum: 10}, on: :update}
	validates :introduction, {presence:true, length: {maximum: 120}, on: :update}
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  attachment :profile_image

  has_many :active_relationships, class_name:  "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

end
