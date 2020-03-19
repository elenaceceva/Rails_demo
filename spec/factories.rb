FactoryBot.define do
  factory :location do
    city {"City"}
    country {"Country"}
    longitude {"11.12"}
    latitude {"41.21"}
  end

  factory :post do
    title {"example"}
    description {"description"}
  end

  factory :user do
    email {"john@gmail.com"}
    password {"password"}
    nickname {"john"}
    firstname {"John"}
    lastname {"Doe"}
  end
end