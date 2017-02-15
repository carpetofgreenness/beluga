class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
end

class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :tag
	has_many :comments
end

class Tag < ActiveRecord::Base
	has_many :posts
end

class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
end