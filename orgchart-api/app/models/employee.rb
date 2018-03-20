class Employee < ApplicationRecord
  has_many :underlings, class_name: "Employee", foreign_key: "manager_id"
  belongs_to :superior, class_name: "Employee", optional: true
  validates_presence_of :last_name
  #def self.superior(manager_id)
  #  where("id = ?",manager_id)
  #end
  # scope :superior, ->(manager_id) { where(:id => manager_id) }
end
