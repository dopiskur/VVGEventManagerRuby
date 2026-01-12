require_relative '../repo/event_repository'
require_relative '../repo/registration_repository'
require_relative '../views/userView'

class UserController
  def initialize(user)
    @user = user
    @view = UserView.new
  end

  def run
    loop do
      choice = @view.display_menu

      case choice
      when '1'
        list_events
      when '2'
        register_for_event
      when '3'
        view_my_registrations
      when '4'
        puts "\nKorisnk odjavljen"
        break
      else
        @view.display_invalid_option
      end
    end
  end

  private

  def list_events
    events = EventRepository.all
    @view.display_events(events)
  end

  def register_for_event
    events = EventRepository.all
    @view.display_events(events)

    event_id = @view.get_event_id_to_register
    event = EventRepository.find_by_id(event_id)

    unless event
      @view.display_event_not_found
      return
    end

    if RegistrationRepository.register_user_for_event(@user.id, event_id)
      @view.display_registration_success(event)
    else
      @view.display_already_registered
    end
  end

  def view_my_registrations
    registered_event_ids = RegistrationRepository.get_user_registrations(@user.id)
    registered_events = registered_event_ids.map { |id| EventRepository.find_by_id(id) }

    event_id_to_unregister = @view.display_my_registrations(registered_events)

    if event_id_to_unregister
      RegistrationRepository.unregister_user_from_event(@user.id, event_id_to_unregister)
      @view.display_unregistration_success
    end
  end
end
