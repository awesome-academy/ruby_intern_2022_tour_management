class JsonWebToken
  class << self
    def encode payload
      JWT.encode payload, Rails.application.secrets.secret_key_base, "HS256"
    end

    def decode token
      HashWithIndifferentAccess.new JWT.decode(token,
                                               Rails.application.secrets
                                                    .secret_key_base,
                                               true, {algorithm: "HS256"})[0]
    end
  end
end
