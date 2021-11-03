json.posts do
  json.array! @posts do |post|
    json.merge! post.attributes
  end
end

json.user do
  json.extract! @user, :id, :name, :image, :first_name, :last_name, :description, :website, :email
end
