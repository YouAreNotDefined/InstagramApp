json.posts do
  json.extract! @posts, :description, :image, :image_cache
end

json.suggestions do
  json.extract! @follower_suggestions, :name, :image, :username
end
