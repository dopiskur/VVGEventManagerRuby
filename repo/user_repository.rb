require_relative 'database'
require_relative '../models/user'

class UserRepository
  def self.checkUser(username, password)
    db = Database.connection

    result = db.execute(
      "SELECT * FROM users WHERE username = ? AND password = ?",
      [username, password]
    ).first

    return nil unless result

    User.new(result['id'], result['username'], result['password'], result['role'])
  end

  def self.find_by_id(id)
    db = Database.connection

    result = db.execute("SELECT * FROM users WHERE id = ?", [id]).first
    return nil unless result

    User.new(result['id'], result['username'], result['password'], result['role'])
  end
end
