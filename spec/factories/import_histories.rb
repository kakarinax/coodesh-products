FactoryBot.define do
  factory :import_history do
    imported_at { DateTime.now }
    status { %w[success error].sample }
    file_name { Faker::File.file_name }
    imported_count { Faker::Number.number(digits: 10) }
    error_message { Faker::Lorem.sentence }
  end
end
