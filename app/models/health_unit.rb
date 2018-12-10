class HealthUnit
  include Mongoid::Document
  include Mongoid::Timestamps
  include Serializable
  include Attributes

  field :name, type: String
  field :address, type: String
  field :city, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  field :phone, type: String
  field :size, type: String
  field :adaptation_for_seniors, type: String
  field :medical_equipment, type: String
  field :medicine, type: String

  def geocode
    {lat: latitude, lon: longitude}
  end

end
