# frozen_string_literal: true

module Admin
  class ImagensController < BaseController
    def index
      @imagens = Imagem.recentes.with_attached_arquivo
    end

    def create
      @imagem = Imagem.new(imagem_params)
      if @imagem.save
        redirect_to admin_imagens_path, notice: "Imagem enviada."
      else
        @imagens = Imagem.recentes.with_attached_arquivo
        render :index, status: :unprocessable_entity
      end
    end

    def destroy
      Imagem.find(params[:id]).destroy!
      redirect_to admin_imagens_path, notice: "Imagem removida."
    end

    private

    def imagem_params
      params.require(:imagem).permit(:arquivo, :legenda)
    end
  end
end
