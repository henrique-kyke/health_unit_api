class UbsImporter

  attr_reader :schema, :data

  def initialize
    @data = []
    load_schema
  end

  def perform
    load_data
    import
  end

  private

  def load_data(reader: UbsCsvReader.new)
    @data = reader.read
  end

  def import
    data.each do |hash|
      params = transform(hash)
      HealthUnit.create(params)
    end
  end

  def transform(hash)
    sliced = hash.slice(*schema.keys)
    return schema.each_with_object({}) do |array, object|
      object[array.last.to_sym] = sliced[array.first]
    end
  end

  def load_schema
    path = "#{Rails.root}/app/business/schemas/health_unit_schema.yml"
    @schema = YAML.load(File.read(path)).fetch('ubs')
  end
end