require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  before do
    @user = create(:user)
    @room = create(:random_room)
  end

  describe "POST #create" do
    context "When a room_id, token and content is nil" do
      it "return unprocessable entity" do
        post 'create', params:{}
        expect(response.status).to eq(422)
      end
    end

    context "When room_id is nil" do
      it "return unprocessable entity" do
        post 'create', params:{ room_id: nil, user_id: @user.id.to_s, content: "message"}
        expect(response.status).to eq(422)
      end
    end

    context "When token is nil" do
      it "return unprocessable entity" do
        post 'create', params:{ room_id: @room.id.to_s, token: nil, content: "message"}
        expect(response.status).to eq(422)
      end
    end

    context "When content is nil" do
      it "return unprocessable entity" do
        post 'create', params:{ room_id: @room.id.to_s, token: @user.token, content: nil}
        expect(response.status).to eq(422)
      end
    end

    context "When send room_id token and message" do
      it "return OK" do
        post 'create', params:{ room_id: @room.id.to_s, token: @user.token, content: "message"}
        expect(response.status).to eq(200)
      end
    end

    context "When room_id not exists" do
      it "return unprocessable entity" do
        @room.id = "aaaaaaa"
        post 'create', params:{ room_id: @room.id.to_s, token: @user.token, content: "message"}
        expect(response.status).to eq(422)
      end
    end

    context "When token not exists" do
      it "return unprocessable entity" do
        @user.token = "aaaaaaa"
        post 'create', params:{ room_id: @room.id.to_s, token: @user.token, content: "message"}
        expect(response.status).to eq(422)
      end
    end

    context "When message is invalid" do
      it "return unprocessable entity" do
        post 'create', params:{ room_id: @room.id.to_s, token: @user.token, content: "                    "}
        expect(response.status).to eq(422)
      end
    end

    context "When the params are correct the message is saved" do
      it "return OK" do
        expect do
        post 'create', params:{ room_id: @room.id.to_s, token: @user.token, content: "test asdasdad"}  
        end.to change{ Message.count }
        expect(response.status).to eq(200)
      end
    end

  end

  after do
    Message.destroy_all
    User.destroy_all
    Room.destroy_all
  end

end
