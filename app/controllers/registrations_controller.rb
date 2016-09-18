class RegistrationsController < Devise::RegistrationsController

  def new
    super do |resource|
      resource.signup_code = 'prl' if request.fullpath == '/prl'
    end
  end

end
