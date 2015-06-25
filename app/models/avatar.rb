class Avatar < ActiveRecord::Base
  before_save :check_image

  def check_image
    unless generated
      self.image_location = AvatarGenerator.from_seed(rand(12345..67890))
      self.generated = true
    end
  end
end