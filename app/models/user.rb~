class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy

  validates :username, :presence => true, :length => { :minimum => 3, :maximum => 30 }
  validates :email, :presence => true, :uniqueness => true, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, :presence => true, :confirmation => true, :length => { :minimum => 6, :maximum => 30 }

  before_save :encode_password

  attr_accessor :password, :password_confirmation, :current_password

  def all_posts 
   Post.find(:all, :order => "created_at DESC")
  end

  def user_posts(user) 
   Post.find(:all, :conditions => ["user_id in (?)", user.id], :order => "created_at DESC")
  end

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
