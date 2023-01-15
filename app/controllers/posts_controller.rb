class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]
  # before_action :check_auth, except: %i[show index]
  # before_action :check_published_status, only: %i[show]
  # before_action :check_owner_access, only: %i[update destroy]


  # GET /posts or /posts.json
  def index
    @mode = params[:mode]

    render(json: Post.all.published) unless current_user

    puts @mode
    case @mode
      when 'my' then  render json: Post.where(owner_id: current_user.id).order(:id)
      when 'all' then render json: (current_user.has_admin_access? ? Post.all.order(:published, :id) : 'Permission denied.')
      else
        render json: Post.all.published
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    render json: @post
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.owner_id = current_user&.id

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      render json: @post, status: :ok, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      begin
        @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: 'Post not found.'
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :text, :published)
    end

    def check_published_status
      return if current_user.has_admin_access? || @post&.owner_id == current_user.id

      unless @post&.published
        render json: 'Permission denied.'
      end
    end

    def check_owner_access
      return if current_user.superadmin?
  
      unless @post&.owner_id == current_user.id
        render json: 'Permission denied.'
      end
    end
end
