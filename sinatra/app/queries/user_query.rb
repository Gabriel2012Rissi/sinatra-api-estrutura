class UserQuery
  module Scopes
    def by_email(email)
      return nil if email.blank?
      find_by(email: email)
    end

    def by_token(token)
      return nil if token.blank?
      find_by(token: token)
    end
  end

  def self.find_by_email(email)
    User.extending(Scopes).by_email(email)
  end

  def self.find_by_token(token)
    User.extending(Scopes).by_token(token)
  end
end