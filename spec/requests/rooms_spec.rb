require 'rails_helper'

RSpec.describe "Rooms", type: :feature, js: true  do

  before do
    visit("/")
    fill_in('Username', with: 'valid_user')
    click_button('Login')
  end

  describe "Rooms flow" do
    context "When room name is right" do
      it "Display the room" do
        expect(page).to have_text('Add room')
        click_button('Add room')
        fill_in('My room', with: 'example room')
        click_button('Save')
        expect(page).to have_css('.room-name', text: 'example room')
      end
    end

    context "When room name is empty" do
      it "Display error" do
        expect(page).to have_text('Add room')
        click_button('Add room')
        fill_in('My room', with: '')
        click_button('Save')
        expect(page).to have_selector('.alert')
      end
    end

    context "When room name is invalid" do
      it "Display error" do
        expect(page).to have_text('Add room')
        click_button('Add room')
        fill_in('My room', with: 'a')
        click_button('Save')
        expect(page).to have_css('.alert')
      end
    end

    context "When click room name" do
      before do
        expect(page).to have_text('Add room')
        click_button('Add room')
        fill_in('My room', with: 'example room')
        click_button('Save')
        #expect(page).to have_no_css('#addRoomModal')
      end
      it "Display the chat" do
        expect(page).to have_css('.room-name', text: 'example room')
        click_button('example room')
        expect(page).to have_css('#chat')
        expect(page).to have_css('.chat-bar')
        expect(page).to have_css('.send-message-button')
      end
    end

    after do
      Room.destroy_all
    end

  end
end
