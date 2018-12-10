module Attributes
  extend ActiveSupport::Concern

  module ClassMethods

    def available_fields
      fields.map(&:first) + relations.map(&:first)
    end

  end

end
