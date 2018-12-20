
# Introduction

Drive Buddy aims to provide safer travel for all drivers using only a phone's sensors. Drive Buddy SDK can detect crashes using sensor data and notify insurance companies or call chosen contacts. Drive Buddy will also build a detailed information and analysis of drivings. For letting Drive Buddy to collect driving data, you should place Drive Buddy SDK to your application. Drive Buddy SDK will collect Acceleration and Location data using the phone's sensors and build analysis of drivings.

# Get your SDK Key

To get your SDK key, you need to contact us via E-Mail. You can send a mail with subject `Request: SDK Key` to [support@drivebuddyapp.com](mailto:support@drivebuddapp.com?Subject=Request:%20SDK%20Key). 

# Integration

You can either use CocoaPods or bind Dynamic Libraries for adding SDK binaries to your project.

## 1. Using CocoaPods  (Recommended)

### 1. Init CocoaPods in your project if you didn't.
**Note:** If you didn't use CocoaPods before, please refer to these [installation](http://guides.cocoapods.org/using/getting-started.html) and [usage](http://guides.cocoapods.org/using/using-cocoapods.html) manuals first.

### 2. Add following lines into Podfile:

```
pod 'DriveBuddyCore', :git => 'https://github.com/DriveBuddy/Drive-Buddy-Ios-Sdk'
pod 'DriveBuddySDK', :git => 'https://github.com/DriveBuddy/Drive-Buddy-Ios-Sdk'
```


### 4. Run `pod install` command to install DriveBuddySDK and it's dependencies into your project. 

``` 
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['ENABLE_BITCODE'] = 'NO'
            end
        end
    end
```

**Note:** If you encounter linking problem due to bitcode, please disable bitcode from your project's and Pod project's build settings. DriveBuddySDK does not support bitcode generation. Also, to disable bitcode generation on CocoaPods projects, you may also need to add this snippet into your Podfile. It should be inside target block, following the `pod <framework> ...` lines.


## 2. Linking Dynamic Libraries Manually
**Note:** If you choose this method, beware that binaries are only for ARM architectures. Which means if you use Simulator in your computer to test your app, calls to our methods may prevent Simulator builds. If this is your case, please consider using CocoaPods method, or contact us for detailed support.

### 1. Right-click to your project folder in Xcode
### 2. Click `Add files to "Your_Project_Folder"`
### 3. If options are hidden, click `Options` button at the below left of the window
### 4. Check `Copy items if needed` option if it's unchecked
### 5. Choose `DriveBuddyCore.framework` , `DriveBuddySDK.swift`and `other framework folders` we provide, unless you have some already present in your project, and then press Add button
### 6. Click to root project, then in `General` tab, scroll to `Embedded Binaries` section. Here, each framework you've added to project folder in previous section, press `+` button and add that framework to Embedded Binaries section.

**Note:** If you encounter linking problem due to bitcode, please disable bitcode from your project's build settings. DriveBuddySDK does not support bitcode generation.
If you encounter another build or linking problem, try reopening Xcode. Xcode build configuration may be cached.



# Enabling DriveBuddy SDK on Your App



```swift
import DriveBuddySDK
class AppDelegate: UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Some other lines of code you have written
        //You can also call DriveBuddy.set(delegate:) here, explained below
        DriveBuddy.restore()
        return true
    }
}
```

- If you're using automatic driving detection, you should call `restore` method of `DriveBuddy` class whenever your app launches. This is necessary to resume tracking after relaunch of the app. It's recommended to call it inside `AppDelegate`'s `application:didFinishLaunchingWithOptions:` method. Here's an example:


- You must enable `Background Modes`  in `Capabilities`, and choose following mode under Background Modes:
    - `Location updates`


- You must add following keys to Info.plist or update them if they already exists with relevant values:
    - `NSLocationAlwaysAndWhenInUseUsageDescription`
        *(Xcode may also display it as `Privacy - Location Always and When In Use Usage Description`)*

        In iOS 11 and above, this is the description field displayed in authorization popup when user is asked for Always location permission. Since iOS 11, this popup also includes when in use Location permission option, but DriveBuddy SDK requires Always location permission to be enabled for tracking location on background. Therefore, please inform your users properly to make them choose Always location.

    - `NSLocationAlwaysUsageDescription`
        *(Xcode may also display it as `Privacy - Location Always Usage Description`)*

        The description field which is displayed in authorization popup until iOS 10 when user is asked for Always location permission. DriveBuddy SDK requires Always location permission for tracking location on background.

    - `NSLocationWhenInUseUsageDescription`
        *(Xcode May also display it as`Privacy - Location When In Use Usage Description`)*

        The description field which is displayed in authorization popup when user is asked for When in Use location permission. Even though DriveBuddySDK does not ask for When in Use location permission, iOS 11 and above also requires this field to be filled for asking Always location permission.

    - `NSMotionUsageDescription`
        *(Xcode may also display it as `Privacy - Motion Usage Description`)*

        The description field which is displayed in authorization popup when user is asked for Motion&Fitness Activity permission. DriveBuddy SDK requires Motion tracking features of iOS to evaluate user actions more accurately.
        
        
```swift
import DriveBuddySDK
class AppDelegate: UIApplicationDelegate, DriveBuddyDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Some other lines of code you have written
        DriveBuddy.set(delegate: self)
        DriveBuddy.restore()
        return true
    }
}
```

- You should provide a `DriveBuddyDelegate` instance `DriveBuddy` via it's `set(delegate:)` method. It's recommended place is inside `AppDelegate`'s `application:didFinishLaunchingWithOptions:` method, just before you call `restore` method of `DriveBuddy`. Otherwise you may miss some callbacks. 
        
    In your DriveBuddyDelegate implementation, you should promt the user about the missing permission, and redirect them to **your app's settings panel** in **Settings application**.
        
- You should provide the [SDK Key](#get-your-sdk-key) given by Drive Buddy and some user information string via calling `authenticate()` method. Given information should be enough to identify current user, such as a unique user id or a unique username.
        
- Whenever you want to start Driving tracking, you should call `DriveBuddy.enable()` method, this method enables asynchronously. Before calling this method, authentication credentials must be provided via `authenticate()` . If you prefer to stop detection, you should call `DriveBuddy.disable()`



# API Interface Reference

## DriveBuddy Class

- `authenticate(withSDKKey key:String, username: String, firstName:String?=nil,lastName:String?=nil,email:String?=nil,phone:String?=nil, _ callback: @escaping (_ authenticated:Bool)->Void)`

Tries to authenticate DriveBuddy SDK with the given key and the preffered username. You may optionally provide first name, last name, email address and phone number informations of the current user. Result of the attempt is the first argument of the callback method. Authentication is required to establish data transfers between SDK instance and DriveBuddy Servers. Will fail if no active internet connection or if the username is left blank or contains spaces.

- `deauthenticate()`

Removes existing authentication credentials from DriveBuddy SDK. SDK will no longer be able to connect to DriveBuddy Servers.

- `getAuthenticationStatus()`

Returns current authentication status of DriveBuddy SDK as a DriveBuddyAuthenticationStatus object. Check DriveBuddyAuthenticationStatus for detailed information.


- `enable(automaticDrivingDetection:Bool = true, callback:@escaping (_ success:Bool) -> Void)`

Enables the SDK services asynchronously. By default, automatic driving detection is enabled, you may disable it via optional `automaticDrivingDetection` parameter. Given callback is fired after enabling operation is completed or failed. Before executing this method, authentication credentials must be provided via `authenticate()` method. If success arguement of the callback is false,the authentication status is "not authenticated". 

- `disable()`

Disables SDK’s services.

- `restore()`

Restores SDK to the latest state, in other words, enables the SDK (with it's last automatic tracking state) if it was enabled last time application was running, keeps disabled otherwise. Expected to be called as soon as your app launches. It’s recommended to call this method inside your AppDelegate’s `application:didFinishLaunchingWithOptions:` method.


- `set(delegate:DriveBuddyDelegate?)`

If a non-nil delegate object is given, it’s set as a delegate for callbacks. If there was a previously set delegate, it’s replaced with the new one. If nil is given, it drops existing delegate.

- `startDrivingActivity()`

Tells SDK a driving activity has begun. Only used in manual driving detection mode, should not be called on automatic driving detection.

- `stopDrivingActivity()`

Tells SDK a driving activity has ended. Only used in manual driving detection mode, should not be called on automatic driving detection.

- `getDrivingActivityStatus(_ callback: @escaping (_ activeDriving:Bool)->Void)`

Returns whether there is an active driving as first argument of given callback.

## DriveBuddyDelegate Protocol

- `driveBuddyNeedsLocationAlwaysUsePermission()`

Fired when current application does not have Always Use permission for Location services. You should prompt user to give permission.

- `driveBuddyNeedsMotionPermission()`

Fired when the current application does not have Motion & Fitness permission. You should prompt the user to give
permission.

- `driveBuddyAuthenticationFailed()`

Fired when DriveBuddy SDK could not authenticate itself.


## DriveBuddyAuthenticationStatus Enum

- `NotAuthenticated`

DriveBuddy SDK is not authenticated.

- `PendingAuthentication`

DriveBuddy SDK is currently trying to authenticate.

- `Authenticated`

DriveBuddy SDK is authenticated.












