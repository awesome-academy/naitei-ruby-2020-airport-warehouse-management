class Location < ApplicationRecord
  belongs_to :warehouse
  has_many :requests, dependent: :destroy
  has_many :planes, through: :requests

  scope :gara_false, ->{where(warehouse_id: Settings.warehouse.gara, filled: false)}
  scope :location_false, ->{where(_not_exists(Request.where("requests.location_id = locations.id").process))}
  scope :ready_false, ->{where(warehouse_id: Settings.warehouse.ready, filled: false)}
  scope :get_radar, ->{where(warehouse_id: Settings.warehouse.gara)}
  scope :get_ready, ->{where(warehouse_id: Settings.warehouse.ready)}

  delegate :name, to: :warehouse, prefix: true, allow_nil: true

  def self._not_exists scope
    "NOT #{_exists(scope)}"
  end

  def self._exists scope
    "EXISTS(#{scope.to_sql})"
  end

  def id_initial
    id.to_s
  end
end
