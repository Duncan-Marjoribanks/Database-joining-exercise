require_relative("models/star")
require_relative("models/movie")
require_relative("models/casting")

require("pry-byebug")


star1 = Star.new({
  'first_name' => 'Postman',
  'last_name' => 'Pat'})
star1.save()

movie1 = Movie.new({
   "title" => "Die Hard 7 - Die Hard the mail's late",
   "genre" => "Childrens",
   "rating" => "8"})
movie1.save()

casting1 = Casting.new({
  "movie_id" => movie1.id,
  "star_id" => star1.id})
casting1.save()



















binding.pry
nil
