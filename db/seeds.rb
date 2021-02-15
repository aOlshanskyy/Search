# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

records = JSON.parse(File.read('/home/andriy/work/files/data.json'))

records = records.each do |j|
	j.tap { |hash| hash["name"] = hash.delete "Name" }
	j.tap { |hash| hash["typical"] = hash.delete "Type" }
    j.tap { |hash| hash["designed"] = hash.delete "Designed by" }
end
records.each do |record|
  Language.find_or_create_by!(record)
end