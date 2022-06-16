# IPay88 (Cambodia) Plc.
We accept online payments from various methods, such as:
* Credit or Debit cards (Visa, Mastercards, JCB, Diners Club & UnionPay, etc.)
* e-Wallets (KHQR, Wing, PiPay, eMoney, Alipay, WeChat Pay, etc.)
* Online Banking (ACLEDA XPay, CAMPU Direct Debit, Chip Mong Pay, AMK Online Card, Prince Bank QR, etc.)
* [Appendix I (1. PaymentId)](#1-paymentid)
* [Demo App](https://testflight.apple.com/join/82WBr9P1)

## IPay88 SDK for iOS
[//]: <> (https://img.shields.io/badge/pod-v1.0.0-blue)
[![](https://img.shields.io/cocoapods/v/IPay88Sdk)](https://img.shields.io/cocoapods/v/IPay88Sdk)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange)

### SDK Payment Flow
1. Your application initializes the library.
2. After buyers complete their payments, the library returns a delegate to your application with the status of the payment and the transaction id.
3. After the library flow is complete, a delegate result will be posted to be received by your application.


## Table of Contents
### 1. Requirements
1. Please share your App Information to IPay88 team:
    - AppId (App Bundle Identifier)
      - Inside Xcode, Select `Your Project` > TARGETS `Your Target App` > Inside Tab `General` > `Identity` > Bundle Identifier `xxx.xxx.xxx`
    - App Name (Optional)
      - For showing on the return button on some banks app. Eg: `RETURN TO LEGEND CINEMA`
2. Then IPay88 team will setup your App Information into IPay88 system to allow you to use IPay88 Mobile Payment channel. 
3. And then IPay88 team will share you these credentials:
    - Merchant Code (KHxxxxxx)
    - Merchant Key  (XXxxxxxx)
    - ClientAppSecret (IPAY88-xxxxxxxxxxxxxxxxxxxxxxxxx). Please refer to [2.2 Setup ClientAppSecret and CFBundleURLSchemes inside Info.plist](#22-setup-clientappsecret-and-cfbundleurlschemes-inside-infoplist)


### 2. Setup
#### 2.1 Dependencies
##### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `IPay88Sdk` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'IPay88Sdk', '1.0.0-SNAPSHOT'
```

##### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate `IPay88Sdk` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ruby
github "IPay88Cambodia/IPay88-iOS-Sdk" "1.0.0-SNAPSHOT"
```

##### Swift Package Manager
[Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

Once you have your Swift package set up, adding `IPay88Sdk` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

###### - Via `Package.swift`
```swift
dependencies: [
    .package(url: "https://github.com/ipay88cambodia/ipay88-ios-sdk.git", .exact(Version("1.0.0-SNAPSHOT")))
]
```

###### - Via `Xcode's UI`
- Step 1. Inside Xcode, Goto File > Add Packages...
- Step 2. An Alert Dialog appears > Inside the Search box at the top-right of the alert windows
  + Copy this URL and paste:
    ```
    https://github.com/ipay88cambodia/ipay88-ios-sdk.git
    ```
- Step 3. In the search result  > Select `ipay88-ios-sdk`
  + Dependency Rule: `Exact Version` > Enter the version number `1.0.0-SNAPSHOT`
  + Add to Project: `Your Project Name`

###### * Note: How To Hard Reset Swift Package
- Step1. Navigate to `~/Library/Caches/org.swift.swiftpm/repositories` and deleting the folder and lock file related to the package
- Step2. Then, in Xcode, Goto `File` > `Swift Packages` > `Reset Package Caches`
- Done.


#### 2.2 Setup ClientAppSecret and CFBundleURLSchemes inside Info.plist
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>kh.com.ipay88.sdk.ClientAppSecret</key>
    <string>IPAY88-xxxxxxxxxxxxxxxxxxxxxxxxx</string>
    
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>IPAY88-$(PRODUCT_BUNDLE_IDENTIFIER)</string>
            </array>
        </dict>
    </array>
</dict>
</plist>
```

#### 2.3 Connect Your App Delegate
Replace the code in `AppDelegate.swift` method with the following code. This code initializes the SDK when your app launches, and allows the SDK handle URL Scheme (Deeplink).
```swift
// AppDelegate.swift
import UIKit
import IPay88Sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IPay88AppDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        IPay88AppDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
}
```

iOS 13 moved opening URL functionality to the `SceneDelegate.swift`. If you are using iOS 13, add the following method to your SceneDelegate so that operations like logging in or sharing function as intended:
```swift
// SceneDelegate.swift
import UIKit
import IPay88Sdk

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let incomingURL = URLContexts.first?.url else { return }
        IPay88AppDelegate.shared.application(
            UIApplication.shared,
            open: incomingURL,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
}
```


### 3. Payment Request & Response
#### 3.1 Payment Request
##### 3.1.1 Payment Request Object
```swift
class IPay88PayRequest
```
##### 3.1.2 Payment Request Properties
Property Name              |  Required         |   Description
-------------              | :---------------: | -------------
environment: Environment   |                   |   Swtich between SANDBOX (default) & PRODUCION environment. Please refer to [3.1.3 Environment](#313-environment)
merchantCode: String       |   &#10003;        |   Merchant Code that provided by IPay88, E.g. KH00001
merchantKey: String        |   &#10003;        |   Merchant Key that provided by IPay88.
paymentId: Int             |   &#10003;        |   PaymentId is the value to request payment method to appear on IPay88 landing page. Please refer to [Appendix I (1. PaymentId)](#1-paymentid)
refNo: String              |   &#10003;        |   Reference number for merchant reference purposes, should be unique for each transaction.
amount: Double             |   &#10003;        |   Final Amount to pay and in 2 decimal point, E.g. 10.90
currency: Currency         |   &#10003;        |   Currency of transaction. Please refer to [3.1.4 Currency](#314-currency)
prodDesc: String           |   &#10003;        |   Simple Product Description. Note: Special characters is not allowed.
userName: String           |   &#10003;        |   Customer name in merchant's system. E.g. John Woo
userEmail: String          |   &#10003;        |   Customer email address in merchant's system with valid email format, E.g. johnwoo@yahoo.com
userContact: String        |   &#10003;        |   Customer contact number in merchant's system, E.g. 60123436789
remark: String?            |                   |   Remark for particular transaction. Note: Special characters is not allowed.
backendURL: String?        |                   |   Specify a valid merchant callback URL when payment success (Please refer to [6. Backend Post Feature](#6-backend-post-feature)). E.g. http://www.myshop.com/backend_page.php
##### 3.1.3 Environment
```swift
public enum Environment {
    case SANDBOX
    case PRODUCTION
}
```
##### 3.1.4 Currency
```swift
public enum Currency {
    case KHR
    case USD
}
```

#### 3.2 Payment Response
##### 3.2.1 Payment Response Object
```swift
class IPay88PayResponse
```
##### 3.2.2 Payment Response Properties
Property Name                |  Required         |   Description
-------------              | :---------------: | -------------
merchantCode: String?      |   &#10003;        |   Merchant Code provided by IPay88 and use to uniquely identify the Merchant. E.g. KH00001
paymentId: Int?            |   &#10003;        |   Please refer to [Appendix I (1. PaymentId)](#1-paymentid) for possible PaymentId value return to BackendPostURL.
refNo: String?             |   &#10003;        |   The request Reference number for merchant reference purposes, should be unique for each transaction.
amount: Double?            |   &#10003;        |   Payment amount with two decimals
currency: String?          |   &#10003;        |   Currency code that based on standard ISO (KHR or USD)
remark: String?            |                   |   Remark for particular transaction.
transId: String?           |   &#10003;        |   IPay88 Transaction ID. E.g. T019988877700
authCode: String?          |                   |   Bank reference number. Note: Sometime bank may not return reference number to gateway.
status: Int?               |   &#10003;        |   Use to indicate payment status “1” – Success OR “0” – Fail
errDesc: String?           |                   |   Payment status description. Please refer to [Appendix I (3. Error Description)](#3-error-description)
signature: String?         |   &#10003;        |   SHA1 signature. Please refer to [5. Signature Response](#5-signature-response)


### 4. How to Make Payment
#### 4.1 Create Payment Request Object
```swift
// MARK: - Step1. Import SDK to your ViewController
import IPay88Sdk

// MARK: - Step2. Create Payment Request
let payRequest = IPay88PayRequest()
payRequest.environment = .SANDBOX
payRequest.merchantCode = "KH00001"
payRequest.merchantKey = "Apple88KEY"
payRequest.paymentId = 1
payRequest.refNo = "ORD1188"
payRequest.amount = 1.00
payRequest.currency = .USD
payRequest.prodDesc = "TopUp"
payRequest.userName = "kuntola"
payRequest.userEmail = "tola.kun@ipay88.com.kh"
payRequest.userContact = "017847800"
payRequest.remark = nil
payRequest.backendURL = "http://www.myshop.com/backend_page.php"
```

#### 4.2 Create Payment Delegate
+ Your ViewController should adopt to `IPay88Delegate`:
```swift
// MARK: - Step3. Implement IPay88Delegate to Get Payment Status
extension YourViewController: : IPay88Delegate {
    func onResponse(payResponse: IPay88PayResponse) {
        if let status = payResponse.status {
            print(status == 1 ? "SUCCESS" : "FAILED")
        }
    }

    func onFailure(message: String) {
        print(message)
    }
}
```

#### 4.3 Invoke Checkout Function
```swift
// MARK: - Step4. Checkout
IPay88SDK.shared.checkout(currentViewController: self, payRequest: payRequest, delegate: self)
```


### 5. Signature Response
+ If the Merchant request is successful the response message will contain as SHA1 hashed signature. 
+ The hash signature for the response is a hash of the following fields:
    ```
    1. MerchantKey (Provided by IPay88 and share between IPay88 and merchant only)
    2. MerchantCode
    3. PaymentId
    4. RefNo
    5. Amount
    6. Currency
    7. Status
    ```         
+ The fields must be set in the following order, (MerchantKey & MerchantCode & PaymentId & RefNo & Amount & Currency & Status)
+ For Example:
    ```
    MerchantKey = "Apple88KEY"
    MerchantCode = "KH00001"
    PaymentId = "1"
    RefNo = "ORD1188"
    Amount = "1.00" (Note: Remove the “.” and “,” in the string before hash)
    Currency = "KHR"
    Status = "1"
    ```
         
    - The hash would be calculated on the following string:
    ```
    Apple88KEYKH00001ORD1188100KHR1
    ```
    - The resulting has signature value equals to (using SHA1 algorithm)
    ```
    KiCecyU86ZOFk15jXwOAvHdw/1M=
    ```
+ Test URL: <a href="https://payment.ipay88.com.kh/epayment/testing/TestSignature_response.asp" target="_blank">https://payment.ipay88.com.kh/epayment/testing/TestSignature_response.asp</a>


### 6. Backend Post Feature
The Backend POST feature is server to server technology. It does not depend on the `IPay88Sdk's Payment Screen` to return payment response data to `Merchant App`. With this feature implemented, your system still can get the payment status on the backend (asynchronously) even if the `IPay88Sdk's Payment Screen` fails to get status from IPay88 System which may be due to a closed `IPay88Sdk's Payment Screen`, internet connection timeout and etc.

#### 1. Prerequisite

-  This Backend post feature will ONLY return status if the transaction is a payment `success`. No status will return if the payment is `failed`.
- The Backend page should implement checking on some fields such as `Signature` (Please refer to [5. Signature Response](#5-signature-response)) and `Amount` to prevent user hijack merchant system.
- The backend page should not have session related code so that merchant systems are still able accept payment status from IPay88 System even if the user is logged out or the session is expired.
- You need to implement a check to determine "backend page" to update the order so it won't update order status in merchant system more than 1 time.
- After receiving the payment success status, IPay88 OPSG will simultaneously return payment status to the SDK's Callback and "backend page".

#### 2. Implementation
On the merchant website, create a page to accept backend post response parameters from IPay88 System.

The Backend Post response parameters are same like [3.2.2 Payment Response Properties](#312-payment-request-properties) but use the Capitalization (Eg. `merchantCode` -> `MerchantCode`).

- Step1. Specify your "backend page" in [3.1.2 Payment Request Properties](#312-payment-request-properties) on field named `backendURL`.
- Step2. On your "backend page" you have to write out the word `RECEIVEOK` as an acknowledgement when you get the payment success status from IPay88 System. And IPay88 System will re-try send the payment status to the "backend page" up to 3 times on different interval if no `RECEIVEOK` acknowledgement detected.

    Note: 
    > Make sure just the word `RECEIVEOK` only on your "backend page" without any HTML tag on the page.

#### 3. Sample Code
ASP Classic
```vbScript
<%
    MerchantCode    = Request.Form("MerchantCode")
    PaymentId       = Request.Form("PaymentId")
    RefNo           = Request.Form("RefNo")
    Amount          = Request.Form("Amount")
    eCurrency       = Request.Form("Currency")
    Remark          = Request.Form("Remark")
    TransId         = Request.Form("TransId")
    AuthCode        = Request.Form("AuthCode")
    eStatus         = Request.Form("Status")
    ErrDesc         = Request.Form("ErrDesc")
    Signature       = Request.Form("Signature")

    If eStatus = 1 Then
        ' COMPARE Return Signature with Generated Response Signature 
        ' And Update order to PAID
        response.write "RECEIVEOK"
    Else
        ' Update order to FAIL
    End If
%>
```

PHP
```php
<?php
    $merchantcode   = $_REQUEST["MerchantCode"];
    $paymentid      = $_REQUEST["PaymentId"];
    $refno          = $_REQUEST["RefNo"];
    $amount         = $_REQUEST["Amount"];
    $ecurrency      = $_REQUEST["Currency"];
    $remark         = $_REQUEST["Remark"];
    $transid        = $_REQUEST["TransId"];
    $authcode       = $_REQUEST["AuthCode"];
    $estatus        = $_REQUEST["Status"];
    $errdesc        = $_REQUEST["ErrDesc"];
    $signature      = $_REQUEST["Signature"];

    if ($estatus == 1) {
        // COMPARE Return Signature with Generated Response Signature 
        // And Update order to PAID
        echo "RECEIVEOK";
    }
    else {
        // Update order to FAIL }
    }
?>
```


### Appendix I
#### 1. PaymentId
+ Set PaymentId = 0, it will show all registered payment methods to the customer.
##### 1.1 Credit & Debit Card
Payment Method Name |  PaymentId (USD)| Logo
-------------       | :-------------: | :-------------:
Credit Card         |   1             |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/CC.svg" />
UnionPay            |   15            |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/MPGS_UPI.svg" />

##### 1.2 eWallet
Payment Method Name |  PaymentId (USD)|  PaymentId (KHR)| Logo
-------------       | :-------------: | :-------------: | :-------------:
eMoney              |   9             |     10          |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/EW_EMONEY.svg" />
Pi Pay              |   11            |                 |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/EW_PIPAY.svg" />
Alipay              |   233           |                 |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/QR_ALIPAY.svg" />
Wing                |   235           |     236         |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/EW_ONLINEEWING.svg" />
WeChat Pay          |   240           |                 |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/QR_WECHAT.svg" />
KHQR                |   248           |     249         |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/QR_KHQR.svg" />

##### 1.3 Online Banking
Payment Method Name |  PaymentId (USD)|  PaymentId (KHR)| Logo
-------------       | :-------------: | :-------------: | :-------------:
Acleda XPAY         |   3             |     4           |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/OB_ACLEDAXPAY.svg" />
Chip Mong Pay       |   238           |     239         |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/OB_CHIPMONG.svg" />
Campu Direct Debit  |   242           |     243         |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/OB_CAMPUDIRECTDEBIT.svg" />
AMK Online Card     |   246           |     247         |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/OB_AMKCARD.svg" />
Prince Bank QR      |   251           |     252         |   <img width="35" src="https://payment.ipay88.com.kh/PG/assets/images/bank/QR_PRINCE_BANK.svg" />

#### 2. Currency
Currency Code   |  Description
-------------   | -------------
KHR             | Cambodia Riel
USD             | US Dollar

#### 3. Error Description
Message                     |  Description
-------------               | -------------
Duplicate reference number  |   Reference number must be unique for each transaction.
Invalid merchant            |   The merchant code does not exist.
Invalid parameters          |   Some parameter posted to IPay88 is invalid or empty.
Overlimit per transaction   |   You exceed the amount value per transaction.
Payment not allowed         |   The Payment method you requested is not allowed for this merchant code, please contact IPay88 Support to verify what payment method available for the merchant account.
Permission not allow        |   Your AppId or the shared credentials is not match with the information registered in IPay88 merchant account. Please contact IPay88 team.

#### 4. Demo
[IPAY88SDK-Demo](https://testflight.apple.com/join/82WBr9P1)