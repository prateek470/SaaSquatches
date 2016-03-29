Given /^I am on the login page$/ do
    visit "/login"
end

Given /^I am not signed up$/ do
    visit "/login"
end

Given /^I am on the home page logged in$/ do
    visit "home"
end

Given /^I am signed up$/ do
    @user = User.create(:first_name => "aaa", :last_name => "bbb",
                        :email => "ccc@gmail.com", :password => "ddd")
end

When /^I press "(.*)"$/ do |button|
    visit button
end

Then /^I should be on the "(.*)"$/ do |new_page|
end
