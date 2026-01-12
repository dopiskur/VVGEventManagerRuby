require_relative '../repo/user_repository'
require_relative '../views/loginView'

class AuthController
  def initialize
    @view = LoginView.new
  end

  def login
    username, password = @view.display_login_prompt
    user = UserRepository.checkUser(username, password)

    if user
      user
    else
      @view.display_login_failure
      if @view.ask_retry
        nil
      else
        :exit
      end
    end
  end
end
