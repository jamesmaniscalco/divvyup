class Item < ActiveRecord::Base
  include SharedMethods
  include ActionView::Helpers::NumberHelper

  # relations
  belongs_to :person
  belongs_to :item_type
  has_many :uses

  # validations
  validates :person_id, presence: true
  validates :item_type_id, presence: true
  validates :comment, length: { maximum: 100 }

  # scopes
  default_scope order(finished: :asc, created_at: :desc)
  scope :available, -> { where(finished: false) }
  scope :finished, -> { where(finished: true) }

  # before save hooks
  before_save :set_default_finished_flag
  def set_default_finished_flag
    self.finished ||= false
    true
  end

  # method to get how much has been used in total
  def amount_used
    total = 0.0
    uses.each do |use|
      total += use.amount_used
    end

    return {amount: number_with_precision(total, precision: 1), unit: base_unit(item_type.measure_by)}
  end

end
