module Images
  class FindProcessedImage
    def call(params)
      find_image(params)
    end

    private

    def find_image(params)
      Image.find_by!(id: params[:id], state: :processed)
    end
  end
end
