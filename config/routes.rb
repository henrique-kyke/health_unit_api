Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   scope 'api', module: 'api', as: 'api' do
    scope 'v1', module: 'version_one', as: 'v1' do
      get 'find_ubs' => 'health_units#search'
    end
  end
end
