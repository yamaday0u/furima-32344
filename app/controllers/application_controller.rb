class ApplicationController < ActionController::Base
  before_action :basic_authentication
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,
                                                       :user_iamge,
                                                       :first_name,
                                                       :family_name,
                                                       :first_name_kana,
                                                       :family_name_kana,
                                                       :birthday,
                                                       :avatar,
                                                       :introduction])
  end

  def basic_authentication
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER_FURIMA'] && password == ENV['BASIC_AUTH_PASSWORD_FURIMA']
    end
  end
end
