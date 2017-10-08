Rails.application.routes.draw do


  get '/' => 'wines#index'
  get '/wines' => 'wines#index'

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

  get '/reviews' => 'reviews#new'
  post '/reviews' => 'reviews#create'
  get '/reviews/:id/edit' => 'reviews#edit'
  patch '/reviews/:id' => 'reviews#update'
  delete '/reviews/:id' => 'reviews#destroy'

  get '/cellar' => 'pins#index'
  get '/pins/new' => 'pins#new'
  post '/pins' => 'pins#create'
  get '/pins/:id/edit' => 'pins#edit'
  patch '/pins/:id' => 'pins#update'
  delete '/pins/:id' => 'pins#destroy'



  # post '/orders' => 'orders#create'
  # get '/orders/:id' => 'orders#show' #must be below post in this case 

  # get '/cart' => 'carted_purses#index' #the index goes above the create action in this case
  # post '/carted_purses' => 'carted_purses#create' #leave this url as carted_purses, but the index route can have just cart instead
  # delete '/carted_purses/:id' => 'carted_purses#destroy'

end
