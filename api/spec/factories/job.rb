FactoryBot.define do
  factory :job do
    association :user
    company { "Acme Corporation" }
    title { "Software Engineer" }
    description { "Build and maintain software applications." }
  end
end
