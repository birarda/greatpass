class UserController < ApplicationController
  before_action :authenticate_user!

  def resend_confirmation
    current_user.send_confirmation_instructions
    render json: { status: 'success' }
  end
end
