module Api
  module V1
    class UserSerializer < BaseSerializer
      attribute :name do 
        object.full_name
      end

      attributes :email, :username, :token
    end
  end
end