#!/usr/bin/env ruby
# create test data with mustermann gmbh

ENV['RAILS_ENV'] ||= 'development'
require File.dirname(__FILE__) + '/../config/environment.rb'

config = YAML::load_file(File.join(Rails.root, 'db', 'demo', 'mustermann-gmbh.yml'))

admin_role = Wobauth::Role.find_by_name("Admin")
if admin_role.nil?
  puts "please run rake db:seed first"
  exit 1
end

role_manager = Wobauth::Role.find_by_name("Manager")
role_orga = Wobauth::Role.find_by_name("OrgaAdmin")
role_reader = Wobauth::Role.find_by_name("Reader")
role_member = Wobauth::Role.find_by_name("Member")

Wobauth::User.create(config['users'])
OrgUnit.create(config['org_units'])

ou_mm   = OrgUnit.where(name: 'Mustermann GmbH').first
ou_it   = OrgUnit.where(name: 'IT').first
ou_pers = OrgUnit.where(name: 'Perso').first
ou_fibu = OrgUnit.where(name: 'Fibu').first

ou_pers.update_attributes(parent: ou_mm)
ou_fibu.update_attributes(parent: ou_mm)
ou_it.update_attributes(parent: ou_mm)

mmax   = Wobauth::User.where(username: 'mmax').first   || raise("user mmax not found")
mfritz = Wobauth::User.where(username: 'mfritz').first || raise("user mfritz not found")
mfrank = Wobauth::User.where(username: 'mfrank').first || raise("user mfrank not found")
mheike = Wobauth::User.where(username: 'mheike').first || raise("user mheike not found")
mcaro  = Wobauth::User.where(username: 'mcaro').first  || raise("user mcaro not found")
mjudas = Wobauth::User.where(username: 'mjudas').first  || raise("user mjudas not found")

Wobauth::Authority.find_or_create_by!(authorizable: mcaro, role: role_manager, authorized_for: ou_mm)
Wobauth::Authority.find_or_create_by!(authorizable: mmax, role: role_member, authorized_for: ou_mm)
Wobauth::Authority.find_or_create_by!(authorizable: mfritz, role: role_reader, authorized_for: ou_mm)
