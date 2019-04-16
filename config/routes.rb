Rails.application.routes.draw do
  # get 'messages/index'
  # get "errors/not_found"
  get "profile", to: "users#profile"
  get "edit", to: "users#edit"
  post "users/update"
  post "users/add_friend"
  post "users/confirm_request"
  post "users/cancle_request"
  post "users/reject_request"
  post "users/profile_update"
  post "users/delete_friend"
  get "users/notification"
  post "users/notification_status"
  # get "index", to: "posts#index"
  get "login", to: "auths#signin"
  get "signup", to: "auths#signup"
  get "verification", to: "auths#verify"
  get "auths/logout"
  post "auths/create"
  post "auths/login_auth"
  get "comments/comments_count"
  # delete "comments/:id", to: "comments#destroy", as: "comments"
  post "posts/like"
  post "posts/post_media"
  post "posts/delete_media"
  get "posts/post_filter/:id", to: "posts#post_filter", as: "post_filter"
  resources :posts
  resources :chat_rooms
  resources :comments
  resources :messages
  # get "/404", to: "errors#not_found"
  # get "/422", to: "errors#unacceptable"
  # get "/500", to: "errors#server_error"
  # get "posts/:id", to: "posts#show", as: "posts"
  # delete "posts/:id", to: "posts#destroy", as: "posts"
  # post "posts/create"
  # get "/404", :to => "errors#not_found"
  root "posts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
