class User < ApplicationRecord
    before_validation :ensure_session_token
    validates :username, :password_digest, :session_token, presence: true
    validates :username, :session_token, uniqueness: true
    validates :password, length: { minimum: 6 }
    attr_reader :password


    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        pass = BCrypt::Password.new(self.password_digest)
        pass.is_password?(password)
    end

    def self.find_by_credentials(username, password)
        
    end

end