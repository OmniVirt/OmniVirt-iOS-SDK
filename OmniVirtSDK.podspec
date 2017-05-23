Pod::Spec.new do |spec|
  spec.name = "OmniVirtSDK"
  spec.version = "1.0.0"
  spec.summary = "Virtual Reality Embed Player and Monetization for iOS Apps"
  spec.homepage = "https://www.omnivirt.com"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "OmniVirt Team" => 'contact@omnivirt.com' }
  spec.social_media_url = "https://www.facebook.com/omnivirt/"

  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/OmniVirt/iOS-VR-Example.git", branch: "master", submodules: true }
  spec.vendored_frameworks = "#{path}/Frameworks/VRKit.framework"

  spec.prepare_command = "gem install xcodeproj; ruby Frameworks/install_run_script.rb '#{path}';"
end
