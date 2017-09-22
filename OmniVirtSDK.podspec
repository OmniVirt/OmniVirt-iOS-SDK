working_path = Dir.pwd
Pod::Spec.new do |spec|
  spec.name = "OmniVirtSDK"
  spec.version = "1.3.2"
  spec.summary = "360° Virtual Reality Embed Player and Monetization for iOS Apps"
  spec.homepage = "https://www.omnivirt.com"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "OmniVirt Team" => 'contact@omnivirt.com' }
  spec.social_media_url = "https://www.facebook.com/omnivirt"

  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/OmniVirt/OmniVirt-iOS-SDK.git", tag: "v#{spec.version}", submodules: true }
  spec.ios.vendored_frameworks = "OmniVirtSDK.framework"
end
