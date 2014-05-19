TrustyCms::Application.routes.draw do
  namespace :admin do
    get :remove, on: :member
    resources :snippets
    resources :snippet_files, :only => [:index, :show]
  end
end
