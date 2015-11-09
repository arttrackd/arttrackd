# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "Julie", email: "julie@email.com", password: "password")
User.create(name: "Angela", email: "angela@email.com", password: "password")
User.create!(name: "Phil", email: "Phil_is_awesome@yeah.com", password: "password", public_profile: false, time_zone: "Eastern Time (US & Canada)", hourly_rate: 12.33)
User.create!(name: "Kevin", email: "kevin@hotmail.com", password: "password", public_profile: false, time_zone: "Eastern Time (US & Canada)", hourly_rate: 12.33)
User.create!(name: "Dead", email: "DeamonKiller@hunter.com", password: "password", public_profile: false, time_zone: "Eastern Time (US & Canada)", hourly_rate: 12.33)

Project.create(user_id: 1, name: "Fire on the Mountaintop", description: "painting")
Project.create!(user_id: 1, name: "LiesOnFire", description: "An eternal piece depicting the fall of the impostor")
Project.create!(user_id: 2, name: "ASfhasfga", description: "Some stuff with some things and yeah just like that")
Project.create!(user_id: 3, name: "Cheeseburger", description: "You forgot the pie")


Sale.create(project_id: 1, sales_channel_id: 1, gross: 100, date: Date.today - rand(1..990).days)
Sale.create(project_id: 1, sales_channel_id: 1, gross: 600, date: Date.today - rand(1..990).days)
Sale.create!(project_id: 1, sales_channel_id: 2, gross: 500.23, net: 245.87, date: Date.today - rand(1..990).days)
Sale.create!(project_id: 2, sales_channel_id: 2, gross: 1500.23, net: 1245.87, date: Date.today - rand(1..990).days)
Sale.create!(project_id: 3, sales_channel_id: 3, gross: 5300.23, net: 2345.87, date: Date.today - rand(1..990).days)


SalesChannel.create!(user_id: 1, name: "Super Festival", description: "Circus Tents")

BusinessExpense.create!(user_id: 1, name: "Studio rent", description: "Monthly rent", amount: 400, recurring: true, duration: "1 month")

MaterialPurchase.create!(user_id: 1, name: "Canvas", description: "3 canvases for paintings", cost: 30, units: 3)

MaterialUse.create!(material_purchase_id: 1, project_id: 1, name: "Canvas", description: "1 canvas", units: 1)

ProjectCost.create!(project_id: 1, cost_type: "Shipping and handling", amount: 12)

150.times do
  Project.create!(user_id: [1,2,3,4,5].sample, name: Faker::App.name, description: Faker::Company.bs)
end

projects = Project.all
sales = Sale.all
material_purchases = MaterialPurchase.all

100.times do
  gross_sale = Faker::Number.between(100, 100000) / 100.00
  Sale.create!(project_id: projects.sample.id, sales_channel_id: rand(1..7), gross: gross_sale,
      net: (Faker::Number.between(100, gross_sale * 100.00) / 100.00).round(2),
      date: Faker::Date.backward(rand(1..100)))
end


200.times do
  start = Faker::Time.backward(rand(1..100))
  stop = start + (rand(1..10)).hours
  TimeEntry.create!(project_id: projects.sample.id, start_time: start, stop_time: stop, total_time: stop.to_i - start.to_i, date: start.to_date )
end


channels = ["Web Store", "Personal Reference", "B&M Store", "The Van", "Down by the River", "Gallery", "Festival Booth" ]
x = 0
7.times do
  SalesChannel.create!(name: channels[x], description: Faker::Address.street_address)
  x += 1
end

10.times do
  x = rand(1..90)
  y = rand(1..60)
  start = DateTime.now - x.days
  stop = start + y.days
  SalesGoal.create!(user_id: [1,2,3,4,5].sample,sales_channel_id: [1,2,3,4,5,6,7].sample, amount: Faker::Number.between(0, 10000),
    length_of_time: (x + y).to_s + " days",
    start_time: start, end_time: stop)
end

50.times do
  BusinessExpense.create!(user_id: [1,2,3,4,5].sample, name: Faker::Address.city_suffix + " bill", description: Faker::Address.city_suffix, amount: Faker::Number.between(0, 10000), recurring: true, duration: (Faker::Number.between(1, 31).to_s + " days"))
end

500.times do
  MaterialPurchase.create!(user_id: [1,2,3,4,5].sample, name: Faker::Commerce.product_name, description: Faker::Commerce.product_name, cost: Faker::Number.between(0, 10000), units: Faker::Number.between(0, 10000))
end

100.times do
  MaterialUse.create!(material_purchase_id: material_purchases.sample.id, project_id: projects.sample.id, name: Faker::Commerce.product_name, description: Faker::Commerce.product_name, units: Faker::Number.between(0, 1000))
end

100.times do
  ProjectCost.create!(project_id: projects.sample.id, cost_type: Faker::Commerce.product_name, amount: Faker::Number.between(0, 10000))
end
