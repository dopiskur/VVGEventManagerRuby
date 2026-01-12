class LoginView
  def display_login_prompt
    puts "\n" + "="*50
    puts "EVENT MANAGER - LOGIN"
    puts "="*50
    print "Korisničko ime: "
    username = gets.chomp
    print "Lozinka: "
    password = gets.chomp
    [username, password]
  end

  def display_login_failure
    puts "\nPogrešno korisničko ime ili lozinka!"
  end

  def ask_retry
    puts "\nŽelite li pokušati ponovno? (da/ne)"
    print "Odabir: "
    answer = gets.chomp.downcase
    answer == 'da'
  end
end
