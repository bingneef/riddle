# app/controllers/oauths_controller.rb
class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    puts params
    provider = params[:provider]
    provider = 'google'
    if user = login_from(provider)
      user.generate_auth_token
      user.save
      render json: {token: user.auth_token}
    else
      begin
        user = create_from(provider)
        reset_session
        user.generate_auth_token
        user.save
        auto_login(user)
        redirect_to "http://localhost:3000/#/login?callback=true&auth_token=#{user.auth_token}"
      rescue
        puts 'rescue'
        render nothing: true, status: 404
      end
    end
  end

  # private
  # def auth_params
  #   params.permit(:code, :provider, :prompt)
  # end

end
