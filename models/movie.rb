
require_relative("../db/sql_runner")

class Movie

attr_accessor :title, :genres, :rating
attr_reader :id

def initialize(options)
  @title = options['title']
  @genre = options['genre']
  @rating = options['rating'].to_i
  @id = options["id"].to_i if options["id"]
end


def save()
  sql = "INSERT INTO movies (title, genre, rating)
  VALUES ($1, $2, $3)
  RETURNING id"
  values = [@title, @genre, @rating]
  movie = SqlRunner.run(sql, values).first
  @id = movie["id"].to_i
end


def stars()
  sql = "SELECT stars.* FROM stars INNER JOIN castings
  ON castings.star_id = stars.id WHERE castings.movie_id = $1"
  values = [@id]
  star_hashes = SqlRunner.run(sql, values)
  stars = Star.map_items(star_hashes)
  return stars
end


def update()
  sql = "UPDATE movies SET (title, genre, rating) = ($1, $2, $3) WHERE id = $4"
  values = [@title, @genre, @rating, @id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM movies"
  movie_hashes = SqlRunner.run(sql)
  return Movie.map_items(movie_hashes)
end

def self.map_items(movie_hashes)
  result = movie_hashes.map{|movie_hash| Movie.new(movie_hash)}
  return result
end

def self.delete_all()
  sql = "DELETE FROM movies"
  SqlRunner.run(sql)
end
end
