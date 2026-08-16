FactoryBot.define do
  factory :resume do
    association :user
    title { "Software Engineer Resume" }
  end
end
