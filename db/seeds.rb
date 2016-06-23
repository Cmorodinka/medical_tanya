# emcoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
Faker::Config.locale = 'ru'

if Scope.all.empty?
	puts "Importing scope title..."
	CSV.foreach(Rails.root.join("scope.csv"), headers: true) do |row|
	  Scope.create! do |scope|
	    scope.id = row[0]
	    scope.title = row[1]
	  end
	end
else
	puts "Scope not nil!"
end

if Category.all.empty?
	puts "Importing category name..."
	CSV.foreach(Rails.root.join("category.csv"), headers: true) do |row|
	  Category.create! do |category|
	  	category.id = row[0]
	    category.name = row[1]
	    category.scope_id = row[2]
	  end
	end
else 
	puts "Category not nil!"
end

if City.all.empty?
	puts "Importing city name..."
	CSV.foreach(Rails.root.join("city.csv"), headers: true) do |row|
	  City.create! do |city|
	  	city.id = row[0]
	    city.name = row[1]
	  end
	end
else 
	puts "City not nil!"
end
    
if Admin::Banner.all.empty?
	puts "Creating default banner..."
	Admin::Banner.create(title: "Medical.netbee.ua", link_to: "http://www.medical.netbee.ua", active: true, started_at: "2099-01-01 12:12:12")
else
	puts "Banners not nil!"
end	

if Account.all.empty?
	puts "Creating test accounts..."
  5.times { Account.create!({:email => Faker::Internet.email, :password => Faker::Internet.password, :account_type => 'Employer'})}
	10.times { Account.create!({:email => Faker::Internet.email, :password => Faker::Internet.password, :account_type => 'Applicant'})}
	Employer.update_all(active: true)
	Applicant.update_all(active: true)
else 
	puts "Accounts not nil!"
end

if Company.all.empty?
	puts "Creating test companies..."
	(1..5).each { |e| Employer.find(e).create_company({:name => Faker::Company.name, :scope_id => rand(7..13), :description => Faker::Lorem.sentence})}
	5.times { Company.find(rand(1..5)).company_contacts.create({:name => Faker::Name.name, :phone => Faker::PhoneNumber.cell_phone}) }
	Company.update_all(:state => :vip)
else
	puts "Companies not nil!"
end

if Vacancy.all.empty?
	puts "Creating test vacancies..."
	14.times { Company.find(rand(1..5)).vacancies.create({:category_id => 78, :city => 'Киев', :name => Faker::Company.name, :salary => Faker::Number.between(1000, 2200), :company_contact_id => 1, :description=> Faker::Lorem.sentence, :experiences=> "без опыта", :timetable => "временная работа" }) }
	Vacancy.update_all(:state => :published)
	Vacancy.order(:created_at).limit(4).update_all(:state => :hot)
else
	puts "Vacancies not nil!"
end

if Resume.all.empty?
	puts "Creating test resumes..."
	(6..15).each { |a| Applicant.find(a).create_profile({:lastname => Faker::Name.name , :firstname => Faker::Name.name , :date => '1988-11-03', :phone => '+38(063) 113 46 44'})}
	(6..15).each { |a| Applicant.find(a).create_resume({:position => Faker::Company.name, :salary => 500, :city => 'Киев'})}
	Resume.update_all(:state => :published)
else
	puts "Resumes not nil!"
end

system 'rake ts:rebuild'

