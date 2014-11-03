TrustyCms::Application.routes.draw do
  namespace :admin do

    resources :snippets do
      get :remove, on: :member
    end
  end
end
