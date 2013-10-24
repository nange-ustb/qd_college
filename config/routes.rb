# -*- encoding : utf-8 -*-
QdCollege::Application.routes.draw do

  get "games/index"

  devise_for :users

  root :to => 'home#index'
  post '/home/login_validate', :to => "home#login_validate"

  devise_for :administrators

  match '/admin' => 'admin#index'
  match '/admin/index' => 'admin#index'
  get 'admin/logout'
  match '/admin/logout' => 'admin#logout'
  resources :beginners, :only => [:index,:show]
  resources :intermediates, :only => [:index]
  resources :advanceds, :only => [:index]
  resources :games
  resources :schools, :only => [:create,:show] do
    collection{get :beginner,:mediate,:advanced}
  end
  resources :readings, :only=> [:show] do 
    get :download, :on=> :member
  end 
  resources :videos, :only=> [:show,:index] do 
    get :broadcast, :on=> :member
  end 

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
      post "video_nodes/order"
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
    
  end
end
#== Route Map
# Generated on 22 Oct 2013 19:22
#
#                  new_user_password GET    /users/password/new(.:format)                                 devise/passwords#new
#                 edit_user_password GET    /users/password/edit(.:format)                                devise/passwords#edit
#                                    PUT    /users/password(.:format)                                     devise/passwords#update
#           cancel_user_registration GET    /users/cancel(.:format)                                       devise/registrations#cancel
#                  user_registration POST   /users(.:format)                                              devise/registrations#create
#              new_user_registration GET    /users/sign_up(.:format)                                      devise/registrations#new
#             edit_user_registration GET    /users/edit(.:format)                                         devise/registrations#edit
#                                    PUT    /users(.:format)                                              devise/registrations#update
#                                    DELETE /users(.:format)                                              devise/registrations#destroy
#                       user_service GET    /users/service(.:format)                                      devise/cas_sessions#service
#               user_single_sign_out POST   /users/service(.:format)                                      devise/cas_sessions#single_sign_out
#                   new_user_session GET    /users/sign_in(.:format)                                      devise/cas_sessions#new
#          unregistered_user_session GET    /users/unregistered(.:format)                                 devise/cas_sessions#unregistered
#                       user_session POST   /users/sign_in(.:format)                                      devise/cas_sessions#create
#               destroy_user_session GET    /users/sign_out(.:format)                                     devise/cas_sessions#destroy
#                               root        /                                                             home#index
#                home_login_validate POST   /home/login_validate(.:format)                                home#login_validate
#          new_administrator_session GET    /administrators/sign_in(.:format)                             devise/sessions#new
#              administrator_session POST   /administrators/sign_in(.:format)                             devise/sessions#create
#      destroy_administrator_session GET    /administrators/sign_out(.:format)                            devise/sessions#destroy
#                              admin        /admin(.:format)                                              admin#index
#                        admin_index        /admin/index(.:format)                                        admin#index
#                       admin_logout GET    /admin/logout(.:format)                                       admin#logout
#                                           /admin/logout(.:format)                                       admin#logout
#                          beginners GET    /beginners(.:format)                                          beginners#index
#                                    POST   /beginners(.:format)                                          beginners#create
#                       new_beginner GET    /beginners/new(.:format)                                      beginners#new
#                      edit_beginner GET    /beginners/:id/edit(.:format)                                 beginners#edit
#                           beginner GET    /beginners/:id(.:format)                                      beginners#show
#                                    PUT    /beginners/:id(.:format)                                      beginners#update
#                                    DELETE /beginners/:id(.:format)                                      beginners#destroy
#                      intermediates GET    /intermediates(.:format)                                      intermediates#index
#                          advanceds GET    /advanceds(.:format)                                          advanceds#index
#                   beginner_schools GET    /schools/beginner(.:format)                                   schools#beginner
#                    mediate_schools GET    /schools/mediate(.:format)                                    schools#mediate
#                   advanced_schools GET    /schools/advanced(.:format)                                   schools#advanced
#                            schools POST   /schools(.:format)                                            schools#create
#                   download_reading GET    /readings/:id/download(.:format)                              readings#download
#                            reading GET    /readings/:id(.:format)                                       readings#show
#                    broadcast_video GET    /videos/:id/broadcast(.:format)                               videos#broadcast
#                             videos GET    /videos(.:format)                                             videos#index
#                              video GET    /videos/:id(.:format)                                         videos#show
#                         admin_root        /admin(.:format)                                              admin/administrators#index
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
#                  kindeditor_upload POST   /kindeditor/upload(.:format)                                  kindeditor/assets#create
#             kindeditor_filemanager GET    /kindeditor/filemanager(.:format)                             kindeditor/assets#list
