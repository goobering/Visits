require_relative("../db/sql_runner")

class User

  attr_reader :id
  attr_accessor :name

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO users (name) VALUES ('#{ @name }') RETURNING id;"
    user = SqlRunner.run( sql ).first
    @id = user['id'].to_i
  end

  def locations()
    sql = "SELECT locations.name FROM locations INNER JOIN visits ON locations.id = visits.location_id WHERE visits.user_id = #{@id};"
    locations = SqlRunner.run(sql)
    result = locations.map { |location| Location.new( location ) }
    return result
  end

  def self.all()
    sql = "SELECT * FROM users;"
    users = SqlRunner.run(sql)
    result = users.map { |user| User.new( user ) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM users;"
    SqlRunner.run(sql)
  end

end