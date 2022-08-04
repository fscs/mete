class Audit < ApplicationRecord
  validates :difference, presence: true
  default_scope ->{ order('created_at DESC') }

  scope :deposits, ->{ where('difference > 0') }
  scope :payments, ->{ where('difference < 0') }

  def as_json(options)
    h = super(options)
    h.delete('user')
   return h
  end
end
