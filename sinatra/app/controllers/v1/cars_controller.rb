module Api
  module V1
    class CarsController < ApplicationController
      namespace '/api/v1' do
        get '/cars' do
          @cars = CarDecorator.decorate_collection(CarQuery.call(params))
          
          JSONAPI::Serializer.serialize(
            @cars, 
            is_collection: true, 
            namespace: Api::V1,
            serializer: CarSerializer
          ).to_json
        end

        get '/cars/:id' do
          @car = CarDecorator.decorate(Car.find(params[:id]))

          JSONAPI::Serializer.serialize(
            @car, 
            namespace: Api::V1,
            serializer: CarSerializer
          ).to_json
        end

        post '/cars' do
          env['warden'].authenticate!(:access_token)

          @car = Car.new(car_params)
          
          if @car.save
            JSONAPI::Serializer.serialize(@car, namespace: Api::V1).to_json
          else
            halt 422, { code: '422', message: @car.errors.full_messages }.to_json
          end
        end

        patch '/cars/:id' do
          env['warden'].authenticate!(:access_token)

          @car = Car.find(params[:id])

          if @car.update(car_params)
            JSONAPI::Serializer.serialize(@car, namespace: Api::V1).to_json
          else
            halt 422, { code: '422', message: @car.errors.full_messages }.to_json
          end
        end

        delete '/cars/:id' do
          env['warden'].authenticate!(:access_token)
          
          @car = Car.find(params[:id])

          if @car.destroy
            halt 200, { code: '200', message: 'Car deleted' }.to_json
          else
            halt 204, { code: '204', message: @car.errors.full_messages }.to_json
          end
        end
      end

      private

      def car_params
        params = json_params(request.body.read)
      end
    end
  end
end