User.create! name: "Example User",
  email: "example@railstutorial.org",
  password: "123456",
  password_confirmation: "123456",
  admin: true

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  User.create! name: name,
  email: email,
  password: password,
  password_confirmation: password 
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

3.times do |n|
  name = "level-#{n+1}"
  Level.create name: name, level1: 20, level2: 40, level3: 40
end

3.times do |n|
  name = "Category-#{n+1}"
  category = Category.create name: name
  90.times do |n|
    question= "question-#{n+1}"
    word = Word.create question: question, level: 1,
      category_id: category.id
    3.times do |n|
      Answer.create content: "answer-#{n+1}",
        is_correct: 0, word_id: word.id
    end
    Answer.create content: "answer-4",
        is_correct: 1, word_id: word.id
  end
end
