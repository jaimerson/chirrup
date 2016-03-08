class UsersController < Clearance::UsersController
  before_action :set_user, only: [:show]

  def show
  end

  def follow
    @user = User.find_by!(username: params[:username])
    if current_user.follow(@user)
      redirect_to user_path(@user.username)
    else
      redirect_to(request.referrer || root_path, notice: 'Something went wrong')
    end
  end

  def unfollow
    @user = User.find_by!(username: params[:username])
    followership = Followership.find_by!(user_id: @user.id, follower: current_user)
    if followership.destroy
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
