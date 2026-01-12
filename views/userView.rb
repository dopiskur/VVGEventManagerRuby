require_relative 'baseView'

class UserView < BaseView
  def display_menu
    puts "\n" + "="*50
    puts "KORISNIČKO SUČELJE"
    puts "="*50
    puts "1. Ispis svih evenata"
    puts "2. Registriraj se na event"
    puts "3. Ispis mojih registracija"
    puts "4. Odjava"
    print "\nOdaberite opciju: "
    gets.chomp
  end

  def get_event_id_to_register
    print "\nUnesite ID eventa za registraciju: "
    gets.chomp.to_i
  end

  def display_registration_success(event)
    puts "\nUspješno ste se registrirali na event: #{event.name}"
  end

  def display_already_registered
    puts "\nVeć ste registrirani na ovaj event!"
  end

  def display_my_registrations(events)
    puts "\n" + "="*50
    puts "MOJE REGISTRACIJE"
    puts "="*50

    if events.empty?
      puts "Niste registrirani ni na jedan event."
    else
      puts "ID | Ime eventa | Datum | Izvođači"
      puts "-" * 50
      events.each do |event|
        puts event.to_s
      end

      puts "\nŽelite li se deregistrirati s nekog eventa?"
      print "Unesite ID eventa (ili Enter za povratak): "
      input = gets.chomp
      return nil if input.empty?
      input.to_i
    end
  end

  def display_unregistration_success
    puts "\nUspješno ste se deregistrirali!"
  end
end
