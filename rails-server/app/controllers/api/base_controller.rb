class Api::BaseController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::StrongParameters
  include ActionController::ImplicitRender
  include ActionController::Serialization

  before_action :authenticate, except: :not_found

  attr_accessor :current_user
  helper_method :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request

  def not_found
    render json: { message: 'Unkown request' }, status: :not_found
  end

  private

  def record_not_found
    render json: { message: 'Resource not found' }, status: :not_found
  end

  def bad_request
    render json: { message: 'Bad request' }, status: :bad_request
  end

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_or_request_with_http_token do |token, _options|
      self.current_user = User.find_by(auth_token: token)
    end
  end

  def render_unauthorized
    self.current_user = nil
    headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { message: 'Unauthorized' }, status: :unauthorized
  end
end
