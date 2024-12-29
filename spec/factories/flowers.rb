FactoryBot.define do
  factory :flower do
    Brand { nil }
    name { "MyString" }
    thc { 1.5 }
    strain { "MyString" }
  end
end
