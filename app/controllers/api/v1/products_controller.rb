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
    end
  end
end
