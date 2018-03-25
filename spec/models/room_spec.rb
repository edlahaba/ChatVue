require 'rails_helper'

RSpec.describe Room, type: :model do
  
  before do
    @room = build(:room)
    @other_room = build(:room)
  end

  describe ".save" do
    context "Save room without name" do
      it "Returns false" do
        @room.name = nil
        expect(@room.valid?).to be_falsey
      end
    end

    context "Save a room without minimum length of characters" do
      it "Returns false" do
        @room.name = ""
        expect(@room.valid?).to be_falsey
      end
    end

    context "Room name cant be duplicated" do
      it "Returns false" do
        @room.save
        expect(@other_room.valid?).to be_falsey
      end
    end

    context "Save room name" do
      it "Returns room name in lowercase" do
        room_lower_case = @room.name.downcase
        @room.save
        @room.reload
        expect(@room.name).to match(room_lower_case)
      end
    end

    context "Save a room name with spaces" do
      it "Return true" do
        @room.name = "R O O M N A M E"
        expect(@room.valid?).to be_truthy
      end
    end

    context "Save a room name more than one space" do
      it "Replace them by one space" do
        @room.name = "R O O M         N A M E"
        @room.save
        @room.reload
        expect(@room.name).to match("r o o m n a m e")
      end
    end

  end

  after do
    Room.destroy_all 
  end

end
