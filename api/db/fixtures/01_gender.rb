require "csv"

CSV.read('db/fixtures/common/gender.csv', headers: true).each do |row|
  Gender.seed do |s|
    s.id = row['id'].to_i
    s.type = row['type'].to_i
  end
end
