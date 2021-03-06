class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy, :update]
  before_action :correct_user,   only: [:destroy, :update]

  def index
    @microposts = Micropost.paginate(page: params[:page])
  end
  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments
    respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
    end
  end
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      #flash[:danger] = "Micropost not created!"
      render 'static_pages/home'
      #redirect_to root_url
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
	
  def edit
    @micropost = Micropost.find(params[:id])
    respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    end
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
    end
    else
      render 'edit'
    end
  end
	
  private

    def micropost_params
        params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
