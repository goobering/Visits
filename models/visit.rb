require_relative("../db/sql_runner")

class Visit

  attr_reader :id
  attr_accessor :user_id, :location_id, :review 

  def initialize( options )
    @id = options['id'].to_i
    @user_id = options['user_id'].to_i
    @location_id = options['location_id'].to_i
    @review = options['review']
  end

  def save()
    sql = "INSERT INTO visits (user_id, location_id, review)
           VALUES ('#{ @user_id }', '#{ @location_id }', '#{ @review }') RETURNING id;"
    visit = SqlRunner.run( sql ).first
    @id = visit['id'].to_i
  end

  def all()
      sql = "SELECT users.name AS User, locations.name as Location, visits.review FROM users
            INNER JOIN visits ON users.id = visits.user_id
            INNER JOIN locations ON locations.id = visits.location_id WHERE visits.location_id = #{@location_id};"
      details = SqlRunner.run(sql)
      return details.map { |visit| VisitDetails.new( visit ) }
  end

  def self.all()
    sql = "SELECT * FROM visits;"
    visits = SqlRunner.run(sql)
    result = visits.map { |visit| Visit.new( visit ) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM visits"
    SqlRunner.run(sql)
  end

end