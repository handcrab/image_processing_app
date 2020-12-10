module Images
  class CompressImage
    delegate :logger, to: Rails

    def initialize(
      image_compressor_job: CompressImageJob
    )
      @image_compressor_job = image_compressor_job
    end

    def call(params)
      image = create_image(params)
      compress_image(image)

      image
    end

    private

    def create_image(params)
      image = Image.create!(
        callback_email: params[:email],
        image: params[:file_image],
        state: :created
      )

      image.tap { |img| logger.info "#{img}: created" }
    end

    def compress_image(image)
      @image_compressor_job.perform_later(image.id)
    end
  end
end
