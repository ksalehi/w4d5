class PostsController < ApplicationController
  before_action :ensure_logged_in!, except: [:show]
  before_action only: [:edit, :update, :destroy] do
    ensure_moderator(get_auth_id)
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      flash_add("Successfully created post")
      redirect_to post_url(id: @post.id)
    else
      flash_now(@post.errors.full_messages)
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash_add("Successfully updated post")
      redirect_to post_url(id: @post.id)
    else
      flash_now(@post.errors.full_messages)
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.nil?
      flash_now("Post not found")
      render :show
    else
      #EDIT this
      fail
      @post.destroy
      flash_add("Post successfully deleted")
      redirect_to sub_url(sub_id)
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def get_auth_id
    auth_id = Post.find(params[:id]).author_id
  end

  private
  def post_params
    params.require(:post).permit(:title,
      :content, :author_id, :sub_id, :url, sub_ids: [])
  end
end
