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

# 权限配置
Event.find_or_create_by_action_and_subject(:action => "manage",:subject => "user",:desc =>"管理", :model_name => "用户")
Event.find_or_create_by_action_and_subject(:action => "read",:subject => "user",:desc =>"查看", :model_name => "用户")
Event.find_or_create_by_action_and_subject(:action =>"enable",:subject =>"user",:desc =>"禁闭／开启",:model_name => "用户")
Event.find_or_create_by_action_and_subject(:action =>"reset_password",:subject =>"user",:desc =>"重置密码",:model_name => "用户")
Event.find_or_create_by_action_and_subject(:action =>"manage",:subject =>"award_record",:desc =>"管理",:model_name => "获奖信息")
Event.find_or_create_by_action_and_subject(:action =>"read",:subject =>"award_record",:desc =>"查看",:model_name => "获奖信息")
Event.find_or_create_by_action_and_subject(:action =>"manage",:subject =>"ranking_list_week",:desc =>"管理",:model_name => "周排名")
Event.find_or_create_by_action_and_subject(:action =>"read",:subject =>"ranking_list_week",:desc =>"查看",:model_name => "周排名")
Event.find_or_create_by_action_and_subject(:action =>"manage",:subject =>"ranking_list_year",:desc =>"管理",:model_name => "总排名")
Event.find_or_create_by_action_and_subject(:action =>"read",:subject =>"ranking_list_year",:desc =>"查看",:model_name => "总排名")



# games
Event.find_or_create_by_action_and_subject(:action => "manage",:subject => "game",:desc =>"管理", :model_name => "抽奖")
Event.find_or_create_by_action_and_subject(:action => "read",:subject => "game",:desc =>"查看", :model_name => "抽奖")
Event.find_or_create_by_action_and_subject(:action => "create",:subject =>"game",:desc =>"添加", :model_name => "抽奖")
Event.find_or_create_by_action_and_subject(:action =>"update",:subject =>"game",:desc =>"修改",:model_name => "抽奖")
Event.find_or_create_by_action_and_subject(:action =>"destroy",:subject =>"game",:desc =>"删除",:model_name => "抽奖")
 
#awards
Event.find_or_create_by_action_and_subject(:action => "manage",:subject => "award",:desc =>"管理", :model_name => "奖品")
Event.find_or_create_by_action_and_subject(:action => "read",:subject => "award",:desc =>"查看", :model_name => "奖品")
Event.find_or_create_by_action_and_subject(:action => "create",:subject =>"award",:desc =>"添加", :model_name => "奖品")
Event.find_or_create_by_action_and_subject(:action =>"update",:subject =>"award",:desc =>"修改",:model_name => "奖品")
Event.find_or_create_by_action_and_subject(:action =>"destroy",:subject =>"award",:desc =>"删除",:model_name => "奖品")
 

#videos
Event.find_or_create_by_action_and_subject(:action => "manage",:subject => "video",:desc =>"管理", :model_name => "视频")
Event.find_or_create_by_action_and_subject(:action => "read",:subject => "video",:desc =>"查看", :model_name => "视频")
Event.find_or_create_by_action_and_subject(:action => "create",:subject =>"video",:desc =>"添加", :model_name => "视频")
Event.find_or_create_by_action_and_subject(:action =>"update",:subject =>"video",:desc =>"修改",:model_name => "视频")
Event.find_or_create_by_action_and_subject(:action =>"destroy",:subject =>"video",:desc =>"删除",:model_name => "视频")
 

#video_nodes
Event.find_or_create_by_action_and_subject(:action => "manage",:subject => "video_node",:desc =>"管理", :model_name => "视频章节")
Event.find_or_create_by_action_and_subject(:action => "read",:subject => "video_node",:desc =>"查看", :model_name => "视频章节")
Event.find_or_create_by_action_and_subject(:action => "create",:subject =>"video_node",:desc =>"添加", :model_name => "视频章节")
Event.find_or_create_by_action_and_subject(:action =>"update",:subject =>"video_node",:desc =>"修改",:model_name => "视频章节")
Event.find_or_create_by_action_and_subject(:action =>"destroy",:subject =>"video_node",:desc =>"删除",:model_name => "视频章节")
 
#documents
Event.find_or_create_by_action_and_subject(:action => "manage",:subject => "documents",:desc =>"管理", :model_name => "资料")
Event.find_or_create_by_action_and_subject(:action => "read",:subject => "documents",:desc =>"查看", :model_name => "资料")
Event.find_or_create_by_action_and_subject(:action => "create",:subject =>"documents",:desc =>"添加", :model_name => "资料")
Event.find_or_create_by_action_and_subject(:action =>"update",:subject =>"documents",:desc =>"修改",:model_name => "资料")
Event.find_or_create_by_action_and_subject(:action =>"destroy",:subject =>"documents",:desc =>"删除",:model_name => "资料")
 
Student.find_in_batches do |students|
	students.each do |s|
		s.class.level.values.each do |l|
			correct = s.exams.where("correct > 0").with_level(l).order('correct desc').pluck(:correct).first
			total = s.exams.with_level(l).try(:count)
			if s.level_index(l) < s.level_index(s.level) or s.pass
				s.exam_records.build(:level=>l,:user_id=>s.user_id,:pass=>true,:exam_count=>1,:correct=>correct,:exam_count=>total, :created_at => s.try(:user).try(:created_at))
			else
				if correct.to_i == 0
					s.exam_records.build(:level=>l,:user_id=>s.user_id,:pass=>false,:exam_count=>total, :created_at => s.try(:user).try(:created_at)) 
				else
					s.exam_records.build(:level=>l,:user_id=>s.user_id,:pass=>false,:correct=>correct,:exam_count=>total, :created_at => s.try(:user).try(:created_at)) 
				end
			end
	    end
		s.save
	end
end
