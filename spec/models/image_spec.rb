require 'rails_helper'

RSpec.describe Image, type: :model do
  it { is_expected.to validate_presence_of(:callback_email) }

  describe 'email validation' do
    it { is_expected.to allow_value('a@b.com', 'aaaa.bbbb@c.d.e.f.ru').for(:callback_email) }
    it { is_expected.not_to allow_value('b.com', 'a@', 'a@b').for(:callback_email) }
  end
end
