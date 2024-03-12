class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, except: [:index, :new, :create] 
  
  def index
<<<<<<< HEAD
    @posts = Post.all
  end
  def show
    @post = Post.find(params[:id])
=======
    @posts = user_signed_in? ? Post.sorted : Post.published.sorted
  end
  def show
>>>>>>> a2048b7 (New task for ruby)
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end
  
  private
    def post_params
<<<<<<< HEAD
      params.require(:post).permit(:title, :body, :status)
    end
    def set_post
      @post = Post.find(params[:id])
=======
      params.require(:post).permit(:title, :body, :status, :published_at)
    end
    def set_post
      @post =  user_signed_in? ? Post.find(params[:id]) : Post.published.find(params[:id])
>>>>>>> a2048b7 (New task for ruby)
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

    def authenticate_user!
      redirect_to new_user_session_path, alert: "You must sign in or sign up to continue" unless user_signed_in?
    end
end
