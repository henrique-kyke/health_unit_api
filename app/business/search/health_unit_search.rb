module Search
  class HealthUnitSearch

    attr_reader :query, :page, :per_page, :result

    delegate :search, to: HealthUnit

    def initialize(params)
      @query = params[:query]
      @page = params[:page] || 1
      @per_page = params[:per_page] || 10
      make_search
    end

    private

    def make_search(paginator: Search::Paginator)
      response = search("*", boost_by_distance: {geocode: {origin: get_geocode}}, page: page, per_page: per_page)
      @result = paginator.new(response, page, per_page).pagination
    end

    def get_geocode
      raise_no_location if query.blank?
      coordinates = query.split(",")
      {lat: coordinates[0], lon: coordinates[1]}
    end

    def raise_no_location
      raise Exceptions::Simple.build(field: "query", message: I18n.t('exceptions.no_location'))
    end
  end
end