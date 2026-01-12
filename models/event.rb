class Event
  attr_accessor :id, :name, :date, :performers

  def initialize(id, name, date, performers)
    @id = id
    @name = name
    @date = date
    @performers = performers
  end

  def to_s
    performers_str = @performers.join(', ')
    "ID: #{@id} | #{@name} | #{@date} | Izvođači: #{performers_str}"
  end
end
