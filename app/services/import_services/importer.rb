module ImportServices
  class Importer
    def import_file(file_name, destination_file)
      response = Faraday.get("https://challenges.coode.sh/food/data/json/#{file_name}").body

      File.binwrite(destination_file, response)
      true
    rescue StandardError => e
      Rails.logger.error(e)
      false
    end
  end
end
