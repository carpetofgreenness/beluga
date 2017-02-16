require "faker"

$i = 0
$num = 5

while $i < $num  do
	$user = User.create(username: Faker::HarryPotter.character, description: Faker::HarryPotter.quote, pic: Faker::Avatar.image, email: Faker::Cat.name + "@hogwarts.edu", password: Faker::Color.color_name)
	$tag = Tag.create(name: Faker::HarryPotter.book)
	Post.create(user_id: $user.id, tag_id: $tag.id, url: Faker::Internet.url, body: Faker::Hipster.sentence, title: Faker::Hipster.word)
	$i += 1
end