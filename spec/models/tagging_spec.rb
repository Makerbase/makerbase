require 'rails_helper'

RSpec.describe Tagging, type: :model do
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:tag) }
end
