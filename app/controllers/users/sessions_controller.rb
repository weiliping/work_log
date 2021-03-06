class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    if request.xhr?
      respond_to do |format|
        format.js { render "/devise/sessions/signin" }
      end
    else
      super
      Rails.logger.debug "------------------ ---resource_name #{resource_name}"
    end
  end

  # POST /resource/sign_in
  def create
    if request.xhr?
      respond_to do |format|
        format.js { render "/devise/sessions/signin_succeed" }
      end
    else
      super
      Rails.logger.debug "------------------ ---resource_name #{resource_name}"
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
