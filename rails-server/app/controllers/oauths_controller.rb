# app/controllers/oauths_controller.rb
class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    user_hash = sorcery_fetch_user_hash(provider)
    if self.current_user = login_from(provider)
      self.current_user.generate_auth_token
      self.current_user.save
      redirect_to "http://localhost:3000/#/oauth2?callback=true&auth_token=#{self.current_user.auth_token}"
    elsif self.current_user = User.find_by_email(user_hash[:user_info]["email"])
      add_provider_to_user(provider)
      self.current_user.generate_auth_token
      self.current_user.save
      redirect_to "http://localhost:3000/#/oauth2?callback=true&auth_token=#{self.current_user.auth_token}"
    else
      begin
        user = create_and_validate_from(provider)
        reset_session
        user.generate_auth_token
        user.save
        auto_login(user)
        redirect_to "http://localhost:3000/#/oauth2?callback=true&auth_token=#{user.auth_token}"
      rescue
        render nothing: true, status: 404
      end
    end
  end

end
