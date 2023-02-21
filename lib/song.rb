class Song
  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
      @name = name
      @album = album
  end

  def self.create_table
      sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
          id INTEGER PRIMARY KEY,
          name TEXT,
          album TEXT
      )
      SQL

      DB[:conn].execute(sql)
  end

  def save
      sql = <<-SQL
          INSERT INTO songs
              (name, album)
          VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, @name, @album)

      self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

      self
  end

  def self.create(name:, album:)
      # Call the initialize method
      # Create a new song in Ruby but is not yes saved in the database
      song = Song.new(name: name, album: album)

      # Call the save method
      # Save the new song above in the music database within the songs table
      song.save
  end


  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
    )
    SQL

    DB[:conn].execute(sql)
end
   
  def all
      # G1
      # Get all database records and return them as the class instance
  end

  def find(id)
      # G3
      # Get a single database record and return it as a class instance
  end

  def update
      # G4
      # Update a single database record and return it as a class instance
      sql = <<-SQL
      UPDATE songs SET name = ?, album = ? WHERE id = ?
    SQL

    DB[:conn].execute(sql, @name, @album, @id)

    self.class.find(@id)
  end

  def delete
      # G2
      # Remove a single database record and return a message with the id & name
  end
end
