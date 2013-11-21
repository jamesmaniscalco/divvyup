class Person < ActiveRecord::Base
  # relations
  has_many :uses
  has_many :items

end
