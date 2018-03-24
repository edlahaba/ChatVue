class UsersController < ApplicationController
  
  def create
   if received_username.empty?
     new_user = User.new
     #render :json => new_user.valid? ? new_user : {errors: new_user.errors.full_messages}, status: :unprocessable_entity
     print_model(new_user)
   else
     users = User.where(username: received_username)
     if users.any?
        #render :json => users.first
        print_model(users.first)
     else
        new_user = User.new(username: received_username)
        new_user.save
        print_model(new_user)
        #render :json => new_user.valid? ? new_user : {errors: new_user.errors.full_messages}, status: :unprocessable_entity
     end
   end
  end

  def show
    finded_users = User.where(token: params[:id])
    if finded_users.any?
      render :json => finded_users.first
    else
      render :json => {errors: "Invalid token"}, status: :unprocessable_entity
    end
  end

  private

    def print_model(user)
      render :json => user.valid? ? user : {errors: user.errors.full_messages}
    end

    def received_username
      params[:username]
    end

end
