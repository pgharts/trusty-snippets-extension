TrustyCms::Application.routes.draw do
  namespace :admin do

    resources :snippets do
      get :remove, on: :member
    end
    resources :snippet_files, :only => [:index, :show]
  end
end
