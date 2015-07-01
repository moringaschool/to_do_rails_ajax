require 'bcrypt'

class User < ActiveRecord::Base
  #this creates a virtual attribute "password" that is not in the database for user
  attr_accessor :password

  #this creates another virtual attribute "password_confirmation" (also not in db)
  validates_confirmation_of :password

  #this uses the ActiveRecord before_save hook to ensure the password is hashed before user is saved
  before_save :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(email,password)
    user=User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
