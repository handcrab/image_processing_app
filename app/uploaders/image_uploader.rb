class ImageUploader < Shrine
  plugin :determine_mime_type
  plugin :validation_helpers

  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png]
    validate_extension %w[jpg jpeg png]
  end
end
