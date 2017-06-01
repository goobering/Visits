require_relative '../db/sql_runner.rb'

class VisitDetails

  def initialize(options)
    @user_name = options['user']
    @location_name = options['location']
    @review = options['review']
  end

  def self.all()
      sql = "SELECT users.name AS User, locations.name as Location, visits.review FROM users
            INNER JOIN visits ON users.id = visits.user_id
            INNER JOIN locations ON locations.id = visits.location_id;"
      details = SqlRunner.run(sql)
      return details.map { |visit| VisitDetails.new( visit ) }
  end

end