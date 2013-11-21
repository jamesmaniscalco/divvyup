class Person < ActiveRecord::Base
  # validations
  validates :name, length: { minimum: 1 }

  # relations
  has_many :uses
  has_many :items

end
