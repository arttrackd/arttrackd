# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "Phil", email: "Phil_is_awesome@yeah.com", password: "password", public_profile: false, time_zone: "Eastern Time (US & Canada)", hourly_rate: 12.33)
User.create(name: "Kevin", email: "kevin@hotmail.com", password: "password", public_profile: false, time_zone: "Eastern Time (US & Canada)", hourly_rate: 12.33)
User.create(name: "Dead", email: "DeamonKiller@hunter.com", password: "password", public_profile: false, time_zone: "Eastern Time (US & Canada)", hourly_rate: 12.33)

Project.create(user_id: 1, name: "LiesOnFire", description: "An eternal piece depicting the fall of the impostor")
Project.create(user_id: 2, name: "ASfhasfga", description: "Some stuff with some things and yeah just like that")
Project.create(user_id: 3, name: "Cheeseburger", description: "You forgot the pie")

Sale.create(project_id: 1, gross: 500.23, net: 245.87, date: DateTime.strptime("09/01/2009 17:00", "%m/%d/%Y %H:%M"))
Sale.create(project_id: 2, gross: 1500.23, net: 1245.87, date: DateTime.strptime("12/01/2010 17:00", "%m/%d/%Y %H:%M"))
Sale.create(project_id: 3, gross: 5300.23, net: 2345.87, date: DateTime.strptime("03/01/2012 17:00", "%m/%d/%Y %H:%M"))

SalesGoal.create(user_id: 1, amount: 1000.00, length_of_time: "3 days", start_time: DateTime.strptime("02/02/2000 17:00", "%m/%d/%Y %H:%M"), success: true)
SalesGoal.create(user_id: 2, amount: 100000.00, length_of_time: "3 weeks", start_time: DateTime.strptime("02/02/2000 17:00", "%m/%d/%Y %H:%M"), success: true)
SalesGoal.create(user_id: 3, amount: 1000000.00, length_of_time: "21 days", start_time: DateTime.strptime("02/02/2000 17:00", "%m/%d/%Y %H:%M"), success: true)

TimeEntry.create(project_id: 1, start_time: DateTime.strptime("02/02/2000 17:00", "%m/%d/%Y %H:%M"), stop_time: DateTime.strptime("03/03/2000 17:00", "%m/%d/%Y %H:%M"), date: DateTime.strptime("02/02/2000 17:00", "%m/%d/%Y %H:%M") )
TimeEntry.create(project_id: 2, start_time: DateTime.strptime("03/03/2000 17:00", "%m/%d/%Y %H:%M"), stop_time: DateTime.strptime("04/04/2000 17:00", "%m/%d/%Y %H:%M"), date: DateTime.strptime("03/03/2000 17:00", "%m/%d/%Y %H:%M") )
TimeEntry.create(project_id: 3, start_time: DateTime.strptime("04/04/2000 17:00", "%m/%d/%Y %H:%M"), stop_time: DateTime.strptime("05/05/2000 17:00", "%m/%d/%Y %H:%M"), date: DateTime.strptime("04/04/2000 17:00", "%m/%d/%Y %H:%M") )
