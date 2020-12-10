require 'rails_helper'

RSpec.describe CompressImageJob do
  def call_uc
    described_class.new.perform(image_id)
  end

  let(:image) { create(:image) }
  let(:image_id) { image.id }

  context 'when image is not found' do
    let(:image_id) { 4242 }

    it 'sends notification, raises error' do
      expect(ImageMailer).to receive_message_chain(:fail_email, :deliver_later)
      expect { call_uc }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when image is found' do
    it 'compresses image, sends_notification, changes state' do
      expect(ImageMailer).to receive_message_chain(:success_email, :deliver_later)

      call_uc
      updated_image = Image.find(image.id)

      expect(updated_image.processed_image).to_not be_nil
      expect(updated_image.state).to eq('processed')
    end
  end
end
