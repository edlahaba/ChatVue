require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
   create_list(:random_user, 5)
   @user = build(:user)
  end

  describe "POST #create" do
    context "When a nil username is sent" do
      it "Return invalid usename" do
        post 'create', params:{username: nil}
        json_response = JSON.parse response.body
        expect(json_response.keys).to include("errors")
      end
    end

    context "When a username doesnt exists" do
      it "Create a new user" do
        expect do
          post 'create', params:{username: @user.username}
        end.to change{ User.count }
        expect(response.status).to eq(200)
      end
    end

    context "When a username exists" do
      it "Doesn't create it" do
        @user.save
        expect do
          post 'create', params:{username: @user.username}
        end.not_to change{ User.count }
        expect(response.status).to eq(200)
      end
    end

    context "When a valid username is sent" do
      it "Return a stored user" do
        post 'create', params:{username: @user.username}
        json_response = JSON.parse response.body
        expect(json_response.keys).to include("token")
        expect(response.status).to eq(200)
      end
    end

  end

  describe "GET #show" do
    context "When a valid token is sent" do
      it "Return a user" do
        @user.save
        get 'show', params:{id: @user.token}
        json_response = JSON.parse response.body
        expect(json_response.keys).to include("token")
        expect(json_response.keys).to include("username")
        expect(response.status).to eq(200)
      end
    end

    context "When a invalid token is sent" do
      it "Return unprocessable entity" do
        @user.token = "asdasdasdada"
        get 'show', params:{id: @user.token}
        json_response = JSON.parse response.body
        expect(json_response.keys).to include("errors")
        expect(response.status).to eq(422)
      end
    end

    context "When token is sent" do
      it "Return the appropiate user" do
        @user.save
        get 'show', params:{id: @user.token}
        json_response = JSON.parse response.body
        expect(json_response['token']).to match(@user.token)
        expect(response.status).to eq(200)
      end
    end
  end

  after do
    User.destroy_all
  end
end
