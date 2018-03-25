class UsersController < ApplicationController
  
  def create
   if received_username.empty?
     new_user = User.new
     if new_user.valid?
       render json: new_user
     else
       render json: {errors: new_user.errors.full_messages}, status: 422
     end
   else
     users = User.where(username: received_username)
     if users.any?
        render :json => users.first
     else
        new_user = User.new(username: received_username)
        new_user.save
        if new_user.valid?
          render json: new_user
        else
          render json: {errors: new_user.errors.full_messages}, status: 422
        end
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

    def received_username
      params[:username]
    end

end
