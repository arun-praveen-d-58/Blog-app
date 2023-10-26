
FactoryBot.define do
  factory :post do
    name { 'Sample Post' }

    # Factory for a Post with an attached image
    factory :post_with_image do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'sample_image.jpg'), 'image/jpeg') }
    end
  end
end
