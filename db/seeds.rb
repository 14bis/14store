# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

Spree::Role.create!(name: 'provider')

I18n.locale = :en
os = SpecificationCategory.create!(code: 'OS', description: 'Operational System')
ws = SpecificationCategory.create!(code: 'WS', description: 'Web Server')
hd = SpecificationCategory.create!(code: 'HD', description: 'Hard Disk Size')
ram = SpecificationCategory.create!(code: 'RAM', description: 'RAM Size')

I18n.locale = :'pt-BT'
os.description = 'Sistema Operacional'
os.save!
ws.description = 'Servidor Web'
ws.save!
hd.description = 'Memória Física (HD)'
hd.save!
ram.description = 'Memória RAM'
ram.save!

