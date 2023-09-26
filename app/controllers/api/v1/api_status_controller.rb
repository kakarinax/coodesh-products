module Api
  module V1
    class ApiStatusController < ApplicationController
      def index
        render json: { db_status: db_status_message, last_execution: }, status: db_status_code
      end

      private

      def mongo_db
        Mongoid.default_client.database
      end

      def db_status_message
        mongo_db.command(ping: 1)
        'OK'
      rescue StandardError => e
        "Error to connect to database: #{e.message}"
      end

      def db_status_code
        db_status_message == 'OK' ? :ok : :internal_server_error
      end

      def last_execution
        @last_execution ||= ImportHistory.last
      end
    end
  end
end
