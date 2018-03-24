class ChatChannel < ApplicationCable::Channel
  def subscribed
    #stream_from "some_channel"
    stream_from  "#{params[:room]}"
  end

  def speak(data)
    #ActionCable.server.broadcast "some_channel", message: data['message']
    user = User.find_by(token: data['token'])
    ActionCable.server.broadcast "#{params[:room]}", {message: data['message'], username: user.username}
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
