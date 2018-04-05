class MessagesController < ApplicationController
  def create
    if valid_message?
      render :json => {errors: "error"}, status: :unprocessable_entity
    else
      render :json => create_message
    end
    
  end

  private

    def valid_message?
      !Room.exists_room?(params[:room_id]) || 
                         !User.exists_user(params[:token]) || 
                         params[:content].blank?
    end

    def create_message
      message = Message.create_message(Room.find(params[:room_id]), 
                             User.get_user(params[:token]),
                             params[:content])
      message.save
    end

end
