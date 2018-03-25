require 'rails_helper'

RSpec.describe "Chats", type: :feature, js: true do

  before do
    visit("/")
    fill_in('Username', with: 'valid_user')
    click_button('Login')
    expect(page).to have_text('Add room')
    click_button('Add room')
    fill_in('My room', with: 'example room')
    click_button('Save')
    expect(page).to have_no_css('.modal')
    expect(page).to have_css('.room-name', text: 'example room')
    click_button('example room')
    expect(page).to have_css('#chat')
  end

  describe "Chat flow" do

    context "When a message is sent with content" do
      it "Display in the chat box" do
        fill_in('message-box', with: 'asdf' )
        click_on('message-button')
        expect(page).to have_css('li', text: 'asdf')
      end
    end

    context "When a message is sent with whitespaces" do
      it "Message isn't displayed in the chat" do
        fill_in('message-box', with: '               ' )
        click_on('message-button')
        expect(page).not_to have_css('li', text: '               ')
      end
    end

    context "When a message is sent with more than one whitespaces" do
      it "Replace them with one whitespace" do
        fill_in('message-box', with: 'test          whitespaces' )
        click_on('message-button')
        expect(page).to have_css('li', text: 'test whitespaces')
      end
    end

    context "When a message is wrote 30 times" do
      it "It is displayed the last 20 messages" do
        30.times do
          fill_in('message-box', with: Faker::Lorem.sentence )
          click_on('message-button')
        end
        click_on('Back')
        expect(page).to have_css('.room-name', text: 'example room')
        click_button('example room')
        room_id = Room.find_by(name: 'example room').id.to_s
        Room.get_last_messages(room_id).each do |message|
          expect(page).to have_css('li', text: message.content)
        end 
      end
    end

    context "When a message is wrote each chat" do
      it "Have their owns messages" do
        30.times do
          fill_in('message-box', with: Faker::Lorem.sentence )
          click_on('message-button')
        end
        click_on('Back')
        
        expect(page).to have_content('Add room')
        click_button('Add room')
        fill_in('My room', with: 'other room')
        click_button('Save')
        expect(page).to have_no_css('.modal')
        expect(page).to have_css('.room-name', text: 'other room')
        click_button('other room')
        
        30.times do
          fill_in('message-box', with: Faker::RickAndMorty.quote )
          click_on('message-button')
        end
        click_on('Back')
        
        expect(page).to have_css('.room-name', text: 'example room')
        click_button('example room')
        room_id = Room.find_by(name: 'example room').id.to_s
        other_room_id = Room.find_by(name: 'other room').id.to_s
        Room.get_last_messages(room_id).each do |message|
           expect(page).to have_css('li', text: message.content)
        end
        Room.get_last_messages(other_room_id).each do |message|
           expect(page).to have_no_css('li', text: message.content)
        end 
      end
    end

  end

  after do
    Room.destroy_all
  end

end
