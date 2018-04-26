
require_relative("../db/sql_runner")

class Casting

attr_reader :movie_id, :star_id, :id

def initialize(options)
  @movie_id = options['movie_id']
  @star_id = options['star_id']
  @id = options["id"].to_i if options["id"]
end

def save()
  sql = "INSERT INTO castings (movie_id, star_id)
  VALUES ($1, $2)
  RETURNING id"
  values = [@movie_id, @star_id]
  casting = SqlRunner.run(sql, values).first
  @id = casting["id"].to_i
end



def self.all()
  sql = "SELECT * FROM castings"
  casting_hashes = SqlRunner.run(sql)
  return Casting.map_items(casting_hashes)
end

def self.map_items(casting_hashes)
  result = casting_hashes.map{|casting_hash| Casting.new(casting_hash)}
  return result
end

def self.delete_all()
  sql = "DELETE FROM castings"
  SqlRunner.run(sql)
end
end
