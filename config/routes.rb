Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :posts do
        member do
          put :vote
        end

        collection do
          get :top_posts
          get :multi_ip_list
        end
      end
    end
  end

end
