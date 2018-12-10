require 'csv'
class UbsCsvReader

  attr_reader :source_data, :body

  delegate :parse, to: CSV
  delegate :open, to: File

  def initialize
    load_source_data
  end

  def read
    @body = parse( source_data, headers: true).map { |row| row.to_hash }
    body
  end

  private
  def load_source_data
    @source_data = open("#{Rails.root}/#{Figaro.env.ubs_file_name}", "r+")
  end

end