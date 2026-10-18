class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :title, presence: true, length: { maximum: 50 }

  scope :active, -> { where(done: false) }
  scope :completed, -> { where(done: true) }
  scope :by_due, -> { order(arel_table[:due_on].asc.nulls_last, id: :asc) }

  def self.search(keyword)
    return all if keyword.blank?

    where("title LIKE '%#{keyword}%'")
  end

  def overdue?(today = Date.current)
    !done? && due_on.present? && due_on <= today
  end
end
