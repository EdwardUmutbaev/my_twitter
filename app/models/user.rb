class User < ActiveRecord::Base

  validates :username, :presence => true, :length => { :minimum => 3, :maximum => 30 }
  validates :email, :presence => true, :uniqueness => true, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_save :encode_password

  attr_accessor :password, :password_confirmation, :current_password


  def encode_password
    if self.new_record?
      self.salt = Digest::SHA1.hexdigest("-#{Time.now.to_i}-#{rand(1000)}--#{email}--#{password}")
    end
    self.encrypted_password = User.encrypt_password(self.password, self.salt)
  end

  class << self
    def encrypt_password(password, salt)
      Digest::SHA1.hexdigest("-secret-key-#{password}--another-key-#{salt}")
    end

    def authenticate(email, password)
      user = where(:email => email).first
      return nil if user.blank?

      if user.encrypted_password == User.encrypt_password(password, user.salt)
        return user
      else
        return nil
      end
    end
  end
end
