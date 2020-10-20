FactoryBot.define do
  factory :blog_category do
    blog_posts { [] }
    blog_post_count { 1 }
  end
end
