module Api
  module V1
    class ProductsController < ApplicationController
      include Pagy::Backend

      def index
        @pagy, @products = pagy_array(Product.all.to_a)
        pagy_headers_merge(@pagy)

        render json: { message: 'No products found' }, status: :not_found if @products.empty?
        render json: @products, status: :ok unless @products.empty?
      end

      def show
        @product = Product.find_by(code: params[:code])

        render json: { message: 'Product not found' }, status: :not_found unless @product
        render json: @product, status: :ok if @product
      end

      def delete
        @product = Product.find_by(code: params[:code])

        return render json: { message: 'Product not found' }, status: :not_found unless @product

        product_update_status
      end

      private

      def product_update_status
        if @product.update!(status: 'trash')
          render json: { message: 'Product deleted' }, status: :ok
        else
          render json: { message: 'Product could not be deleted' }, status: :unprocessable_entity
        end
      end
    end
  end
end
