class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
