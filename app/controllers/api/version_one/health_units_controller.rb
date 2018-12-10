module Api
  module VersionOne
    class HealthUnitsController < ApplicationController

      def search
        health_units = HealthUnit.limit(100)
        render json: health_units
      end
    end
  end
end
