Hobocookbook::Application.routes.draw do
  root :to => 'manual#home', :as => 'home'

  get 'search' => 'front#search', :as => 'site_search'
  get 'manual' => 'manual#index'
  get 'manual/home' => 'manual#home'
  get 'manual/:section' => 'manual#manual_section', :as => 'manual_section'
  get 'manual/:section/:subsection' => 'manual#manual_subsection'

  get 'tagdef/:plugin/:taglib/:tag' => 'api_tag_defs#tagdef', :as => 'tagdef'
  get 'tagdef/:plugin/:taglib/:tag/:for' => 'api_tag_defs#tagdef', :as => 'tagdef_for'

  get 'tutorials' => 'tutorials#index', :as => 'tutorials'
  get 'tutorials/screencast' => 'tutorials#screencast', :as => 'tutorial_screencast'
  get 'tutorials/screencast_10' => 'tutorials#screencast_10', :as => 'tutorial_screencast_10'
  get 'tutorials/:tutorial' => 'tutorials#show', :as => 'tutorial'

  get 'plugins' => "plugins#index", :as => 'plugins'
  get 'plugins/:plugin' => "plugins#show", :as => 'plugin'

  get 'github/*uri' => 'github#github', :format => false, :as => 'github'

  get 'blog/feed' => redirect('/blog.atom')
  get 'blog/feed/atom' => redirect('/blog.atom')
  get 'blog/feed/rss' => redirect('/blog.atom')
  get 'blog/comments/feed' => redirect('http://hobo-staging.disqus.com/latest.rss')
  get 'blog/comments/feed/atom' => redirect('http://hobo-staging.disqus.com/latest.rss')
  get 'blog/*slug' => 'blog#blog', :as => 'blog'
  get 'blog' => 'blog#index', :as => 'blogs'

  # old routes from hobocentral.net
  get 'about' => redirect('/manual/about')
  get 'gallery' => redirect('/manual/gallery')
  get 'books' => redirect('/manual/books')
  get 'community' => redirect('/manual/community')
  get 'forum' => redirect('/manual/community')
  get 'api_taglibs' => redirect('/api_plugins')

  #map.site_search  'search', :controller => 'front', :action => 'search'

#  map.homepage '', :controller => 'front', :action => 'index'

#  map.manual         'manual',          :controller => 'manual', :action => 'index'
#  map.manual_section 'manual/:section', :controller => 'manual', :action => 'manual_section'
#  map.manual_section 'manual/:section/:subsection', :controller => 'manual', :action => 'manual_subsection'

#  map.tutorials 'tutorials',           :controller => 'tutorials', :action => 'index'
#  map.tutorial  'tutorials/:tutorial', :controller => 'tutorials', :action => 'show'
#
#  map.plugins 'plugins',           :controller => 'plugins', :action => 'index'
#  map.plugin  'plugins/:plugin',   :controller => 'plugins', :action => 'show'

#  Hobo.add_routes(map)
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   get 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # get ':controller(/:action(/:id(.:format)))'
end
