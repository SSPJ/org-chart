require 'rails_helper'

RSpec.describe Employee, type: :model do
  it { should have_many(:underlings) }
  it { should validate_presence_of(:last_name) }
end
