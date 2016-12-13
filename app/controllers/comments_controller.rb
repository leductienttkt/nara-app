class CommentsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
  before_action :correct_user, only: [:destroy, :eidt, :update]

  def create
  	@micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
      end
  	end
  end

  def destroy
    @micropost = Micropost.find(@comment.micropost_id)
    @comment.destroy
    respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    end
    else
      render 'edit'
    end
  end

  private

    def correct_user
      @comment = Comment.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
      redirect_to root_url unless (current_user?(@comment.user) || current_user?(@comment.micropost.user))
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end
