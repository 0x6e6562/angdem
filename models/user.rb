class User < Sequel::Model
  
  @restrict_primary_key = false
  
  def self.authenticate(id, password)
    user = self.first(id: id)
    user if user && BCrypt::Password.new(user.password) == password
  end
  
end