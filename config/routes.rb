Rails.application.routes.draw do


  get '/' => 'pages#home'
  get '/pages' => 'pages#home'
  get '/pages/:id' => 'pages#show'

  # get '/' => 'wines#index'
  get '/wines' => 'wines#index'
  get '/scan_barcode' => 'wines#scan_barcode'
  post '/wines/get_barcode' => 'wines#get_barcode'

  #image scanner:
  get '/scan_menu' => 'wines#scan_menu'
  post '/wines/get_menu' => 'wines#get_menu'

  get '/image' => 'wines#test_image'
  post '/image' => 'wines#process_image'

  #menu reader from scanned image
  get '/menu_reader' => 'wines#menu_reader'

  get '/wines/new' => 'wines#new'
  post '/wines' => 'wines#create'

  get '/wines/random' => 'wines#random' #must be before wines/:id otherwise it'll trigger random as an ":id" param. IF we put the wine.all.sample line into the show method, so we don't need the random route anymore. now the "random" word gets passed as a param into the show page. 

  get '/wines/:id' => 'wines#show'

  get '/wines/:id/edit' => 'wines#edit'
  patch '/wines/:id' => 'wines#update'

  delete '/wines/:id' => 'wines#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/users/:id/edit' => 'users#edit'
  patch '/users/:id' => 'users#update'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  #to create, edit, delete reviews
  get '/reviews' => 'reviews#new'
  post '/reviews' => 'reviews#create'
  get '/reviews/:id/edit' => 'reviews#edit'
  patch '/reviews/:id' => 'reviews#update'
  delete '/reviews/:id' => 'reviews#destroy'

  #to create, edit, delete pins
  get '/cellar' => 'pins#index'
  get '/pins/new' => 'pins#new'
  post '/pins' => 'pins#create'
  get '/pins/:id/edit' => 'pins#edit'
  patch '/pins/:id' => 'pins#update'
  delete '/pins/:id' => 'pins#destroy'


  get '/pages/:id' => 'pages#show'

  #to create, edit and delete personal_categories
  get 'personal_categories' => 'personal_categories#index'
  get '/personal_categories/new' => 'personal_categories#new'
  post '/personal_categories' => 'personal_categories#create'
  get '/personal_categories/:id/edit' => 'personal_categories#edit'
  patch '/personal_categories/:id' => 'personal_categories#update'
  delete '/personal_categories/:id' => 'personal_categories#destroy'

   #to create, edit and delete personal_category_pins
  get 'personal_category_pins' => 'personal_category_pins#index'
  get '/personal_category_pins/new' => 'personal_category_pins#new'
  post '/personal_category_pins' => 'personal_category_pins#create'
  get '/personal_category_pins/:id/edit' => 'personal_category_pins#edit'
  patch '/personal_category_pins/:id' => 'personal_category_pins#update'
  delete '/personal_category_pins/:id' => 'personal_category_pins#destroy'


end
