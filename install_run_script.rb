#!/usr/bin/env ruby

require 'pathname'

begin
	require 'xcodeproj'
rescue
	raise "We couldn't install xcodeproj on your machine. Please run `gem install xcodeproj` before trying to install OmniVirtSDK."
end

path_to_xcode_build_script = "#{File.dirname(__FILE__)}/strip-frameworks.sh"
xcode_build_script_name = 'Strip VRKit Framework'

path_to_spec = ARGV[0] # Passed from podspec using path variable

if path_to_spec.start_with?('/private/tmp/CocoaPods/Lint') or path_to_spec.end_with?('iOS-VR-Example/OmniVirtSDK.podspec')
  # CocoaPods Lint
  puts 'CocoaPods linting, bail now before fail'
  exit 0
else
  path_to_project = Dir.glob("#{ARGV[1]}/*.xcodeproj")[0]
end

path_to_project = "${PROJECT_FILE_PATH}"
puts path_to_project

#if path_to_project.nil?
#	raise "Please change the current directory to root of the Xcode project and then run `pod install` to install an OmniVirtSDK build phase script."
#else
	project = Xcodeproj::Project.open(path_to_project)
	main_target = project.targets.first
	script_installed = false
	
	main_target.shell_script_build_phases.each { |run_script|
		script_installed = true if run_script.name == xcode_build_script_name
	}
	
	if (!script_installed)
		puts "Installing run script in Xcode project #{path_to_project}"
		phase = main_target.new_shell_script_build_phase(xcode_build_script_name)
		phase.shell_script = File.open(path_to_xcode_build_script).read
		project.save()
	else
		puts "Run script already installed"
	end
#end
