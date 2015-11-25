require 'rails_helper'

feature "user can sign in and out:" do
  context "user not signed in and on the home page" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit '/'
      expect(page).to have_link('Sign up')
      expect(page).to have_link('Sign in')
    end

    it "should not see a 'Sign out' link" do
      visit '/'
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the home page" do
    before do
      visit '/'
      click_link('Sign up')
      fill_in('Email', with:'hot@bun.com')
      fill_in('Password', with:'Medalion5')
      fill_in('Password confirmation', with:'Medalion5')
      click_button('Sign up')
    end
      it "should see a 'Sign out' link" do
        visit '/'
        expect(page).to have_link('Sign out')
      end
      it "should not see 'Sign in' link or a 'Sign up' link" do
        visit '/'
        expect(page).not_to have_link('Sign up')
        expect(page).not_to have_link('Sign in')
      end
  end
end
