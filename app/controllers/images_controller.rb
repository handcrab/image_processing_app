class ImagesController < ApplicationController
  def compress
    image = Image.create!(callback_email: compress_params[:email], image: compress_params[:file_image])

    CompressImageJob.perform_later(image.id)

    head :ok
  end

  def download
    image = Image.find(params[:id])
    processed_image = image.processed_image

    head 422 unless processed_image

    send_file("#{Rails.public_path}#{image.processed_image_url}",
              type: processed_image.metadata['mime_type'],
              disposition: 'attachment')
  end

  private

  def compress_params
    params.permit(:email, :file_image)
  end
end
