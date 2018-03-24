class MessagesController < ApplicationController
  def create
    token = params[:token]
    room_id = params[:room_id]
    content = params[:content]

    if !Room.where(id: room_id).any? || !User.where(token: token).any? || content.blank?
      render :json => {errors: "error"}, status: :unprocessable_entity
    else  
      message = Message.new(room: Room.find(room_id), user: User.where(token: token).first)
      message.content = content
      message.save
      render :json => message
    end
    
  end
end
