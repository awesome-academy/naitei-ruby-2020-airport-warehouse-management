Unit.create!(name: "WM", description: "Warehouse Management")
Unit.create!(name: "SM", description: "Store Management")

Warehouse.create!(name: "Khu sửa chữa", area: "3 km2", amount: 100)
Warehouse.create!(name: "Khu ready", area: "5 km2", amount: 100)

User.create!(name: "Radar's admin", email: "admin1@airport.org", password: "123456", password_confirmation: "123456",
  admin: true, activated: true, activated_at: Time.zone.now, warehouse_id: 1, unit_id: 1)

User.create!(name: "Ready admin", email: "admin2@airport.org", password: "123456", password_confirmation: "123456",
  admin: true, activated: true, activated_at: Time.zone.now, warehouse_id: 2, unit_id: 1)

warehouses = Warehouse.order(:created_at).take(2)
2.times do |n|
  name = "Manager Example"
  email = "manager#{n+1}@airport.org"
  password = "123456"
  warehouses.each { |warehouses| warehouses.users.create!(name: name, email: email, password: "123456", password_confirmation: "123456",
    manager: true, activated: true, activated_at: Time.zone.now, unit_id: 1) }
end

30.times do |n|
  name = Faker::Name.name
  email = "employee#{n+1}@airport.org"
  password = "123456"
  warehouses.each { |warehouses| warehouses.users.create!(name: name, email: email, password: "123456", password_confirmation: "123456",
    activated: true, activated_at: Time.zone.now, unit_id: 1) }
end

50.times do |n|
  warehouses.each { |warehouses| warehouses.locations.create!(filled: false) }
end

locations = Location.all
60.times do |n|

  plane = Plane.create!(
    code: "ABC10#{n+1}"
  )

  locations[n].update_column :filled, true
  if locations[n].warehouse_id == 1
    plane.requests.create(
      location: locations[n],
      time: Time.zone.now,
      reason: "Need to Repair",
      accept: true,
      processing: false,
      user_id: 1
    )
    plane.update_column :status, "in gara"
  else
    plane.requests.create(
      location: locations[n],
      time: Time.zone.now,
      reason: "Repaired",
      accept: true,
      processing: false,
      user_id: 2
    )
    plane.update_column :status, "ready"
  end
end

ACCESSORIES = %w[wheels wings screws Gears]
4.times do |n|
  Component.create!(name: ACCESSORIES.pop, amount: 1000)
end
