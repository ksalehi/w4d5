class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.author_id = current_user.id
    if @comment.save
      flash_add("Successfully posted comment")
      redirect_to post_url(@comment.post_id)
    else
      flash_now(@comment.errors.full_messages)
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end

  def update
    @comment = Comment.find(params[:id])

    if @commend.update_attributes(comment_params)
      flash_add("Successfully updated comment")
      redirect_to post_url(@comment.post_id)
    else
      flash_now(@comment.errors.full_messages)
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
