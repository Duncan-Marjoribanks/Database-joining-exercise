
require_relative("../db/sql_runner")

class Casting

attr_reader :movie_id, :star_id, :id

def initialize(options)
  @movie_id = options['movie_id']
  @star_id = options['star_id']
  @id = options["id"].to_i if options["id"]
end

end
