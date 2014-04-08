include ApplicationHelper
require "#{Rails.root}/spec/support/my_spec_checker.rb"
include MySpecChecker
require "#{Rails.root}/spec/support/my_spec_filler.rb"
include MySpecFiller
require "#{Rails.root}/spec/support/my_spec_processor.rb"
include MySpecProcessor

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end