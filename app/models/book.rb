class Book < ApplicationRecord

	validates :title, presence: true
	validates :body, presence: true, length: { maximum: 200 }

  belongs_to :user
  has_many :favorites
  has_many :book_comments

   def favorited_by?(user_id)
        favorites.where(user_id: user_id).exists?
   end

end
