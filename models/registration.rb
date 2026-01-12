class Registration
  attr_accessor :id, :user_id, :event_id

  def initialize(id, user_id, event_id)
    @id = id
    @user_id = user_id
    @event_id = event_id
  end
end
