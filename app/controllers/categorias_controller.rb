# frozen_string_literal: true

class CategoriasController < ApplicationController
  def show
    @categoria = Categoria.find_by!(slug: params[:id])
    @posts = @categoria.posts.publicados.por_data.includes(:post_status)
    @todas_categorias = Categoria.ordenadas
    @anos = @posts.map { |p| p.publicado_em&.year }.compact.uniq.sort.reverse
  end
end
