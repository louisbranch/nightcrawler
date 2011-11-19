# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  source = Source.create(:title => 'Contos Eroticos', :type_id => 1, :url => 'http://www.contoseroticos.com.br', :parse_url => 'http://www.contoseroticos.com.br/3.0/ler.php?id=', :active => true)
