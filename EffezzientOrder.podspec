
Pod::Spec.new do |s|

  s.name = "EffezzientOrder"
  s.version = "1.0.0"
  s.summary = "Ami's Effezzient Order module"

  s.homepage = "https://github.com/pratikhmehta/EffezzientOrder"
  s.author = { "ami-patel" => "amipatel27393@gmail.com" }
  s.platform = :ios, '11.0'
  s.source = {
    :git => "$HOME/EffezzientOrder.git",
    :tag => "v#{s.version}"
  }

  s.source_files = "EffezzientOrder/EffezzientOrder"
  s.requires_arc = true
  s.swift_version = '4.2'
end