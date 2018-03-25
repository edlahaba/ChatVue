require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  before do
    @user = build(:user)
    @other_user = build(:user)
  end

  describe ".save" do
    context "Save user without a username" do
      it "Returns false" do 
        @user.username = nil
        expect(@user.valid?).to be_falsey
      end
    end

    context "Save user without a minimum lenght of characters" do
      it "Returns false" do 
        @user.username = "a"
        expect(@user.valid?).to be_falsey
      end
    end

    context "Username cant be duplicated" do
      it "Returns false" do 
        @user.save
        expect(@other_user.valid?).to be_falsey
      end
    end

    context "Save username" do
      it "Returns username in lowercase" do
        username_lower_case = @user.username.downcase
        @user.save
        @user.reload
        expect(@other_user.username).to match(username_lower_case)
      end
    end

    context "User is saved generates a token" do
      it "Returns string" do
        @user.token = "MANUAL_TOKEN"
        after_token = @user.token
        @user.save
        @user.reload
        expect(@user.token.length).to be > 0
        expect(@user.token).not_to match(after_token)
      end
    end

    context "Save a user with usernames with spaces" do
      it "Returns false" do
        @user.username = "U S E R        N A M E"
        expect(@user.valid?).to be_falsey
      end
    end

  end

  after do
    User.destroy_all 
  end

end
