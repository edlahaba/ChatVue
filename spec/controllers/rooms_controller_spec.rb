require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  before do
    @room = build(:random_room)
    create_list(:random_room, 30)
    user = create(:user)
    other_user = create(:other_user)
    @first_room = Room.first
    other_room = Room.last
    create_list(:message, 30, user: other_user, room: @first_room)
    create_list(:message, 30, user: other_user, room: @first_room)
  end

  describe "POST #create" do
    context "When a nil name is sent" do
      it "Return invalid name" do
        post 'create', params: {username: nil}
        json_response = JSON.parse response.body
        expect(json_response.keys).to include("errors")
        expect(response.status).to eq(422)
      end
    end

    context "When a new room name is sent" do
      it "Return their data" do
        post 'create', params: {name: "my_new_room"}
        json_response = JSON.parse response.body
        expect(json_response.keys).to include("name")
        expect(json_response.keys).to include("_id")
        expect(response.status).to eq(200)
      end
    end

    context "When a new room name is sent" do
      it "Create a new record" do
        expect do
          post 'create', params:{name: "my_new_room"}
        end.to change{ Room.count }
        expect(response.status).to eq(200)
      end
    end

    context "When an existent room name is sent" do
      it "Doesn't create a new record" do
        @room.save
        expect do
          post 'create', params:{name: @room.name}
        end.not_to change{ Room.count }
        expect(response.status).to eq(422)
      end
    end

    context "When a room name is invalid" do
      it "Return error" do
        post 'create', params: {name: 'a'}
        json_response = JSON.parse response.body
        expect(json_response.keys).to include("errors")
        expect(response.status).to eq(422)
      end
    end

    context "When a existent room name is sent" do
      it "Return error" do
        @room.save
        post 'create', params: {name: @room.name}
        json_response = JSON.parse response.body
        expect(json_response.keys).to include("errors")
        expect(response.status).to eq(422)
      end
    end
  end

  describe "GET #index" do
    context "Do a request without params" do
      it "Returns all saved rooms" do
         get 'index'
         json_response = JSON.parse response.body
         expect(json_response.length).to eq(30)
      end
    end
  end

  describe "GET #show" do
    context "When a request without params is sent" do
      it "Return unprocessable entity" do
        get 'show', params:{id:""}
        expect(response.status).to eq(422)
      end
    end

    context "When a request with room is sent" do
      it "Return OK" do
        get 'show', params:{id: @first_room.id}
        expect(response.status).to eq(200)
      end
    end

    context "When a request with room is sent" do
      it "Returns messages their room" do
        get 'show', params:{id: @first_room.id}
        json_response = JSON.parse response.body
        json_response.each do |e|
          expect(e['room_name']).to match(@first_room.name)  
        end
        expect(response.status).to eq(200)
      end
    end

    context "When an unexistent room is sent" do
      it "Returns a unprocessable entity" do
        get 'show', params:{id: "asdasdadasdadsadadadsad"}
        expect(response.status).to eq(422)
      end
    end
  end

  after do
    User.destroy_all
    Room.destroy_all
  end
end
