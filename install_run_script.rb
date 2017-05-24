#!/usr/bin/env ruby

require 'pathname'
require 'xcodeproj'

path_to_xcode_build_script = '"${SRCROOT}/strip-frameworks.sh"'
xcode_build_script_name = 'Strip VRKit Framework'

puts Dir.pwd
puts ARGV[0]

path_to_spec = ARGV[0] # Passed from podspec using path variable

if path_to_spec.start_with?('/private/tmp/CocoaPods/Lint')
  # CocoaPods Lint
  # e.g. /private/tmp/CocoaPods/Lint/Pods/Local Podspecs/POD_NAME.podspec

  puts 'CocoaPods linting, bail now before fail'
  exit 0
elsif path_to_spec.include?('.cocoapods')
  # Pod installed from spec repo
  # podspec: /Users/ben/.cocoapods/repos/REPO_NAME/POD_NAME/1.0.0/POD_NAME.podspec
  # Dir.pwd: /Users/ben/APP_PATH/Pods/POD_NAME

  path_to_project = Dir.glob(Pathname.new(Dir.pwd) + '../../*.xcodeproj')[0]
else
  # Pod installed via :path in Podfile
  # podspec: /Users/ben/LOCAL_POD_PATH/POD_NAME/POD_NAME.podspec
  # Dir.pwd: /Users/ben/LOCAL_POD_PATH/POD_NAME

  path_to_project = Dir.glob(Pathname.new(path_to_spec) + '../../../*.xcodeproj')[0]
end

puts path_to_project

if path_to_project.nil?
	puts "Couldn't find Xcode project."
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
		phase.shell_script = path_to_xcode_build_script
		project.save()
	else
		puts "Run script already installed"
	end
end
