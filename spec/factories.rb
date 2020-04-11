FactoryBot.define do
  factory :post_tag do
    post { nil }
    tag { nil }
  end

  factory :tag do
    name { "MyString" }
  end

  factory :location do
    city {"City"}
    country {"Country"}
    longitude {"11.12"}
    latitude {"41.21"}
  end

  factory :post do
    title {"example"}
    description {"description"}
    user { User.first || association(:user) }
    location { Location.first || association(:location) }
  end

  factory :user do |u|
    u.email { |n| "john#{n}@awesome.com"}
    u.password {"password"}
    u.nickname { |n| "john#{n}"}
    u.firstname {"John"}
    u.lastname {"Doe"}
    u.location { Location.first || association(:location) }
  end
end