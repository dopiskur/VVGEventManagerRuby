require_relative '../repo/event_repository'
require_relative '../views/adminView'

class AdminController
  def initialize(user)
    @user = user
    @view = AdminView.new
  end

  def run
    loop do
      choice = @view.display_menu

      case choice
      when '1'
        list_events
      when '2'
        add_event
      when '3'
        delete_event
      when '4'
        puts "\nKorisnik odjavljen"
        break
      else
        @view.display_invalid_option
      end
    end
  end

  private

  def list_events
    events = EventRepository.all #ovo je array, nije lista jer ruby
    @view.display_events(events)
  end

  def add_event
    details = @view.get_event_details
    return unless details

    event = EventRepository.create(
      details[:name],
      details[:date],
      details[:performers]
    )
    @view.display_event_added(event)
  end

  def delete_event
    events = EventRepository.all
    @view.display_events(events)

    event_id = @view.get_event_id_to_delete
    event = EventRepository.find_by_id(event_id)

    if event
      EventRepository.delete(event_id)
      @view.display_event_deleted
    else
      @view.display_event_not_found
    end
  end
end
