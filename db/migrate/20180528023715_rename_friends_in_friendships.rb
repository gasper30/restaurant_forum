class RenameFriendsInFriendships < ActiveRecord::Migration[5.1]
  def change
    rename_column :friendships, :friends_id, :friend_id
  end
end
