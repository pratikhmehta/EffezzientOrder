
Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "EffezzientOrder"
  spec.version      = "1.0.0"
  spec.summary      = "A custom framework for Effezzient's Order Module."
  spec.description  = "A custom framework for Effezzient's Order Module, developed by Ami Patel, to be integrated into multiple applications."
  spec.homepage     = "https://github.com/pratikhmehta/EffezzientOrder"
  spec.license      = "MIT"
  spec.author       = { "ami" => "pratik.mehta2713@gmail.com" }
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/pratikhmehta/EffezzientOrder.git", :tag => "1.0.0" }
  spec.source_files = "EffezzientOrder/**/*"

end
