class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
end

class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :tag
	has_many :comments, dependent: :destroy
end

class Tag < ActiveRecord::Base
	has_many :posts, dependent: :destroy
end

class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
end