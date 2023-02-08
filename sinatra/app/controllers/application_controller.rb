class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Namespace

  before do 
    content_type 'application/vnd.api+json'
  end

  helpers do
    # Helper method to parse JSON request parameters.
    def json_params(body)
      begin
        JSON.parse(body).with_indifferent_access
      rescue
        halt 400, 
        { 
          code: 400, 
          message: I18n.t('errors.custom.invalid_json') 
        }.to_json
      end
    end
  end

  # Configure Warden.
  use Warden::Manager do |config|
    config.scope_defaults :default,
                          # Set your authorization strategy.
                          strategies: [:access_token],
                          # Route to redirect to when warden.authenticate! returns a false answer.
                          action: '/unauthenticated'
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env|
    env['REQUEST_METHOD'] = 'POST'
  end

  # Implement your Warden stratagey to validate and authorize the access_token.
  Warden::Strategies.add(:access_token) do
    def valid?
      # Validate that the access token is properly formatted.
      # Currently only checks that it's actually a string.
      request.env['HTTP_AUTHORIZATION'].is_a?(String)
    end

    def authenticate!
      access_token = request.env['HTTP_AUTHORIZATION'].split(' ').last
      access_granted = UserQuery.find_by_token(access_token)
      access_granted ? success!(access_granted) : fail!(I18n.t('errors.custom.warden.unauthenticated'))
    end  
  end

  # Route to redirect to when warden.authenticate! returns a false answer.
  post '/unauthenticated' do
    halt 401,
    { 
      code: 401,
      message: I18n.t('errors.custom.warden.unauthenticated')
    }.to_json
  end
end