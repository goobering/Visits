require_relative("../db/sql_runner")

class Location 

  attr_reader :id
  attr_accessor :name, :category 

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @category = options['category']
  end

  def save()
    sql = "INSERT INTO locations (name, category) VALUES ('#{ @name }', '#{ @category }') RETURNING id;"
    location = SqlRunner.run( sql ).first()
    @id = location['id'].to_i
  end

  # Write a method in the User class to return all location names that user has visited.
  def users()
    sql = "SELECT users.name FROM users INNER JOIN visits ON users.id = visits.user_id WHERE visits.location_id = #{@id};"
    users = SqlRunner.run(sql)
    result = users.map { |user| User.new( user ) }
    return result
  end

  def self.all()
    sql = "SELECT * FROM locations;"
    locations = SqlRunner.run(sql)
    result = locations.map { |location| Location.new( location ) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM locations;"
    SqlRunner.run(sql)
  end

end