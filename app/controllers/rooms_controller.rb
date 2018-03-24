class RoomsController < ApplicationController

  def create
     new_room = nil
     room_name = params["name"]
     new_room = Room.new(name: room_name)
     new_room.save
     if new_room.valid?
       render :json => new_room 
     else 
       render :json => {errors: new_room.errors.full_messages}, status: :unprocessable_entity
     end
  end

  def index
    render :json => Room.order_by(:created_at.desc)
  end

  def show
    room_id = params[:id]
    if params[:id].blank? || !Room.where(id: room_id).any?
      render :json => {errors: "Wrong params"}, status: :unprocessable_entity
    else
      render :json => Room.get_last_messages(room_id)#Message.where(room_id: room_id).order_by(:created_at => :desc).to_a.take(20).reverse
    end
  end

end
