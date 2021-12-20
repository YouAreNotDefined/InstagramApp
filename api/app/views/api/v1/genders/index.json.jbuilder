json.genders do
  json.array! @genders, partial: "api/v1/genders/gender", as: :gender
end
