require 'rails_helper'

RSpec.describe Dislike, type: :model do
  # it { is_expected.to have_one(:user) }
  # it { is_expected.to have_one(:user).through(:posts) }
  it { is_expected.to belong_to(:post) }
  # it { is_expected.to belong_to(:comment) }
end
