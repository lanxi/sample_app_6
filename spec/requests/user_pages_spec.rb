require 'spec_helper'

describe "UserPages" do
 subject { page }

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
end