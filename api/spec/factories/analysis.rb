FactoryBot.define do
  factory :analysis do
    association :resume
    association :job
    match_score { 85 }
    summary { "Strong match for the position." }
  end
end
