class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :send_thanks_mail

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites
  has_many :book_comments

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followeds, through: :passive_relationships, source: :follower

  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  attachment :profile_image

  def favorited_by?(user_id)
        favorites.where(user_id: user_id).exists?
  end

  def followed_by?(user)
    passive_relationships.find_by(follower_id: user.id).present?
  end

  def self.looks(words, searches)
    if searches == "perfect_match"
      @user = User.where("name LIKE?", "#{words}")
    elsif searches == "partial_match"
      @user = User.where("name LIKE?", "%#{words}%")
    elsif searches == "forward_match"
      @user = User.where("name LIKE?", "#{words}%")
    else
      @book = User.where("name LIKE?", "%#{words}")
    end
  end

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def send_thanks_mail
    NotificationMailer.thanks_mail(self).deliver
  end

end
