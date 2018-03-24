require 'rails_helper'

RSpec.describe Message, type: :model do
  
  before do
    room = create(:room)
    user = create(:user)
    @message = build(:message, room: room, user: user)
  end

  describe ".save" do
    context "When is saved a empty content" do
      it "returns false" do
        @message.content = ""
        expect(@message.valid?).to be_falsey
      end 
    end

    context "When is saved with filled content" do
      it "returns true" do
        @message.content = "a"
        expect(@message.valid?).to be_truthy
      end 
    end

    context "When is saved a string with more than one whitespace" do
      it "replace it whith a one whitespace" do
        @message.content = "    Hello           world        ruby  "
        @message.save
        @message.reload
        expect(@message.content).to match("Hello world ruby")
      end 
    end
  end

  after do
    User.destroy_all
    Room.destroy_all
    Message.destroy_all
  end

end
