module Api
  module V1
    class CarSerializer < BaseSerializer
      def type
        'cars'
      end

      attributes :brand, :name, :year

      attribute :price do
        object.price_formatted
      end
    end
  end
end