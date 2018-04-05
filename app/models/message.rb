class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  before_save :removeSpaces
  field :content, type: String
  validates :content, presence: true, length: { minimum: 1 }
  belongs_to :room
  belongs_to :user

  def as_json(options={})
    { :username => self.user.username, :message => self.content, :room_name => self.room.name }
  end

  def self.create_message(room, user, content)
    Message.new(room: room, user: user, content: content)
  end

  private

    def removeSpaces
      content.squish!
    end
    
end
