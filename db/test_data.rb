require 'factory_girl_rails'

FactoryGirl.define do
  factory :page, :class => Refinery::Page do
    sequence(:title) { |n| "Lorem #{n}" }
    draft false
    deletable false
    show_in_menu true
  end

end

def children_for page, title
  page.children.create({
      :title => title,
      :deletable => true,
      :draft => false,
      :show_in_menu => true,
      :parent_id => page.id
  })
end

def childrens_for page, number=2
  if number > 0
    (1..number).each do |i|
      child = children_for page, "Ipsum #{i} child of #{page.id}"
      childrens_for child, number - 1
    end
  end
end

 (1..5).each do |i|

 attributes = {
      :deletable => true,
      :draft => false,
      :show_in_menu => true,
      :parent_id => nil
  }

  page = FactoryGirl.create(:page, attributes)
  childrens_for page
end

p 'done'
