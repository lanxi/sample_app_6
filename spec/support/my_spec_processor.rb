module MySpecProcessor
def test_invalid_user_creation
   it "should not create a user" do
     expect { click_button submit }.not_to change(User, :count)
   end
   before { click_button submit }
   it { should have_title('Sign up') }
   it { should have_content('error') }
end

def valid_layout_link
    visit root_path
    click_link "About"
    test_link('About Us')
    click_link "Help"
    test_link('Help')
    click_link "Contact"
    test_link('Contact')
    click_link "Home"
    click_link "Sign up now!"
    test_link('Sign up')
    click_link "sample app"
    test_link('')
end

def test_link(link)
   expect(page).to have_title(full_title(link))
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end
end