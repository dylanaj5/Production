class User::SessionsController < Devise::SessionsController
  helper_method :verify_recaptcha
  skip_before_filter :require_no_authentication, :only => [:new]
  
  def create
   if verify_recaptcha
          super
        else
          build_resource(sign_up_params)
          clean_up_passwords(resource)
          flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
          flash.delete :recaptcha_error
          render :new
   end
  end

# before_filter :configure_sign_in_params, only: [:create]

    #GET /resource/sign_in
    #super
    #verify_recaptcha(:model => @User, :message => "Oh! It's an error with reCAPTCHA!")
    #end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
