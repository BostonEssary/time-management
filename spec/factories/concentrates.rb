FactoryBot.define do
  factory :concentrate do
    strain { "MyString" }
    concentrate_type { "MyString" }
    brand { nil }
    name { "MyString" }
    thc { 1.5 }
  end
end
