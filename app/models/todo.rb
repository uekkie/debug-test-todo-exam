class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :title, length: { maximum: 50 }

  scope :active, -> { where(done: false) }
  scope :completed, -> { where(done: true) }
  scope :by_due, -> { order(due_on: :asc, id: :asc) }

  def self.search(keyword)
    return all if keyword.blank?

    where("title LIKE '%#{keyword}%'")
  end

  def overdue?(today = Date.current)
    !done? && due_on.present? && due_on <= today
  end
end
