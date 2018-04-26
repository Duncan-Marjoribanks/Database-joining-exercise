
require_relative("../db/sql_runner")

class Star

attr_reader :id
attr_accessor :first_name, :last_name

def initialize(options)
  @first_name = options['first_name']
  @last_name = options['last_name']
  @id = options["id"].to_i if options["id"]
end

def save()
  sql = "INSERT INTO stars (first_name, last_name)
  VALUES ($1, $2)
  RETURNING id"
  values = [@first_name, @last_name]
  star = SqlRunner.run(sql, values).first
  @id = star["id"].to_i
end

def update()
  sql = "UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3"
  values = [@first_name, @last_name, @id]
  SqlRunner.run(sql, values)
end

def movies()
  sql = "SELECT movies.* FROM movies INNER JOIN castings
  ON castings.movie_id = movies.id WHERE castings.star_id = $1"
  values = [@id]
  movie_hashes = SqlRunner.run(sql, values)
  movies = Movie.map_items(movie_hashes)
  return movies
end

def self.all()
  sql = "SELECT * FROM stars"
  star_hashes = SqlRunner.run(sql)
  return Star.map_items(star_hashes)
end

def self.map_items(star_hashes)
  result = star_hashes.map{|star_hash| Star.new(star_hash)}
  return result
end

def self.delete_all()
  sql = "DELETE FROM stars"
  SqlRunner.run(sql)
end


end
