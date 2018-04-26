
require_relative("../db/sql_runner")

class Casting

attr_reader :movie_id, :star_id, :id

def initialize(options)
  @movie_id = options['movie_id']
  @star_id = options['star_id']
  @id = options["id"].to_i if options["id"]
end

def save()
  sql = "INSERT INTO stars (movie_id, star_id)
  VALUES ($1, $2)
  RETURNING id"
  values = [@movie_id, @star_id]
  casting = SqlRunner.run(sql, values).first
  @id = casting["id"].to_i
end

end
