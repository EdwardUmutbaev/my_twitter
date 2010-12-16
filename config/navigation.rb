# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  
  navigation.items do |user|
      user.item :home, 'Home', root_path
    if signed_in?
      user.item :users, 'Users', users_path       
      user.item :profile, 'Profile', current_user 
      user.item :setting, 'Setting', edit_user_path(current_user)       
      user.item :sign_out, 'Sign out', signout_path, :method => :delete      
    else
      user.item :sign_in, 'Sign in', signin_path    
    end
  end
end
