#!/usr/bin/env ruby

require 'pathname'
require 'xcodeproj'

path_to_xcode_build_script = "#{File.dirname(__FILE__)}/strip-frameworks.sh"
xcode_build_script_name = 'Strip VRKit Framework'

puts Dir.pwd
puts ARGV[0]

path_to_spec = ARGV[0] # Passed from podspec using path variable

if path_to_spec.start_with?('/private/tmp/CocoaPods/Lint')
  # CocoaPods Lint
  # e.g. /private/tmp/CocoaPods/Lint/Pods/Local Podspecs/POD_NAME.podspec

  puts 'CocoaPods linting, bail now before fail'
  exit 0
else
  path_to_project = Dir.glob("#{Dir.getwd}/*.xcodeproj")[0]
end

puts path_to_project

if path_to_project.nil?
	warn "Please change the current directory to root of the Xcode project and then run `pod install` to install an OmniVirtSDK build phase script. Otherwise, please follow the instruction from goo.gl/bsX8kn to install the build phase script."
else
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
end
