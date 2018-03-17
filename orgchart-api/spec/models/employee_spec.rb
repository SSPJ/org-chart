require 'rails_helper'

# Test suite for the Employee model
RSpec.describe Employee, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  #it { should have_many(:items).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:manager_id) }
end
