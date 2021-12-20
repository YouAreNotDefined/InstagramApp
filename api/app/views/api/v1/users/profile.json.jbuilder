json.posts do
  json.array! @posts do |post|
    json.merge! post.attributes
  end
end

json.user do
  json.extract! @user, :id, :name, :image, :nickname, :description, :website, :email, :gender_id, :gender_detail, :phone_number
end
