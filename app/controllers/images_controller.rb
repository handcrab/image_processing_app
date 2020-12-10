class ImagesController < ApplicationController
  def compress
    compress_params = params.permit(:email, :file_image)
    image = Images::CompressImage.new.call(compress_params)

    render json: { id: image.id }
  end

  def download
    download_params = params.permit(:id)
    image = Images::FindProcessedImage.new.call(download_params)

    # TODO X-Accel-Redirect is preferred in real app
    send_file(
      "#{Rails.public_path}#{image.processed_image_url}",
      type: image.processed_image.metadata['mime_type'],
      disposition: 'attachment'
    )
  end
end
