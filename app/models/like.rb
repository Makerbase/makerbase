class Like < ActiveRecord::Base
  belongs_to :user
  has_one :user, through: :posts
  belongs_to :post, counter_cache: true
  belongs_to :comment
  validates :user_id, uniqueness: { scope: :post }
end
