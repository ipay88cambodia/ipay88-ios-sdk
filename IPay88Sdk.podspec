Pod::Spec.new do |spec|
	spec.name         = "IPay88Sdk"
	spec.version      = "2.0.0"
	spec.summary      = "IPay88 SDK for iOS"
	spec.description  = <<-DESC
		IPAY88 (Cambodia) Plc.
		We accept online payments from various methods, such as:
		- Credit or Debit cards (Visa, Mastercard, JCB, Diners Club & UnionPay, etc.)
		- e-Wallets (KHQR, Wing, PiPay, eMoney, Alipay, WeChat Pay, etc.)
		- Online Banking (ACLEDA XPay, CAMPU Direct Debit, Chip Mong Pay, AMK Online Card, etc.)
	DESC
	spec.homepage     = "https://github.com/ipay88cambodia/ipay88-ios-sdk"
	spec.license      = { :type => "MIT", :file => "LICENSE" }
	spec.author       = { "kuntola" => "tola.kun@ipay88.com.kh" }
	spec.platform     = :ios
	spec.source       = { :git => "https://github.com/ipay88cambodia/ipay88-ios-sdk.git", :branch => "main", :tag => "#{spec.version}" }
	
	# Published binaries
	spec.ios.deployment_target   = "11.0"
	spec.ios.vendored_frameworks = "Source/IPay88Sdk.xcframework"
	
	# Add-Ons for Static Libs *.a (not build for iOS Simulator) which IPay88Sdk used
	spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
	spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end