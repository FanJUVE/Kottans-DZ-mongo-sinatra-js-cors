class Weather
  include Mongoid::Document

  field :city,  type: String
  field :date,  type: DateTime
  field :value,  type: String
end