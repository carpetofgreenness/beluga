class User < ActiveRecord::Base
	has_many :posts
end

class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :tag
end

class Tag < ActiveRecord::Base
	has_many :posts
end