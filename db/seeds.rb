# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#Post.all.each do |post|
#  puts post.name
#  post.destroy
#end
10.times do |r|
  Post.create(name: "Post:#{r}", caption: "Caption:#{r}", user_id: 1)
end