module ClioClient
  module Api
    module Crudable

      def new(params = {})
        data_item(params)
      end

      def create(data = {}, params = {})
        begin
          resource = data.is_a?(Array) ? create_plural(data, params) : create_singular(data, params)
        rescue ClioClient::UnknownResponse
          false
        end
      end

      def update(id, data = {})
        begin
          response = session.put("#{end_point_url}/#{id}", {singular_resource => data}.to_json)
          data_item(response[singular_resource])        
        rescue ClioClient::UnknownResponse
          false
        end
      end

      def destroy(id, params = {})
        begin
          session.delete("#{end_point_url}/#{id}", params, false)
        rescue ClioClient::UnknownResponse
          false
        end
      end

      private

      def create_singular(data, params)
        response = session.post(end_point_url, {singular_resource => data}.to_json, params)
        data_item(response[singular_resource])
      end

      def create_plural(data, params)
        response = session.post(end_point_url, {plural_resource => data}.to_json, params)
        response[plural_resource].map do |resource|
          # Errors are presented inline when doing bulk create via the Clio API
          if resource.key?("errors")
            resource
          else
            data_item(resource)
          end
        end
      end

    end
  end
end
