require 'spec_helper'

describe "UserPages" do
 subject { page }
  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }
     describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name)}
    it { should have_title(user.name)}
  end

  describe "signup page" do
    before { visit signup_path }

    check_content('Sign up')
    check_title(full_title('Sign up'))
  end

describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with valid information" do
      before { signup("Example User","user@example.com","foobar","foobar") }
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
 
     describe "after submission" do
        before { click_button submit }

        check_content('Sign up')
        check_content('error')
      end

    describe "with blank name" do
        before { signup("","foo@bar.com","foobar","foobar") }
        test_invalid_user_creation
     end

    describe "with blank email" do
        before { signup("Foo Bar","","foobar","foobar") }        
        test_invalid_user_creation
     end

    describe "with blank password digest" do
        before { signup("Foo Bar","foo@bar.com","","foobar") }
        test_invalid_user_creation
     end 

     describe "with blank password confirmation" do
        before { signup("Foo Bar","foo@bar.com","foobar","") }        
        test_invalid_user_creation
     end

    describe "with invalid email" do
        before { signup("Foo Bar","foo@bar","foobar","foobar") }
        test_invalid_user_creation
     end

    describe "with password that is too short" do
        before { signup("Foo Bar","foo@bar.com","foo","foo") }
        test_invalid_user_creation
     end

      describe "with mismatched password and password confirmation" do
        before { signup("Foo Bar","foo@bar.com","foobat","foobar") }
        test_invalid_user_creation
     end

      describe "with email already taken" do
        before do
          signup("Foo Bar","foo@bar.com","foobar","foobar")
          click_button submit
          visit signup_path
          signup("Foo Bar2","foo@bar.com","foobar","foobar")
        end
        test_invalid_user_creation
     end
    end  
  end
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end