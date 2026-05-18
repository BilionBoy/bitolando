# frozen_string_literal: true

class PaginasController < ApplicationController
  def sobre; end

  def rss
    @posts = Post.publicados.por_data.includes(:categoria).limit(20)
    respond_to do |format|
      format.xml { render layout: false }
    end
  end

  def sitemap
    @posts = Post.publicados.por_data
    @categorias = Categoria.ordenadas
    respond_to do |format|
      format.xml { render layout: false }
    end
  end
end
