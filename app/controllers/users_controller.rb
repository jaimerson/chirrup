class UsersController < Clearance::UsersController

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end
