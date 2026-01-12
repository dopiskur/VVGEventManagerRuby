require_relative 'database'
require_relative '../models/registration'

class RegistrationRepository
  def self.register_user_for_event(user_id, event_id)
    db = Database.connection

    begin
      db.execute(
        "INSERT INTO registrations (user_id, event_id) VALUES (?, ?)",
        [user_id, event_id]
      )
      true
    rescue SQLite3::ConstraintException
      false
    end
  end

  def self.unregister_user_from_event(user_id, event_id)
    db = Database.connection
    db.execute(
      "DELETE FROM registrations WHERE user_id = ? AND event_id = ?",
      [user_id, event_id]
    )
  end

  def self.get_user_registrations(user_id)
    db = Database.connection

    results = db.execute(
      "SELECT event_id FROM registrations WHERE user_id = ?",
      [user_id]
    )

    results.map { |row| row['event_id'] }
  end
end
