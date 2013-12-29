module ClioClient
  module Api
    class Task < Base

      include ClioClient::Api::Listable
      include ClioClient::Api::Findable
      include ClioClient::Api::Crudable


      private

      def data_klass(*args)
        ClioClient::Task
      end

      def end_point_url;     'relationships';  end
      def plural_resource;   'relationships';  end
      def singular_resource; 'relationship';   end

    end
  end
end
