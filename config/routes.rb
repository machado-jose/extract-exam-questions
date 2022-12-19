Rails.application.routes.draw do
  get :enem_digital, to: 'extract#enem_digital'
end
