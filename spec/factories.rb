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

  factory :task do
    subject { "Some Task" }
    association :state, :open
    association :user
    priority {'normal'}
  end

  factory :time_accounting do
    description { "Some activity" }
    date { Date.today.to_s }
    duration { 30 }
    association :user
    association :task
  end
end
