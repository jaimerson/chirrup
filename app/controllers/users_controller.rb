class UsersController < Clearance::UsersController
  before_action :set_user_including_posts, only: [:show]
  before_action :set_user, only: [:followers, :following, :follow, :unfollow]

  def show
  end

  def search
    @users = User.search_by_username(params[:username])
    respond_to do |format|
      format.json { render json: @users.as_json(only: :username) }
      format.html
    end
  end

  def followers
    @users = @user.followers
    render 'index'
  end

  def following
    @users = @user.following
    render 'index'
  end

  def follow
    if current_user.follow(@user)
      redirect_to user_path(@user.username)
    else
      redirect_to(request.referrer || root_path, notice: 'Something went wrong')
    end
  end

  def unfollow
    followership = Followership.find_by!(user_id: @user.id, follower: current_user)
    if followership.destroy
      redirect_to user_path(@user.username)
    else
      redirect_to(request.referrer || root_path, notice: 'Something went wrong')
    end
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

  def set_user_including_posts
    @user = User.includes(:posts)
      .find_by(username: params[:username])
  end

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end
