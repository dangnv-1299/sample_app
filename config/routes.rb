Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "static_pages/home"
    get "static_pages/help"
    get "users/new"
  end
end
