class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:platform, :platform_username, :platform_url, :reddit_username])
    end

    def platform_from_url_string(platform_string)
      downcase_platform = platform_string.downcase

      if downcase_platform == 'steam'
        User.platforms[:Steam]
      elsif downcase_platform == 'psn'
        User.platforms[:PSN]
      elsif downcase_platform == 'xbox'
        User.platforms[:Xbox]
      end
    end

    def authenticate_admin!
      if !current_user || !current_user.admin?
        render file: "public/404.html", status: :not_found, layout: false
      end
    end
end
