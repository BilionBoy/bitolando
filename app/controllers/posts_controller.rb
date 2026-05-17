# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @post_destaque = Post.publicados.por_data.includes(:categoria).first
    @posts_arquivo = Post.publicados.por_data.includes(:categoria).offset(1)
    @anos = @posts_arquivo.map { |p| p.publicado_em&.year }.compact.uniq.sort.reverse
  end

  def show
    @post = Post.publicados.includes(:categoria).find_by!(slug: params[:id])
    @anterior = Post.publicados.por_data.where("publicado_em < ?", @post.publicado_em).first
    @proximo  = Post.publicados.por_data.where("publicado_em > ?", @post.publicado_em).last
  end
end
