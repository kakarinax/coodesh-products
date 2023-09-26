module ImportServices
  class GetProductsFromFile
    def decompress_data(file_name)
      compressed_data = File.read(file_name)
      decompressed_data = Zlib::GzipReader.new(StringIO.new(compressed_data)).read

      json_objects(decompressed_data) if decompressed_data
    end

    def json_objects(decompress_data)
      json_objects = decompress_data.split("\n")

      products = json_objects.map do |json_object|
        JSON.parse(json_object)
      end

      save_products_in_bulks(products)
    end

    def save_products_in_bulks(batch)
      batch = batch.first(100)
      products_to_create = bulk_insert_data(batch)

      existing_products = find_existing_products(products_to_create)

      products_to_insert = products_to_create - existing_products

      insert_products(products_to_insert)
    end

    private

    def find_existing_products(products_to_create)
      existing_products = []
      products_to_create.each do |product|
        existing_products << product if Product.find_by(code: product[:code])
      end
    end

    def insert_products(products_to_insert)
      success_count = 0
      failed_products = []

      begin
        if products_to_insert.any?
          Product.collection.insert_many(products_to_insert)
          success_count = products_to_insert.count
        end
      rescue MongoDB::Error::BulkWriteError => e
        Rails.logger.error(e)
        failed_products = products_to_insert
      end
      { success_count:, failed_products: }
    end

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def bulk_insert_data(batch)
      batch.map do |product|
        {
          code: product['code'],
          status: product['status'] || 'draft',
          imported_t: product['imported_t'] || Time.now.iso8601,
          url: product['url'],
          creator: product['creator'],
          product_name: product['product_name'],
          quantity: product['quantity'],
          brands: product['brands'],
          categories: product['categories'],
          labels: product['labels'],
          cities: product['cities'],
          purchase_places: product['purchase_places'],
          stores: product['stores'],
          ingredients_text: product['ingredients_text'],
          traces: product['traces'],
          serving_size: product['serving_size'],
          serving_quantity: product['serving_quantity'],
          nutriscore_score: product['nutriscore_score'],
          main_category: product['main_category'],
          image_url: product['image_url']
        }
      end
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize
  end
end
