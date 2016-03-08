class PostsController < ApplicationController
  before_action :require_login, only: [:create]

  def index
    @posts = Post
      .includes(:user)
      .where(user_id: current_user.following_ids << current_user.id)
      .order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to posts_path
    else
      redirect_to posts_path,
        notice: 'Something is wrong',
        status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :parent_id)
  end
end
