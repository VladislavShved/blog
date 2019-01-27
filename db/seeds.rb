# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ip_pool = []
users = []

100.times do
  users << User.create(login: Faker::FunnyName.name)
  ip_pool << IPAddr.new(rand(2**32),Socket::AF_INET).to_s
end

conn = Faraday.new(url: 'http://localhost:3000')

marks = [1, 2, 3, 4, 5]

200000.times do

  conn.post do |req|
    req.url 'api/v1/posts'
    req.body = { post: { user_login: users.sample.login, header: Faker::Games::Dota.quote, content: Faker::Games::Dota.quote, author_ip: ip_pool.sample } }
  end
end


20000.times do
  id = rand(1..200000)

  conn.put do |req|
    req.url "api/v1/posts/#{id}/vote"
    req.body = { post: { id: id, mark: marks.sample } }
  end
end