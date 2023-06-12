class User < ApplicationRecord
    before_validation :ensure_session_token
    validates :username, :password_digest, :session_token, presence: true
    validates :username, :session_token, uniqueness: true
    validates :password, length: { minimum: 6 }, allow_nil: true
    attr_reader :password


    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        pass = BCrypt::Password.new(self.password_digest)
        pass.is_password?(password)
    end

    def generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    private
    def ensure_session_token
        self.session_token ||= generate_session_token
    end
end