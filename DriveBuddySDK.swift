//
//  SDK.swift
//  DriveBuddySDK
//
//  Created by Hüsnü ŞENER on 14/08/2017.
//  Copyright © 2017 DriveBuddy. All rights reserved.
//

import Foundation

#if (arch(i386) || arch(x86_64))


@objc public protocol DriveBuddyDelegate{
    func driveBuddyNeedsLocationAlwaysUsePermission()
    func driveBuddyNeedsMotionPermission()
}

public enum DriveBuddyAuthenticationStatus{
    case NotAuthenticated
    case PendingAuthentication
    case Authenticated
}


public class DriveBuddy: NSObject{
    public static let SDKVersion="0.0.0"
    @objc public class func isAuthenticated(_ callback: @escaping (_ authenticated:Bool)->Void){
    }

    @objc public class func authenticate(withSDKKey key:String, username: String, firstName:String?=nil,lastName:String?=nil,email:String?=nil,phone:String?=nil, _ callback: @escaping (_ authenticated:Bool)->Void){
    }
    @objc public class func deauthenticate(_ callback:@escaping () -> ()){
    }
    @objc public class func getAuthenticationStatus()->DriveBuddyAuthenticationStatus{
        return DriveBuddyAuthenticationStatus.NotAuthenticated
    }

    @objc public class func enable(automaticDrivingDetection auto:Bool=true, _ callback:@escaping (_ success:Bool)->Void){
    }

    @objc public class func disable(_ callback: @escaping () -> ()){
    }

    @objc public class func restore(){
    }

    @objc public class func startDrivingActivity(_ callback: @escaping (_ success: Bool) -> ()){
    }

    @objc public class func stopDrivingActivity(){
    }

    @objc public class func getDrivingActivityStatus(_ callback: @escaping (_ activeDrivingActivity:Bool)->Void){
    }

    @objc public class func uploadData(_ callback:@escaping (_ anyFileUploadTry:Bool)->Void){
    }

    @objc public class func set(delegate:DriveBuddyDelegate?){
    }
}

#else
import DriveBuddyCore

    @objc public protocol DriveBuddyDelegate:DriveBuddyCoreDelegate{
        
    }
    public typealias DriveBuddyAuthenticationStatus=DriveBuddyCoreAuthenticationStatus
    

public class DriveBuddy: NSObject{
    @objc public static var SDKVersion:String{
        get{
            return DriveBuddyCore.SDKVersion
        }
    }
    
    @objc public class func isAuthenticated(_ callback: @escaping (_ authenticated:Bool)->Void){
        DriveBuddyCore.isAuthenticated(callback)
    }
    
    @objc public class func authenticate(withSDKKey key:String, username: String, firstName:String?=nil,lastName:String?=nil,email:String?=nil,phone:String?=nil, _ callback: @escaping (_ authenticated:Bool)->Void){
        DriveBuddyCore.authenticate(withSDKKey: key, username: username, firstName: firstName, lastName: lastName, email: email, phone: phone, callback)
    }
    
    @objc public class func deauthenticate(_ callback:@escaping () -> ()){
        DriveBuddyCore.deauthenticate(callback: callback)
    }
    
    @objc public class func getAuthenticationStatus(_ callback:@escaping (_ authenticationStatus:DriveBuddyCoreAuthenticationStatus)->Void){
        DriveBuddyCore.getAuthenticationStatus(callback)
    }
    
    @objc public class func enable(automaticDrivingDetection auto:Bool=true, _ callback:@escaping (_ success:Bool)->Void){
        DriveBuddyCore.enable(automaticDrivingDetection:auto, callback)
    }
    
    @objc public class func disable(_ callback: @escaping () -> ()){
        DriveBuddyCore.disable(callback)
    }
    
    @objc public class func restore(){
        DriveBuddyCore.restore()
    }
    
    @objc public class func startDrivingActivity(_ callback: @escaping (_ success: Bool) -> ()){
        DriveBuddyCore.startDrivingActivity(callback)
    }
    
    @objc public class func stopDrivingActivity(){
        DriveBuddyCore.stopDrivingActivity()
    }
    
    @objc public class func getDrivingActivityStatus(_ callback: @escaping (_ activeDrivingActivity:Bool)->Void){
        DriveBuddyCore.getDrivingActivityStatus(callback)
    }
    
    @objc public class func uploadData(_ callback:@escaping (_ anyFileUploadTry:Bool)->Void){
        DriveBuddyCore.uploadData(callback)
    }
    
    
    @objc public class func set(delegate:DriveBuddyDelegate?){
        DriveBuddyCore.set(delegate: delegate)
    }
    

}

#endif


