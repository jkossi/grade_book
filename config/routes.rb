Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'api/v1/dashboard#index'

  devise_scope :user do
    get '/sign_up_academy129345' => 'devise/registrations#new', as: 'new_user_registration'
  end

  devise_for :users

  scope module: :api do
    scope module: :v1 do
      root to: 'dashboard#index'

      resources :staffs, shallow: true do
        member do
          get 'new_classroom'
          post 'create_classrooms'
          get 'new_student'
          post 'create_students'
        end

        collection do
          get 'edit_classroom/:id', to: 'staffs#edit_classroom'
          delete 'class_rooms/:id', to: 'staffs#destroy_classroom'
          patch 'class_rooms/:id', to: 'staffs#update_classroom'
          get 'class_rooms'
          get 'students'
          get 'edit_student/:id', to: 'staffs#edit_student'
          delete 'students/:id', to: 'staffs#destroy_student'
          patch 'students/:id', to: 'staffs#update_student'
        end

        resources :roles

        resources :academic_sessions

        resources :subjects

        resources :departments, shallow: true do

          resources :class_rooms do

            resources :students do

              resources :scores
            end
          end
        end
      end
    end
  end
end
