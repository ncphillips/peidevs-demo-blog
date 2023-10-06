class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post_params = {
      title: params[:post][:title],
      body: params[:post][:body],
    }

    @post = Post.new(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream { redirect_to new_post_path }
      end
    else
      render :new
    end
  end
end
