class Quest < ApplicationRecord
  attribute :completed, :boolean, default: false

  validates :title, presence: true, allow_blank: false
end
