require 'sqlite3'

class Database
  DB_NAME = 'event_manager.db'

  def self.connection
    unless @connection
      @connection = SQLite3::Database.new(DB_NAME)
      @connection.results_as_hash = true # global param
    end
    @connection
  end

  def self.initialize_database
    db = connection

    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        role TEXT NOT NULL
      );
    SQL

    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        date TEXT NOT NULL,
        performers TEXT NOT NULL
      );
    SQL

    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS registrations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        event_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
        UNIQUE(user_id, event_id)
      );
    SQL

    seed_default_users
  end

  def self.seed_default_users
    db = connection
    result = db.execute("SELECT COUNT(*) as count FROM users")[0]
    existing_users = result['count']
    return if existing_users > 0

    db.execute("INSERT INTO users (username, password, role) VALUES (?, ?, ?)",
               ['admin', 'Pa55w.rd', 'admin'])
    db.execute("INSERT INTO users (username, password, role) VALUES (?, ?, ?)",
               ['user', 'Pa55w.rd', 'user'])
  end

  def self.close
    @connection&.close
    @connection = nil
  end
end
