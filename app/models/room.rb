class Room
  include Mongoid::Document
  include Mongoid::Timestamps
  before_save :downcase_roomname, :remove_spaces
  field :name, type: String
  validates :name, presence: true, uniqueness: true, length: { minimum: 2 }
  
  has_many :message
  index({ name: 1 }, { unique: true, name: "chatroom_index" })

  def self.get_last_messages(room_id)
    Message.where(room_id: room_id).order_by(:created_at => :desc).to_a.take(20).reverse
  end

  private

    def downcase_roomname
      name.downcase!
    end

    def remove_spaces
      name.squish!
    end

end
