ActionController::Routing::Routes.draw do |map|
  map.namespace :admin, :member => { :remove => :get } do |admin|
    admin.resources :snippets
    admin.resources :snippet_files, :only => [:index, :show]
  end
end