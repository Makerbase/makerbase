class Tag < ActiveRecord::Base
  has_many :posts
end
