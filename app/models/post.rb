class Post < ApplicationRecord

    scope :published, -> { where published: true }

    validates_presence_of :title, :text
    
    belongs_to :owner, class_name: 'User'
end
