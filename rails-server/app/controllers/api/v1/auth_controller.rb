require 'net/http'

module Api
  module V1
    class AuthController < Api::BaseController
      skip_before_action :authenticate, only: :create

      def create
        user = User.find_by_email!(params[:email])
        if user.valid_password?(params[:password])
          user.generate_auth_token
          user.save
          render json: user
        else
          render_unauthorized
        end
      end

      def index
        require 'net/http'

        uri = URI.parse("http://83.84.36.136:8000/transmit")

        # Full control
        http = Net::HTTP.new(uri.host, uri.port)

        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({"room" => "testtest", "transmitKind" => "slaveIncoming", "someMegaCoolThing" => "Else"})
        if http.request(request)
          head :ok
        else
          head 500
        end
      end

      def destroy
        current_user.logout!
        render json: {}
      end
    end
  end
end
