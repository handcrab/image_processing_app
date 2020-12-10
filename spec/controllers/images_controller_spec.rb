require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  describe 'GET downloads' do
    context 'image not found' do
      it 'returns 404 state' do
        get(:download, params: { id: 'foo' })
        expect(response).to have_http_status(404)
      end
    end

    context 'image is not processed' do
      let(:image) { create(:image) }

      it 'returns 404 state' do
        get(:download, params: { id: image.id })
        expect(response).to have_http_status(404)
      end
    end

    context 'image is processed' do
      let(:image) { create(:image, :processed) }

      it 'returns 200 state' do
        get(:download, params: { id: image.id })
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
