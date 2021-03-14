class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @user = current_user
    if @comment.save
      @time = @comment.created_at.strftime("%Y年%-m月%-d日 %-H時%-M分")
      ActionCable.server.broadcast 'comment_channel', content: @comment, user: @user, time: @time
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end