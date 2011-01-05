class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :current_password
  has_attached_file :avatar, :styles => { :medium => "128x128>", :small => "48x48>" }, :default_url => "/system/avatars/default.png"                  

  has_many :posts, :dependent => :destroy
  has_many :friendships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :friendships, :source => :followed
  has_many :reverse_friendships, :foreign_key => "followed_id", :class_name => "Friendship", :dependent => :destroy
  has_many :followers, :through => :reverse_friendships, :source => :follower

  validates :username, :presence => true, :length => { :minimum => 3, :maximum => 30 }
  validates :email, :presence => true, :uniqueness => true, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, :presence => true, :confirmation => true, :length => { :minimum => 6, :maximum => 30 }

  before_save :encode_password

  def following?(followed)
    friendships.find_by_followed_id(followed)
  end

  def follow!(followed)
    friendships.create!(:followed_id => followed.id)
  end

  def following_list
    self.following
  end

  def followers_list
    self.followers
  end

  def unfollow!(followed)
    friendships.find_by_followed_id(followed).destroy
  end  

  def all_posts 
    Post.find(:all, :conditions => ["user_id in (?)", following.collect{ |followed| followed.id }.push(self.id)], :order => "created_at DESC")
  end

  def user_posts 
    self.posts.order("created_at DESC")
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
