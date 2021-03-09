# CodesDancing

[![CI Status](https://img.shields.io/travis/767709667@qq.com/CodesDancing.svg?style=flat)](https://travis-ci.org/767709667@qq.com/CodesDancing)
[![Version](https://img.shields.io/cocoapods/v/CodesDancing.svg?style=flat)](https://cocoapods.org/pods/CodesDancing)
[![License](https://img.shields.io/cocoapods/l/CodesDancing.svg?style=flat)](https://cocoapods.org/pods/CodesDancing)
[![Platform](https://img.shields.io/cocoapods/p/CodesDancing.svg?style=flat)](https://cocoapods.org/pods/CodesDancing)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CodesDancing is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
  source 'https://cdn.cocoapods.org/'
  source 'https://github.com/krmao/libsforios.git'
  pod 'CodesDancing', '~>0.0.3'
```

## Author

767709667@qq.com

## License

CodesDancing is available under the MIT license. See the LICENSE file for more info.

## Create Custom Pods Lib Steps

* pod lib create CodesDancing
* add files to CodesDancing/Classes/LibraryBase

* config CodesDancing.podspec
  ```ruby
  #
  # Be sure to run `pod lib lint CodesDancing.podspec' to ensure this is a
  # valid spec before submitting.
  #
  # Any lines starting with a # are optional, but their use is encouraged
  # To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
  #

  Pod::Spec.new do |s|
    s.name             = 'CodesDancing'
    s.version          = '0.0.3'
    s.summary          = 'CodesDancing'

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    CodesDancing.
                          DESC

    s.homepage         = 'https://github.com/krmao/libsforios-codesdancing'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '767709667@qq.com' => '767709667@qq.com' }
    s.source           = { :git => 'https://github.com/krmao/libsforios-codesdancing.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    # s.source_files = 'CodesDancing/Classes/**/*'
    
    s.subspec 'LibraryBase' do |m|
      m.name = 'LibraryBase'
      m.source_files = 'CodesDancing/Classes/LibraryBase/**/**/**/*.{h,m,mm}'
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
    #   'CodesDancing' => ['CodesDancing/Assets/*.png']
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
  git tag -a 0.0.3 -m 'version 0.0.3'
  git push origin --tags
  git tag # show tags
  ```

* add to custom repo
  ```ruby
  pod lib lint --allow-warnings
  pod repo push krmao CodesDancing.podspec --allow-warnings
  ```

* how to use
  ```ruby
  source 'https://cdn.cocoapods.org/'
  source 'https://github.com/krmao/libsforios.git'
  pod 'CodesDancing', '~>0.0.3'
  ```
