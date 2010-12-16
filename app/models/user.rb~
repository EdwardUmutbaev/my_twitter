class User < ActiveRecord::Base

  validates :username, :presence => true, :length => { :minimum => 3, :maximum => 30 }
  validates :email, :presence => true, :uniqueness => true, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
