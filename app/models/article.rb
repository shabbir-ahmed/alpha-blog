class Article < ApplicationRecord
    belongs_to :user
    validates :title, :description, presence: true
    validates :user_id, presence: true
end
