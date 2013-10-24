# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
super_role = Role.find_or_create_by_name(:name=> '超级管理员', :level => 'superman')
Role.find_or_create_by_name(:name=> '普通管理员', :level => 'common')
administrator = Administrator.find_or_create_by_user_name(:user_name => 'qiwl', :real_name => '齐文龙')
AdministratorRole.find_or_create_by_role_id_and_administrator_id(:role_id => super_role.id, :administrator_id => administrator.id)
administrator = Administrator.find_or_create_by_user_name(:user_name => 'wanggc', :real_name => '王国超')
AdministratorRole.find_or_create_by_role_id_and_administrator_id(:role_id => super_role.id, :administrator_id => administrator.id)
administrator = Administrator.find_or_create_by_user_name(:user_name => 'duhw', :real_name => '杜宏伟')
AdministratorRole.find_or_create_by_role_id_and_administrator_id(:role_id => super_role.id, :administrator_id => administrator.id)
administrator = Administrator.find_or_create_by_user_name(:user_name => 'chenlp', :real_name => 'chenlp')
AdministratorRole.find_or_create_by_role_id_and_administrator_id(:role_id => super_role.id, :administrator_id => administrator.id)
administrator = Administrator.find_or_create_by_user_name(:user_name => 'liuyz', :real_name => 'liuyz')
AdministratorRole.find_or_create_by_role_id_and_administrator_id(:role_id => super_role.id, :administrator_id => administrator.id)
administrator = Administrator.find_or_create_by_user_name(:user_name => 'dingy', :real_name => 'dingy')
AdministratorRole.find_or_create_by_role_id_and_administrator_id(:role_id => super_role.id, :administrator_id => administrator.id)

#初始化地区信息
Zone.init_zone_data
