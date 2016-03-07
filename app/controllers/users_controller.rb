class UsersController < Clearance::UsersController
  before_action :set_user, only: [:show]

  def show
  end

  private

  def set_user
    @user = User.includes(:posts)
      .find_by(username: params[:username])
  end

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end
