class HealthUnitSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :city, :phone, :geocode, :scores

  def id
    object.id.to_s
  end

  def scores
    {
      size: scored_attr(object.size),
      adaptation_for_seniors: scored_attr(object.adaptation_for_seniors),
      medical_equipment: scored_attr(object.medical_equipment),
      medicine: scored_attr(object.medicine)
    }
  end

  def scored_attr(value)
    case value
    when "Desempenho mediano ou  um pouco abaixo da média"
      1
    when "Desempenho acima da média"
      2
    when "Desempenho muito acima da média"
      3
    else
      nil
    end
  end
end
