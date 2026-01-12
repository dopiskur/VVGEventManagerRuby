class User
  attr_accessor :id, :username, :password, :role

  def initialize(id, username, password, role)
    @id = id
    @username = username
    @password = password
    @role = role
  end

  def admin?
    @role == 'admin'
  end
end
