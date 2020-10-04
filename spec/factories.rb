FactoryBot.define do
  sequence :aname do |n|
    "aname_#{n}"
  end

  sequence :amail do |n|
    "mail_#{n}@example.net"
  end

  factory :state do
    name { generate(:aname) }
    state { 'open' }
    trait :pre do
      state { 'pre'}
    end
    trait :open do
      state { 'open'}
    end
    trait :done do
      state { 'done'}
    end
    trait :archive do
      state { 'archive'}
    end
  end
end
