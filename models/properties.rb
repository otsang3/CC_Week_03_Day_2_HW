require('pg')

class Property
  attr_accessor :address, :value, :no_of_bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value']
    @no_of_bedrooms = options['no_of_bedrooms']
    @year_built = options['year_built']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({ dbname: 'properties', host: 'localhost'})
    sql =
    "INSERT INTO properties
    (
      address,
      value,
      no_of_bedrooms,
      year_built
    )
    VALUES
    (
      $1,
      $2,
      $3,
      $4
    )
    RETURNING *
    "
    values = [@address, @value, @no_of_bedrooms, @year_built]
    db.prepare("save", sql)
    # db.exec_prepared("save", values)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def Property.all()
    db = PG.connect({ dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    return properties.map {|property| Property.all(order)}
  end

  def update()
    db = PG.connect({ dbname: 'properties', host: 'localhost'})
    sql =
    "UPDATE properties
    SET
    (
      address,
      value,
      no_of_bedrooms,
      year_built
    ) =
    (
      $1,
      $2,
      $3,
      $4
    )
    WHERE id = $5
    "
    values = [@address, @value, @no_of_bedrooms, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({ dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({ dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties"
    values = [@id]
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Property.find(id) # read
    db = PG.connect({ dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [id]
    db.prepare("find", sql)]
    results_array = db.exec_prepared("find", values)
    db.close()
    # return nil if results_array.first() == nil
    property_hash = results_array[0]
    found_property = Property.new(property_hash)
    return found_property
  end

  def Property.find_by_address(address)
    db = PG.connect({ dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [address]
  end

end
