require "faker"

$i = 0
$num = 5

while $i < $num  do
	User.create(username: Faker::HarryPotter.character, description: Faker::HarryPotter.quote, pic: Faker::Avatar.image, email: Faker::Cat.name + "@hogwarts.edu", password: Faker::Color.color_name)
	Tag.create(name: Faker::HarryPotter.book)
	Post.create(user_id: $i+1, tag_id: $i, url: Faker::Internet.url, body: Faker::Hipster.sentence, title: Faker::Hipster.word)
	$i += 1
end