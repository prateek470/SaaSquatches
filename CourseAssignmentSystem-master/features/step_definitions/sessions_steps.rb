

# For Admin Session
# Comment out last step of the preferences.rb
# In sessions.new view name the Login button "login_btn"
# In home view (admin) name logout button "logout_link"

# TODO: Refactor the first two steps into one; Test works successfully



# step that seeds faculty needed for test for Administrators
Given(/^the following faculty is signed up as an administrator$/) do |faculty_table|
  #Faculty.create!({:faculty_name => 'Keyser John', :permission => 'Admin'}) # Make sure faculty exists
  faculty_table.hashes.each do |faculty_args|
      Faculty.create!({:faculty_name => faculty_args[0], :permission => 'Admin'}) # Make sure faculty exists
      User.create!(faculty_args)
  end
end

Given(/^the following faculty is signed up as a professor$/) do |faculty_table|
  #Faculty.create!({:faculty_name => 'Keyser John', :permission => 'Admin'}) # Make sure faculty exists
  faculty_table.hashes.each do |faculty_args|
      Faculty.create!({:faculty_name => faculty_args[0], :permission => 'User'}) # Make sure faculty exists
      User.create!(faculty_args)
  end
end



# step when being logged in is required
Given(/^I am logged in with creds "(.*?)" and "(.*?)"$/) do |email, password|
  visit login_path
  fill_in("Email", :with => email)
  fill_in("Password", :with => password)
  click_button("Login")
end