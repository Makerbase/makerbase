require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:posts).through(:taggings) }
end
