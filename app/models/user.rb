class User
  include Mongoid::Document
  include Mongoid::Timestamps
  before_save :downcase_username
  before_create :generate_token
  field :username, type: String
  field :token, type: String

  validates :username, presence: true, uniqueness: true, length: { minimum: 6 }, format: { without: /\s/ }

  has_many :message
  index({ username: 1 }, { unique: true, name: "username_index" })
  index({ token: 1 }, { unique: true, name: "token_index" })

  private

    def downcase_username
      username.downcase!
    end

    def generate_token
      self.token = SecureRandom.urlsafe_base64
    end

end
