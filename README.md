# LibIosBase

[![CI Status](https://img.shields.io/travis/767709667@qq.com/LibIosBase.svg?style=flat)](https://travis-ci.org/767709667@qq.com/LibIosBase)
[![Version](https://img.shields.io/cocoapods/v/LibIosBase.svg?style=flat)](https://cocoapods.org/pods/LibIosBase)
[![License](https://img.shields.io/cocoapods/l/LibIosBase.svg?style=flat)](https://cocoapods.org/pods/LibIosBase)
[![Platform](https://img.shields.io/cocoapods/p/LibIosBase.svg?style=flat)](https://cocoapods.org/pods/LibIosBase)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LibIosBase is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
  source 'https://cdn.cocoapods.org/'
  source 'https://github.com/krmao/libsforios.git'
  pod 'LibIosBase', '~>0.0.6'
```

## Author

767709667@qq.com

## License

LibIosBase is available under the MIT license. See the LICENSE file for more info.

## Create Custom Pods Lib Steps

* pod lib create LibIosBase
* add files to LibIosBase/Classes/LibraryBase

* config LibIosBase.podspec
  ```ruby
  #
  # Be sure to run `pod lib lint LibIosBase.podspec' to ensure this is a
  # valid spec before submitting.
  #
  # Any lines starting with a # are optional, but their use is encouraged
  # To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
  #

  Pod::Spec.new do |s|
    s.name             = 'LibIosBase'
    s.version          = '0.0.6'
    s.summary          = 'LibIosBase'

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    LibIosBase.
                          DESC

    s.homepage         = 'https://github.com/krmao/lib_ios_base'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '767709667@qq.com' => '767709667@qq.com' }
    s.source           = { :git => 'https://github.com/krmao/lib_ios_base.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    # s.source_files = 'LibIosBase/Classes/**/*'
    
    s.subspec 'LibraryBase' do |m|
      m.name = 'LibraryBase'
      m.source_files = 'LibIosBase/Classes/LibraryBase/**/**/**/*.{h,m,mm}'
      m.public_header_files = 'Pod/Classes/LibraryBase/**/**/**/*.h'
      m.dependency 'SSZipArchive'
      m.dependency 'MBProgressHUD', '~> 1.2.0'
      m.dependency 'AFNetworking', '~> 4.0'
      m.dependency 'SDWebImage', '~> 5.0'
      m.dependency 'YYModel'
      m.libraries = 'z','bz2.1.0' # can't include 'lib' prefix and '.xxx' suffix, such as 'libz.tbd', 'libbz2.1.0.tbd' 
    end

    # s.libraries = 'c++','z'
    # s.xcconfig = {
    #   'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    #   'CLANG_CXX_LIBRARY' => 'libc++'
    # }
      
    # s.resource_bundles = {
    #   'LibIosBase' => ['LibIosBase/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
  end
  ```

* git push and must be set git tag to version
  ```ruby
  git add .
  git commit -m "commit and push"
  git push
  git tag -a 0.0.6 -m 'version 0.0.6'
  git push origin --tags
  git tag # show tags
  ```

* add to custom repo
  ```ruby
  pod lib lint --allow-warnings
  pod repo push krmao LibIosBase.podspec --allow-warnings --verbose
  ```

* how to use
  ```ruby
  source 'https://cdn.cocoapods.org/'
  source 'https://github.com/krmao/libsforios.git'
  pod 'LibIosBase', '~>0.0.6'
  ```
