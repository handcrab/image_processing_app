class ImagesController < ApplicationController
  def compress
    image = Image.create!(callback_email: compress_params[:email], image: compress_params[:file_image])

    CompressImageJob.perform_later(image.id)

    head :ok
  end

  def download
    head :ok
  end

  private

  def compress_params
    params.permit(:email, :file_image)
  end
end
