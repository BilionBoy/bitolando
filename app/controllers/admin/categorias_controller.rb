# frozen_string_literal: true

module Admin
  class CategoriasController < BaseController
    before_action :set_categoria, only: %i[edit update destroy]

    def index
      @categorias = Categoria.ordenadas.includes(:posts)
    end

    def new
      @categoria = Categoria.new
    end

    def edit; end

    def create
      @categoria = Categoria.new(categoria_params)
      if @categoria.save
        redirect_to admin_categorias_path, notice: "Categoria criada."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @categoria.update(categoria_params)
        redirect_to admin_categorias_path, notice: "Categoria atualizada."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @categoria.destroy!
      redirect_to admin_categorias_path, notice: "Categoria excluída."
    rescue ActiveRecord::DeleteRestrictionError
      redirect_to admin_categorias_path, alert: "Não é possível excluir: existem posts nesta categoria."
    end

    private

    def set_categoria
      @categoria = Categoria.find(params[:id])
    end

    def categoria_params
      params.require(:categoria).permit(:nome, :slug, :descricao, :posicao)
    end
  end
end
