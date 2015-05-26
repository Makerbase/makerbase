class Post < ActiveRecord::Base
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :order_by_likes, -> { order('likes_count DESC') }

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
end
