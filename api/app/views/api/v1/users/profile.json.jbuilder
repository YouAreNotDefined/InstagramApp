json.posts do
  json.extract! @posts, :description, :image, :image_cache
end

json.user do
  json.extract! @user, :name, :image, :first_name, :last_name, :description, :website, :email
end
