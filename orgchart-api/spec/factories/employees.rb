FactoryBot.define do
  factory :employee do
    id { Faker::Number.between(1,500) }
    title { Faker::Lorem.word }
    first_name { Faker::Lorem.word }
    last_name { Faker::Lorem.word }
    manager_id { Faker::Number.between(1,500) }
  end
end
