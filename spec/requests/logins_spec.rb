require 'rails_helper'

RSpec.describe "Logins", type: :feature, js: true do

  before do
    visit("/")
  end

  describe "Login flow" do
    context "When username input is empty" do
      it "Display error" do
        expect(page).to have_selector('button')
        expect(page).to have_selector('input')
        fill_in('Username', with: '')
        click_on('Login')
        expect(page).to have_selector('input')
        expect(page).to have_selector('.alert')
      end
    end

    context "When username input is invalid" do
      it "Display error" do
        expect(page).to have_selector('button')
        expect(page).to have_selector('input')
        fill_in('Username', with: '     a     ')
        click_on('Login')
        expect(page).to have_selector('input')
        expect(page).to have_selector('.alert')
      end
    end

    context "When username is valid" do
      before { 
        fill_in('Username', with: 'valid_user')
        click_on('Login')
      }
      it "Redirect to chat room" do
        expect(page).to have_content('Add room')
      end
    end

  end
end
