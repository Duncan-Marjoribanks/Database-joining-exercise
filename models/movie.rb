
require_relative("../db/sql_runner")

class Movie

attr_reader :title, :genres, :rating, :id

def initialize(options)
  @title = options['title']
  @genre = options['genre']
  @rating = options['rating'].to_i
  @id = options["id"].to_i if options["id"]
end

end
