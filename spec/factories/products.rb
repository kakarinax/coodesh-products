FactoryBot.define do
  factory :product do
    imported_t { DateTime.now }
    status { %w[draft trash published].sample }
    code { Faker::Number.number(digits: 10) }
    url { Faker::Internet.url }
    creator { Faker::Name.name }
    product_name { Faker::Food.dish }
    quantity { Faker::Food.measurement }
    brands { Faker::Food.ingredient }
    categories { Faker::Food.description }
    labels { Faker::Food.ingredient }
    cities { Faker::Address.city }
    purchase_places { Faker::Address.country }
    stores { Faker::Name.name }
    ingredients_text { Faker::Food.ingredient }
    traces { Faker::Food.ingredient }
    serving_size { Faker::Food.measurement }
    serving_quantity { Faker::Number.decimal(l_digits: 2, r_digits: 1) }
    nutriscore_score { Faker::Number.between(from: 0, to: 100) }
    main_category { Faker::Food.description }
    image_url { Faker::Internet.url }

    trait :with_invalid_status do
      status { Faker::Lorem.word }
    end
  end
end
