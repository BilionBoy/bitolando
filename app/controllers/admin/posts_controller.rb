# frozen_string_literal: true

module Admin
  class PostsController < BaseController
    before_action :set_post, only: %i[show edit update destroy]

    def index
      @posts_publicados = Post.publicados.por_data.includes(:categoria, :status)
      @posts_rascunhos  = Post.rascunhos.por_data.includes(:categoria, :status)
    end

    def show
      redirect_to edit_admin_post_path(@post)
    end

    def new
      @post = Post.new
      @post.status = Status.find_by(nome: "rascunho")
    end

    def edit; end

    def create
      @post = Post.new(post_params)
      @post.publicado_em = Time.current if @post.status&.publicado?

      if @post.save
        redirect_to admin_posts_path, notice: "Post criado com sucesso."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @post.publicado_em ||= Time.current if post_params[:status_id].present? &&
                                              Status.find_by(id: post_params[:status_id])&.publicado?

      if @post.update(post_params)
        redirect_to admin_posts_path, notice: "Post atualizado."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy!
      redirect_to admin_posts_path, notice: "Post excluído."
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:titulo, :slug, :corpo, :video_url, :imagem, :categoria_id, :status_id, :publicado_em)
    end
  end
end
