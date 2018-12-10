module Api
  module VersionOne
    class HealthUnitsController < ApplicationController
      before_action :get_search_parameters

      def search
        search = Search::HealthUnitSearch.new(get_search_parameters)
        render json: search.result
      end

      protected

      def get_search_parameters
        params.permit(:query, :page, :per_page)
      end
    end
  end
end
