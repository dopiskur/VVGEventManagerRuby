require_relative 'repo/database'
require_relative 'controllers/authController'
require_relative 'controllers/adminController'
require_relative 'controllers/userController'

# admin:admin123, user:user123

class EventManagerApp
  def initialize
    Database.initialize_database
    @authController = AuthController.new
  end

  def run

    loop do
      user = @authController.login

      break if user == :exit
      next unless user

      if user.admin?
        adminController = AdminController.new(user)
        adminController.run
      else
        userController = UserController.new(user)
        userController.run
      end

      puts "\nŽelite li se ponovno prijaviti? (da/ne)"
      answer = gets.chomp.downcase
      break unless answer == 'da'
    end

    puts "\nHvala što ste koristili Event Manager!"
    Database.close
  end
end

if __FILE__ == $0
  app = EventManagerApp.new
  app.run
end
