class CreatePostsTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :posts do |t|
  		t.integer :user_id
  		t.integer :tag_id
  		t.string :url
  		t.string :title
  		t.text :body
  		t.timestamps
  	end
  end
end
