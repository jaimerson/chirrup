class UsersController < Clearance::UsersController
  before_action :set_user, only: [:show]

  def show
  end

  def follow
    @user = User.find_by(username: params[:username])
    if @user && current_user.follow(@user)
      redirect_to user_path(@user.username)
    else
      redirect_to(request.referrer || root_path, notice: 'Something went wrong')
    end
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
