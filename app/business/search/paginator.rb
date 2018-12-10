module Search
  class Paginator
    attr_reader :search, :objects, :pagination

    def initialize(search, page, per_page)
      @search = search
      paginate(page, per_page)
    end

    def paginate(page, per_page)
      @pagination = {
        current_page: page,
        per_page: per_page,
        total_entries: search.total_entries,
        entries: search.results.map(&:serialized)
      }
    end
  end
end