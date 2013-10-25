class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :is_owner, only:[:edit, :update, :destroy]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    if params[:user_id]
      @posts = Post.where(user_id: current_user).order('created_at DESC')
    elsif params[:search]
      @posts = Post.search(params[:search])
    else
      @posts= Post.order('created_at desc')
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @comment.post_id = @post.id
  end

  def myposts
    @posts = Post.where(contact_id: params[:contact_id]).order('created_at Desc')
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :contact_id, :title, :body, :contact_date,:action_item, :complete, :contact_type_id)
    end

    def is_owner
      if current_user.id != @post.user_id
         flash[:notice] = "You can ONLY modify your own record!"
         redirect_to posts_url
      end
    end
end
