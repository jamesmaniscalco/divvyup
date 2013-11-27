class Person < ActiveRecord::Base
  # validations
  validates :name, length: { minimum: 1 }

  # relations
  has_many :uses
  has_many :items

  # scopes
  default_scope order(name: :asc)

end
