module Api
  module V1
    class UsersController < ApplicationController
      namespace '/api/v1' do  
        get '/user' do
          env['warden'].authenticate!(:access_token)

          @user = get_user_by_token
          
          JSONAPI::Serializer.serialize(@user, namespace: Api::V1).to_json
        end

        patch '/user' do
          env['warden'].authenticate!(:access_token)

          @user = get_user_by_token
          
          if @user.update(user_params)
            JSONAPI::Serializer.serialize(@user, namespace: Api::V1).to_json
          else
            halt 422,
            {
              code: '422',
              message: @user.errors.full_messages
            }.to_json
          end
        end

        delete '/user' do
          env['warden'].authenticate!(:access_token)

          @user = get_user_by_token
          
          if @user.destroy
            JSONAPI::Serializer.serialize(@user, namespace: Api::V1).to_json
          else
            halt 204,
            {
              code: '204',
              message: @user.errors.full_messages
            }.to_json
          end
        end
      end

      private

      def get_user_by_token
        access_token = request.env['HTTP_AUTHORIZATION'].split(' ').last
        @user = UserQuery.find_by_token(access_token)
      end

      def user_params
        params = json_params(request.body.read)
      end
    end
  end
end