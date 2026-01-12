require_relative 'database'
require_relative '../models/event'

class EventRepository
  def self.all
    db = Database.connection

    events_data = db.execute("SELECT * FROM events ORDER BY date")
    events = []

    events_data.each do |event_row|
      performers = event_row['performers'].split(',').map(&:strip)
      events << Event.new(
        event_row['id'],
        event_row['name'],
        event_row['date'],
        performers
      )
    end

    events
  end

  def self.find_by_id(id)
    db = Database.connection

    result = db.execute("SELECT * FROM events WHERE id = ?", [id]).first
    return nil unless result

    performers = result['performers'].split(',').map(&:strip)
    Event.new(result['id'], result['name'], result['date'], performers)
  end

  def self.create(name, date, performers)
    db = Database.connection

    performers_string = performers.join(', ')
    db.execute(
      "INSERT INTO events (name, date, performers) VALUES (?, ?, ?)",
      [name, date, performers_string]
    )
    event_id = db.last_insert_row_id

    find_by_id(event_id)
  end

  def self.delete(id)
    db = Database.connection
    db.execute("DELETE FROM events WHERE id = ?", [id])
  end
end
