module MySpecFiller
def valid_signin(user)
  fill_in "Email",    with: user.email.upcase
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def signup(name, email, password, confirmation)
   fill_in "Name",         with: name
   fill_in "Email",        with: email
   fill_in "Password",     with: password
   fill_in "Confirm Password", with: confirmation
end
end