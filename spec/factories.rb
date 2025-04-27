FactoryBot.define do
  sequence :aname do |n|
    "aname_#{n}"
  end

  sequence :amail do |n|
    "mail_#{n}@example.net"
  end

  factory :cross_reference do
    association :reference
    association :task
    identifier { "12345678" }
  end

  factory :day_type do
    abbrev { generate(:aname) }
  end

  factory :list do
    name { "Some List" }
    association :user
  end

  factory :note do
    description { "Some Notes" }
    date { Date.today.to_s }
    association :user
    association :task
  end

  factory :org_unit do
    name { "Workers Company" }
  end

  factory :reference do
    name { generate(:aname) }
  end

  factory :reference_url do
    association :reference
    name { "Web" }
    url { "https://example.com" }
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
    trait :pending do
      state { 'pending'}
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

    trait :pre do
      association :state, :pre
    end
    trait :open do
      association :state, :open
    end
    trait :done do
      association :state, :done
    end
    trait :archive do
      association :state, :archive
    end
  end

  factory :time_accounting do
    description { "Some Activity" }
    date { Date.today.to_s }
    duration { 30 }
    association :user
    association :task
  end

  factory :workday do
    date { Date.today.to_s }
    association :user
  end
end
