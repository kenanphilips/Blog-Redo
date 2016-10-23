class CommentsController < ApplicationController

  def create
    # @post = Post.find(params[:post_id])
    # @comment = @post.comments.create(params[:comment].permit(:name, :body))
    @comment = Comment.new(params.require(:comment).permit(:body, :user_id))
    @post = Post.find params[:post_id]
    @comment.post = @post
    @comment.user = current_user

    respond_to do |format|

      if @comment.save
        format.html { redirect_to post_path(@post) }
        # format.js { render js: "alert('Does this browser support JS?');" }
        format.js { render :create_success } # will look for file in view called comments/create_success.js.erb
      else
        format.html { render "/posts/show" }
        format.js { render :create_failure }
        # will look for file in views called comments/create_failure.js.erb
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    # @comment = @post.comments.find(params[:id])
    @comment = Comment.find params[:id]
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      # format.js { render :destroy_success }
      format.js { render } # render /app/views/comments/destroy.js.erb
    end
  end
end
