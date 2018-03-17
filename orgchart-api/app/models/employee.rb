class Employee < ApplicationRecord
  validates_presence_of :title, :first_name, :last_name, :manager_id
end
