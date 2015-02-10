# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(username:"jacksrf", password:"trey33", email:"jacksrf@gmail.com" )


List.create(name:"Clothes", user_id: 1)
List.create(name:"Electronics", user_id: 1)
List.create(name:"Kitchen", user_id: 2)

Item.create(name:"Jcrew - BROKEN-IN CHINO IN URBAN SLIM FIT",url: "https://www.jcrew.com/mens_category/pantsbyfit/Chino/UrbanSlim/PRDOVR~19488/19488.jsp",price: "$75.00",list_id:"1",bought: "false", user_id: 1)
Item.create(name:"Jcrew - POCKET TEE IN MULTISTRIPE",url: "https://www.jcrew.com/mens_category/polostees/shortsleeve/PRDOVR~B9692/B9692.jsp",price: "$45.00",list_id:"1",bought: "false", user_id: 1)
Item.create(name:"Jcrew - ORIGINAL CHIPPEWA® FOR J.CREW PLAIN-TOE RENEGADE BOOTS",url: "https://www.jcrew.com/mens_category/shoes/boots/PRDOVR~B0760/B0760.jsp",price: "$268.00",list_id:"1",bought: "false", user_id: 1)
Item.create(name:"Apple - iMac with Retina 5K display",url: "http://store.apple.com/us/buy-mac/imac-retina",price: "$2,499.00",list_id:"2",bought: "false", user_id: 1)
Item.create(name:"Apple Thunderbolt Display (27-inch)",url: "http://store.apple.com/us/product/MC914LL/B/apple-thunderbolt-display-27-inch?fnode=f6a3a2e11470dd772ac90cefa04bbf1b4ceb5e1b461904ad0f6dbf9b631cee2673202592133d775d3663c70df7a0e586325967598fd1a3ef13c2e53f78ae4273f8698d1d2bf76ccb6c021011da917a3cbdf8fa5449437e87f3c6ac05e477cb5732190220af88681191557cc0f69c985c",price: "$999.00",list_id:"2",bought: "false", user_id: 1)
