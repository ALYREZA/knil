class Link < ApplicationRecord
  belongs_to :user
  has_many :analytics
  validates :title, presence: true,length: { minimum: 4 }
  validates :url,presence: true, length: { minimum: 4, max: 1745 }, url: true
  default_scope { order('created_at ASC') }

  before_create do
    self.uuid = UUIDTools::UUID.random_create
  end

end
