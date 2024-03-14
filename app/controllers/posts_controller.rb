class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, except: [:index, :new, :create] 
  
  def index
    @posts = user_signed_in? ? Post.sorted : Post.published.sorted
    @pagy, @posts = pagy(Post.all)
  rescue Pagy::OverflowError
    redirect_to root_path(page: 1)

    # params[:page] = 1
    # retry
  end
  def show
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
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :content, :status, :published_at)
    end
    def set_post
      @post =  user_signed_in? ? Post.find(params[:id]) : Post.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

    def authenticate_user!
      redirect_to new_user_session_path, alert: "You must sign in or sign up to continue" unless user_signed_in?
    end
  end