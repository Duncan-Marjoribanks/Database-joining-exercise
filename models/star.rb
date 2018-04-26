
require_relative("../db/sql_runner")

class Star

attr_reader :first_name, :last_name, :id

def initialize(options)
  @first_name = options['first_name']
  @last_name = options['last_name']
  @id = options["id"].to_i if options["id"]
end

end
