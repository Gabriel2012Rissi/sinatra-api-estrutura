module Api
  module Auth
    class AuthController < ApplicationController
      namespace '/api/auth' do
        post '/login' do
          params = json_params(request.body.read)

          @user = UserQuery.find_by_email(params['email'])
          
          if @user&.authenticate(params['password'])
            halt 200,
            {
              data: {
                type: 'user',
                id: @user.id,
                attributes: {
                  token: @user.token
                }
              }
            }.to_json
          else
            halt 401
          end
        end

        post '/signup' do
          params = json_params(request.body.read)

          @user = User.new(params)

          if @user.save
            halt 201,
            {
              data: {
                type: 'user',
                id: @user.id,
                attributes: {
                  token: @user.token
                }
              }
            }.to_json
          else
            halt 422,
            {
              code: '422',
              message: @user.errors.full_messages
            }.to_json
          end
        end
      end
    end
  end
end