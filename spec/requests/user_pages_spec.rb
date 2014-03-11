require 'spec_helper'

describe "UserPages" do
 subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

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

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end

    describe "with blank name" do
        before do
          fill_in "Name",         with: ""
          fill_in "Email",        with: "foo@bar.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
     end

    describe "with blank email" do
        before do
          fill_in "Name",         with: "Foo Bar"
          fill_in "Email",        with: ""
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
     end

    describe "with blank password digest" do
        before do
          fill_in "Name",         with: "Foo Bar"
          fill_in "Email",        with: "foo@bar.com"
          fill_in "Password",     with: ""
          fill_in "Confirmation", with: "foobar"
        end
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
     end 

     describe "with blank password confirmation" do
        before do
          fill_in "Name",         with: "Foo Bar"
          fill_in "Email",        with: "foo@bar.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: ""
        end
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
     end

    describe "with invalid email" do
        before do
          fill_in "Name",         with: "Foo Bar"
          fill_in "Email",        with: "foo@bar"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
     end

    describe "with password that is too short" do
        before do
          fill_in "Name",         with: "Foo Bar"
          fill_in "Email",        with: "foo@bar.com"
          fill_in "Password",     with: "foo"
          fill_in "Confirmation", with: "foo"
        end
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
     end

      describe "with mismatched password and password confirmation" do
        before do
          fill_in "Name",         with: "Foo Bar"
          fill_in "Email",        with: "foo@bar.com"
          fill_in "Password",     with: "foobat"
          fill_in "Confirmation", with: "foobar"
        end
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
     end

      describe "with email already taken" do
        before do
          fill_in "Name",         with: "Foo Bar"
          fill_in "Email",        with: "foo@bar.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
          click_button submit
          visit signup_path
          fill_in "Name",         with: "Foo Bar2"
          fill_in "Email",        with: "foo@bar.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        before { click_button submit }
        it { should have_title('Sign up') }
        it { should have_content('error') }
     end
    end  
  end
end
