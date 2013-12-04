# -*- encoding : utf-8 -*-
QdCollege::Application.routes.draw do
  root :to => 'home#index'
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.username=='CUI99JUAN' } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, :controllers => {:registrations => "users/registrations"} do
    post '/users/check_uniq', :to => 'users/registrations#check_uniq'
  end

  post '/home/login_validate', :to => "home#login_validate"
  get '/lecturers', :to => "lecturers#index"

  match '/admin' => 'admin#index'
  match '/admin/index' => 'admin#index'
  get 'admin/logout'
  match '/admin/logout' => 'admin#logout'
  resources :beginners, :only => [:index,:show]
  resources :mediates, :only => [:index]
  resources :advanceds, :only => [:index]
  resources :games
  resources :users, :only => [:update,:edit] do
    collection{get :level,:exam,:fight}
  end
  resources :schools, :only => [:create,:show,:index] do
    collection{get :beginner,:mediate,:advanced}
  end
  resources :readings, :only=> [:show] do 
    get :download, :on=> :member
  end 
  resources :videos, :only=> [:show,:index] do 
    get :broadcast, :on=> :member
  end

  resources :fight_exams do
    get :home, :on => :collection
    get :regulations, :on => :collection
    get :start, :on => :collection
    post :next_stage, :on => :collection
    get :pause, :on => :collection
  end

  resources :ranking_lists do
    get :home, :on => :collection
    get :ranking_list_weeks, :on => :collection
    get :ranking_list_years, :on => :collection
  end

  devise_for :administrators
  namespace :admin do
    root :to => 'administrators#index'
    resources :games, :except => [:show]
    resources :awards, :except => [:show]
    resources :affiliates , :only => [:index]
    resources :documents do
      collection{post :order}
    end
    resources :videos do
      collection{post :order}
    end
    resources :video_nodes do
      collection{post :order}
    end
    
    resources :administrators
    resources :roles
    resources :permissions

    resources :question_onlines
    resources :question_stands
    resources :question_files do
      member{get :inport}
    end
    resources :taxons do
      get :search, :on => :collection
    end
    resources :regulations do
      post :update_positions, :on => :collection
    end
    resources :users ,:only=>[:index,:show] do
      get :reset_password , :on => :member
      get :enable , :on => :member
    end
    resources :award_records, :only=>[:index,:show]
    resources :ranking_list_years, :only=>[:index,:show]
    resources :ranking_list_weeks, :only=>[:index,:show]
    resources :advertisements do
      collection{post :order}
    end 
    resources :exam_records, :only=> [:index]
    resources :exams, :only=> [:index]

  end
end
#== Route Map
# Generated on 29 Oct 2013 22:18
#
#                        sidekiq_web        /sidekiq                                                      Sidekiq::Web
#                   users_check_uniq POST   /users/check_uniq(.:format)                                   users/registrations#check_uniq
#                      user_password POST   /users/password(.:format)                                     devise/passwords#create
#                  new_user_password GET    /users/password/new(.:format)                                 devise/passwords#new
#                 edit_user_password GET    /users/password/edit(.:format)                                devise/passwords#edit
#                                    PUT    /users/password(.:format)                                     devise/passwords#update
#           cancel_user_registration GET    /users/cancel(.:format)                                       users/registrations#cancel
#                  user_registration POST   /users(.:format)                                              users/registrations#create
#              new_user_registration GET    /users/sign_up(.:format)                                      users/registrations#new
#             edit_user_registration GET    /users/edit(.:format)                                         users/registrations#edit
#                                    PUT    /users(.:format)                                              users/registrations#update
#                                    DELETE /users(.:format)                                              users/registrations#destroy
#                       user_service GET    /users/service(.:format)                                      devise/cas_sessions#service
#               user_single_sign_out POST   /users/service(.:format)                                      devise/cas_sessions#single_sign_out
#                   new_user_session GET    /users/sign_in(.:format)                                      devise/cas_sessions#new
#          unregistered_user_session GET    /users/unregistered(.:format)                                 devise/cas_sessions#unregistered
#                       user_session POST   /users/sign_in(.:format)                                      devise/cas_sessions#create
#               destroy_user_session GET    /users/sign_out(.:format)                                     devise/cas_sessions#destroy
#                home_login_validate POST   /home/login_validate(.:format)                                home#login_validate
#                              admin        /admin(.:format)                                              admin#index
#                        admin_index        /admin/index(.:format)                                        admin#index
#                       admin_logout GET    /admin/logout(.:format)                                       admin#logout
#                                           /admin/logout(.:format)                                       admin#logout
#                          beginners GET    /beginners(.:format)                                          beginners#index
#                           beginner GET    /beginners/:id(.:format)                                      beginners#show
#                           mediates GET    /mediates(.:format)                                           mediates#index
#                          advanceds GET    /advanceds(.:format)                                          advanceds#index
#                              games GET    /games(.:format)                                              games#index
#                                    POST   /games(.:format)                                              games#create
#                           new_game GET    /games/new(.:format)                                          games#new
#                          edit_game GET    /games/:id/edit(.:format)                                     games#edit
#                               game GET    /games/:id(.:format)                                          games#show
#                                    PUT    /games/:id(.:format)                                          games#update
#                                    DELETE /games/:id(.:format)                                          games#destroy
#                        level_users GET    /users/level(.:format)                                        users#level
#                         exam_users GET    /users/exam(.:format)                                         users#exam
#                        fight_users GET    /users/fight(.:format)                                        users#fight
#                          edit_user GET    /users/:id/edit(.:format)                                     users#edit
#                               user PUT    /users/:id(.:format)                                          users#update
#                   beginner_schools GET    /schools/beginner(.:format)                                   schools#beginner
#                    mediate_schools GET    /schools/mediate(.:format)                                    schools#mediate
#                   advanced_schools GET    /schools/advanced(.:format)                                   schools#advanced
#                            schools POST   /schools(.:format)                                            schools#create
#                             school GET    /schools/:id(.:format)                                        schools#show
#                   download_reading GET    /readings/:id/download(.:format)                              readings#download
#                            reading GET    /readings/:id(.:format)                                       readings#show
#                    broadcast_video GET    /videos/:id/broadcast(.:format)                               videos#broadcast
#                             videos GET    /videos(.:format)                                             videos#index
#                              video GET    /videos/:id(.:format)                                         videos#show
#                   home_fight_exams GET    /fight_exams/home(.:format)                                   fight_exams#home
#            regulations_fight_exams GET    /fight_exams/regulations(.:format)                            fight_exams#regulations
#                  start_fight_exams GET    /fight_exams/start(.:format)                                  fight_exams#start
#             next_stage_fight_exams POST   /fight_exams/next_stage(.:format)                             fight_exams#next_stage
#                  pause_fight_exams GET    /fight_exams/pause(.:format)                                  fight_exams#pause
#                        fight_exams GET    /fight_exams(.:format)                                        fight_exams#index
#                                    POST   /fight_exams(.:format)                                        fight_exams#create
#                     new_fight_exam GET    /fight_exams/new(.:format)                                    fight_exams#new
#                    edit_fight_exam GET    /fight_exams/:id/edit(.:format)                               fight_exams#edit
#                         fight_exam GET    /fight_exams/:id(.:format)                                    fight_exams#show
#                                    PUT    /fight_exams/:id(.:format)                                    fight_exams#update
#                                    DELETE /fight_exams/:id(.:format)                                    fight_exams#destroy
#                 home_ranking_lists GET    /ranking_lists/home(.:format)                                 ranking_lists#home
#   ranking_list_weeks_ranking_lists GET    /ranking_lists/ranking_list_weeks(.:format)                   ranking_lists#ranking_list_weeks
#   ranking_list_years_ranking_lists GET    /ranking_lists/ranking_list_years(.:format)                   ranking_lists#ranking_list_years
#                      ranking_lists GET    /ranking_lists(.:format)                                      ranking_lists#index
#                                    POST   /ranking_lists(.:format)                                      ranking_lists#create
#                   new_ranking_list GET    /ranking_lists/new(.:format)                                  ranking_lists#new
#                  edit_ranking_list GET    /ranking_lists/:id/edit(.:format)                             ranking_lists#edit
#                       ranking_list GET    /ranking_lists/:id(.:format)                                  ranking_lists#show
#                                    PUT    /ranking_lists/:id(.:format)                                  ranking_lists#update
#                                    DELETE /ranking_lists/:id(.:format)                                  ranking_lists#destroy
#          new_administrator_session GET    /administrators/sign_in(.:format)                             devise/sessions#new
#              administrator_session POST   /administrators/sign_in(.:format)                             devise/sessions#create
#      destroy_administrator_session GET    /administrators/sign_out(.:format)                            devise/sessions#destroy
#                         admin_root        /admin(.:format)                                              admin/administrators#index
#                        admin_games GET    /admin/games(.:format)                                        admin/games#index
#                                    POST   /admin/games(.:format)                                        admin/games#create
#                     new_admin_game GET    /admin/games/new(.:format)                                    admin/games#new
#                    edit_admin_game GET    /admin/games/:id/edit(.:format)                               admin/games#edit
#                         admin_game PUT    /admin/games/:id(.:format)                                    admin/games#update
#                                    DELETE /admin/games/:id(.:format)                                    admin/games#destroy
#                       admin_awards GET    /admin/awards(.:format)                                       admin/awards#index
#                                    POST   /admin/awards(.:format)                                       admin/awards#create
#                    new_admin_award GET    /admin/awards/new(.:format)                                   admin/awards#new
#                   edit_admin_award GET    /admin/awards/:id/edit(.:format)                              admin/awards#edit
#                        admin_award PUT    /admin/awards/:id(.:format)                                   admin/awards#update
#                                    DELETE /admin/awards/:id(.:format)                                   admin/awards#destroy
#                   admin_affiliates GET    /admin/affiliates(.:format)                                   admin/affiliates#index
#              order_admin_documents POST   /admin/documents/order(.:format)                              admin/documents#order
#                    admin_documents GET    /admin/documents(.:format)                                    admin/documents#index
#                                    POST   /admin/documents(.:format)                                    admin/documents#create
#                 new_admin_document GET    /admin/documents/new(.:format)                                admin/documents#new
#                edit_admin_document GET    /admin/documents/:id/edit(.:format)                           admin/documents#edit
#                     admin_document GET    /admin/documents/:id(.:format)                                admin/documents#show
#                                    PUT    /admin/documents/:id(.:format)                                admin/documents#update
#                                    DELETE /admin/documents/:id(.:format)                                admin/documents#destroy
#                 order_admin_videos POST   /admin/videos/order(.:format)                                 admin/videos#order
#                       admin_videos GET    /admin/videos(.:format)                                       admin/videos#index
#                                    POST   /admin/videos(.:format)                                       admin/videos#create
#                    new_admin_video GET    /admin/videos/new(.:format)                                   admin/videos#new
#                   edit_admin_video GET    /admin/videos/:id/edit(.:format)                              admin/videos#edit
#                        admin_video GET    /admin/videos/:id(.:format)                                   admin/videos#show
#                                    PUT    /admin/videos/:id(.:format)                                   admin/videos#update
#                                    DELETE /admin/videos/:id(.:format)                                   admin/videos#destroy
# admin_video_node_video_nodes_order POST   /admin/video_nodes/:video_node_id/video_nodes/order(.:format) admin/video_nodes#order
#                  admin_video_nodes GET    /admin/video_nodes(.:format)                                  admin/video_nodes#index
#                                    POST   /admin/video_nodes(.:format)                                  admin/video_nodes#create
#               new_admin_video_node GET    /admin/video_nodes/new(.:format)                              admin/video_nodes#new
#              edit_admin_video_node GET    /admin/video_nodes/:id/edit(.:format)                         admin/video_nodes#edit
#                   admin_video_node GET    /admin/video_nodes/:id(.:format)                              admin/video_nodes#show
#                                    PUT    /admin/video_nodes/:id(.:format)                              admin/video_nodes#update
#                                    DELETE /admin/video_nodes/:id(.:format)                              admin/video_nodes#destroy
#               admin_administrators GET    /admin/administrators(.:format)                               admin/administrators#index
#                                    POST   /admin/administrators(.:format)                               admin/administrators#create
#            new_admin_administrator GET    /admin/administrators/new(.:format)                           admin/administrators#new
#           edit_admin_administrator GET    /admin/administrators/:id/edit(.:format)                      admin/administrators#edit
#                admin_administrator GET    /admin/administrators/:id(.:format)                           admin/administrators#show
#                                    PUT    /admin/administrators/:id(.:format)                           admin/administrators#update
#                                    DELETE /admin/administrators/:id(.:format)                           admin/administrators#destroy
#                        admin_roles GET    /admin/roles(.:format)                                        admin/roles#index
#                                    POST   /admin/roles(.:format)                                        admin/roles#create
#                     new_admin_role GET    /admin/roles/new(.:format)                                    admin/roles#new
#                    edit_admin_role GET    /admin/roles/:id/edit(.:format)                               admin/roles#edit
#                         admin_role GET    /admin/roles/:id(.:format)                                    admin/roles#show
#                                    PUT    /admin/roles/:id(.:format)                                    admin/roles#update
#                                    DELETE /admin/roles/:id(.:format)                                    admin/roles#destroy
#                  admin_permissions GET    /admin/permissions(.:format)                                  admin/permissions#index
#                                    POST   /admin/permissions(.:format)                                  admin/permissions#create
#               new_admin_permission GET    /admin/permissions/new(.:format)                              admin/permissions#new
#              edit_admin_permission GET    /admin/permissions/:id/edit(.:format)                         admin/permissions#edit
#                   admin_permission GET    /admin/permissions/:id(.:format)                              admin/permissions#show
#                                    PUT    /admin/permissions/:id(.:format)                              admin/permissions#update
#                                    DELETE /admin/permissions/:id(.:format)                              admin/permissions#destroy
#             admin_question_onlines GET    /admin/question_onlines(.:format)                             admin/question_onlines#index
#                                    POST   /admin/question_onlines(.:format)                             admin/question_onlines#create
#          new_admin_question_online GET    /admin/question_onlines/new(.:format)                         admin/question_onlines#new
#         edit_admin_question_online GET    /admin/question_onlines/:id/edit(.:format)                    admin/question_onlines#edit
#              admin_question_online GET    /admin/question_onlines/:id(.:format)                         admin/question_onlines#show
#                                    PUT    /admin/question_onlines/:id(.:format)                         admin/question_onlines#update
#                                    DELETE /admin/question_onlines/:id(.:format)                         admin/question_onlines#destroy
#              admin_question_stands GET    /admin/question_stands(.:format)                              admin/question_stands#index
#                                    POST   /admin/question_stands(.:format)                              admin/question_stands#create
#           new_admin_question_stand GET    /admin/question_stands/new(.:format)                          admin/question_stands#new
#          edit_admin_question_stand GET    /admin/question_stands/:id/edit(.:format)                     admin/question_stands#edit
#               admin_question_stand GET    /admin/question_stands/:id(.:format)                          admin/question_stands#show
#                                    PUT    /admin/question_stands/:id(.:format)                          admin/question_stands#update
#                                    DELETE /admin/question_stands/:id(.:format)                          admin/question_stands#destroy
#         inport_admin_question_file GET    /admin/question_files/:id/inport(.:format)                    admin/question_files#inport
#               admin_question_files GET    /admin/question_files(.:format)                               admin/question_files#index
#                                    POST   /admin/question_files(.:format)                               admin/question_files#create
#            new_admin_question_file GET    /admin/question_files/new(.:format)                           admin/question_files#new
#           edit_admin_question_file GET    /admin/question_files/:id/edit(.:format)                      admin/question_files#edit
#                admin_question_file GET    /admin/question_files/:id(.:format)                           admin/question_files#show
#                                    PUT    /admin/question_files/:id(.:format)                           admin/question_files#update
#                                    DELETE /admin/question_files/:id(.:format)                           admin/question_files#destroy
#                search_admin_taxons GET    /admin/taxons/search(.:format)                                admin/taxons#search
#                       admin_taxons GET    /admin/taxons(.:format)                                       admin/taxons#index
#                                    POST   /admin/taxons(.:format)                                       admin/taxons#create
#                    new_admin_taxon GET    /admin/taxons/new(.:format)                                   admin/taxons#new
#                   edit_admin_taxon GET    /admin/taxons/:id/edit(.:format)                              admin/taxons#edit
#                        admin_taxon GET    /admin/taxons/:id(.:format)                                   admin/taxons#show
#                                    PUT    /admin/taxons/:id(.:format)                                   admin/taxons#update
#                                    DELETE /admin/taxons/:id(.:format)                                   admin/taxons#destroy
# update_positions_admin_regulations POST   /admin/regulations/update_positions(.:format)                 admin/regulations#update_positions
#                  admin_regulations GET    /admin/regulations(.:format)                                  admin/regulations#index
#                                    POST   /admin/regulations(.:format)                                  admin/regulations#create
#               new_admin_regulation GET    /admin/regulations/new(.:format)                              admin/regulations#new
#              edit_admin_regulation GET    /admin/regulations/:id/edit(.:format)                         admin/regulations#edit
#                   admin_regulation GET    /admin/regulations/:id(.:format)                              admin/regulations#show
#                                    PUT    /admin/regulations/:id(.:format)                              admin/regulations#update
#                                    DELETE /admin/regulations/:id(.:format)                              admin/regulations#destroy
#          reset_password_admin_user GET    /admin/users/:id/reset_password(.:format)                     admin/users#reset_password
#                  enable_admin_user GET    /admin/users/:id/enable(.:format)                             admin/users#enable
#                        admin_users GET    /admin/users(.:format)                                        admin/users#index
#                         admin_user GET    /admin/users/:id(.:format)                                    admin/users#show
#                admin_award_records GET    /admin/award_records(.:format)                                admin/award_records#index
#                 admin_award_record GET    /admin/award_records/:id(.:format)                            admin/award_records#show
#           admin_ranking_list_years GET    /admin/ranking_list_years(.:format)                           admin/ranking_list_years#index
#            admin_ranking_list_year GET    /admin/ranking_list_years/:id(.:format)                       admin/ranking_list_years#show
#           admin_ranking_list_weeks GET    /admin/ranking_list_weeks(.:format)                           admin/ranking_list_weeks#index
#            admin_ranking_list_week GET    /admin/ranking_list_weeks/:id(.:format)                       admin/ranking_list_weeks#show
#                  kindeditor_upload POST   /kindeditor/upload(.:format)                                  kindeditor/assets#create
#             kindeditor_filemanager GET    /kindeditor/filemanager(.:format)                             kindeditor/assets#list
