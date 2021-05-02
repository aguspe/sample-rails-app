class MicropostsController < ApplicationController

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Mircropost created!'
      redirect_to :root and return
    end
    @feed_items = current_user.feed.page(params[:page])
    render 'static_pages/home'
  end

  def destroy;end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
