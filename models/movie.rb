
require_relative("../db/sql_runner")

class Movie

attr_reader :title, :genres, :rating, :id

def initialize(options)
  @title = options['title']
  @genre = options['genre']
  @rating = options['rating'].to_i
  @id = options["id"].to_i if options["id"]
end


def save()
  sql = "INSERT INTO stars (title, genre, rating)
  VALUES ($1, $2, $3)
  RETURNING id"
  values = [@title, @genre, @rating]
  movie = SqlRunner.run(sql, values).first
  @id = movie["id"].to_i
end

end
