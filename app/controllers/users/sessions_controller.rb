# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
    render json: {
             status: { code: 200, message: "Logged in sucessfully" },
             data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
           }
          else
    render json: {
             status: { message: `User couldn't be created. #{resource.errors.full_messages.to_sentence}` },
           }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    if currrent_user
      render json: {
               status: 200,
               message: "Logged out sucessfully",
             }, status: :ok
    else
      render json: {
               status: 401,
               message: `Couldn't find an active session`,
             }, status: :unauthorized
    end
  end
end
