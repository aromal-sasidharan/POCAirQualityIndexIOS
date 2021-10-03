# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'



workspace 'CleanBreeze.xcworkspace' 
project 'CleanBreeze/CleanBreeze.xcodeproj'

# # Rx
# def rx_pods
#   pod 'RxSwift', '~> 5.1.1'
#   pod 'RxCocoa', '~> 5.1.1'
#   pod 'RxSwiftExt', '~> 5'
#   pod 'RxGesture', '~> 3'
# end

def module_networking
  pod 'Networking', :path => 'Modules/Networking'
end 
def module_dashboard
  pod 'Dashboard', :path => 'Modules/Dashboard'
end 
def module_domain
  pod 'CleanBreezeDomain', :path => 'Modules/CleanBreezeDomain'
end 
def module_utility
  pod 'CleanBreezeUtility', :path => 'Modules/CleanBreezeUtility'
end
def modules
  module_utility
  module_domain
  module_networking
  module_dashboard
end

target 'CleanBreeze (iOS)' do
  
  use_frameworks!
  modules
  # rx_pods
  # Pods for CleanBreeze (iOS)
end


