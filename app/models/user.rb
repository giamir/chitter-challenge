require 'dm-validations'
require 'bcrypt'

class User
  include DataMapper::Resource

  property :id,                  Serial
  property :username,            String, required: true, unique: true
  property :name,                String, required: true
  property :email,               String, required: true, format: :email_address, unique: true
  property :password_digest,     Text, lazy: false
  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  # def self.authenticate(email, password)
  #   user = first(email: email)
  #   user.id if user && BCrypt::Password.new(user.password_digest) == password
  # end
end
