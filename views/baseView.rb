class BaseView
  def display_events(events)
    puts "\n" + "="*50
    puts "POPIS EVENATA"
    puts "="*50

    if events.empty?
      puts "Nema eventa u bazi."
    else
      puts "ID | Ime eventa | Datum | Izvođači"
      puts "-" * 50
      events.each do |event|
        puts event.to_s
      end
    end
  end

  def display_invalid_option
    puts "\nNeispravna opcija!"
  end

  def display_event_not_found
    puts "\nEvent s tim ID-em nije pronađen!"
  end
end
