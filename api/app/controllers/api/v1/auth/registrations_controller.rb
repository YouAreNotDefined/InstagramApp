class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

  def sign_up_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:registration).permit(
      :email, :name, :nickname, :description, :website,
      :phone_number, :image, :gender_id, :gender_detail
    )
  end
end
