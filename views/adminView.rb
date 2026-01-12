require 'date'
require_relative 'baseView'

class AdminView < BaseView
  def display_menu
    puts "\n" + "="*50
    puts "ADMIN SUČELJE"
    puts "="*50
    puts "1. Ispis svih evenata"
    puts "2. Dodaj event"
    puts "3. Obriši event"
    puts "4. Odjava"
    print "\nOdaberite opciju: "
    gets.chomp
  end

  def get_event_details
    puts "\n--- DODAVANJE NOVOG EVENTA ---"

    name = nil
    loop do
      print "Ime eventa: "
      name = gets.chomp.strip
      if name.empty?
        puts "Greška: Unesi ime eventa!"
      else
        break
      end
    end

    date = nil
    loop do
      print "Datum (YYYY-MM-DD, npr. 2026-03-15): "
      date_input = gets.chomp

      begin
        date = Date.parse(date_input)
        if date < Date.today
          puts "Greška: Datum ne može biti u prošlosti"
          next
        end
        date = date.to_s
        break
      rescue ArgumentError
        puts "Greška: Neispravan format datuma! Koristite format YYYY-MM-DD (npr. 2026-03-15)"
      end
    end

    performers = []
    loop do
      loop do
        print "Ime izvođača (Enter za završetak): "
        performer = gets.chomp.strip
        break if performer.empty?
        performers << performer
      end

      if performers.empty?
        puts "Greška: Dodaj izvođača!"
        next
      else
        break
      end
    end

    { name: name, date: date, performers: performers }
  end

  def display_event_added(event)
    puts "\nEvent uspješno dodan!"
    puts event.to_s
  end

  def get_event_id_to_delete
    print "\nUnesite ID eventa za brisanje: "
    gets.chomp.to_i
  end

  def display_event_deleted
    puts "\nEvent uspješno obrisan!"
  end
end
