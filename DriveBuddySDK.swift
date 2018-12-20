//
//  SDK.swift
//  DriveBuddySDK
//
//  Created by Hüsnü ŞENER on 14/08/2017.
//  Copyright © 2017 DriveBuddy. All rights reserved.
//

import Foundation

#if (arch(i386) || arch(x86_64))


public protocol DriveBuddyDelegate{
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
    public class func isAuthenticated(_ callback: @escaping (_ authenticated:Bool)->Void){
    }

    public class func authenticate(withSDKKey key:String, username: String, firstName:String?=nil,lastName:String?=nil,email:String?=nil,phone:String?=nil, _ callback: @escaping (_ authenticated:Bool)->Void){
    }
    public class func deauthenticate(){
    }
    public class func getAuthenticationStatus()->DriveBuddyAuthenticationStatus{
        return DriveBuddyAuthenticationStatus.NotAuthenticated
    }

    public class func enable(automaticDrivingDetection auto:Bool=true, _ callback:@escaping (_ success:Bool)->Void){
    }

    public class func disable(){
    }

    public class func restore(){
    }

    public class func startDrivingActivity(){
    }

    public class func stopDrivingActivity(){
    }

    public class func getDrivingActivityStatus(_ callback: @escaping (_ activeDrivingActivity:Bool)->Void){
    }

    public class func uploadData(_ callback:@escaping (_ anyFileUploadTry:Bool)->Void){
    }

    public class func set(delegate:DriveBuddyDelegate?){
    }
}

#else
import DriveBuddyCore

    public protocol DriveBuddyDelegate:DriveBuddyCoreDelegate{
        
    }
    public typealias DriveBuddyAuthenticationStatus=DriveBuddyCoreAuthenticationStatus
    

public class DriveBuddy: NSObject{
    public static var SDKVersion:String{
        get{
            return DriveBuddyCore.SDKVersion
        }
    }
    
    public class func isAuthenticated(_ callback: @escaping (_ authenticated:Bool)->Void){
        DriveBuddyCore.isAuthenticated(callback)
    }
    
    public class func authenticate(withSDKKey key:String, username: String, firstName:String?=nil,lastName:String?=nil,email:String?=nil,phone:String?=nil, _ callback: @escaping (_ authenticated:Bool)->Void){
        DriveBuddyCore.authenticate(withSDKKey: key, username: username, firstName: firstName, lastName: lastName, email: email, phone: phone, callback)
    }
    
    public class func deauthenticate(){
        DriveBuddyCore.deauthenticate()
    }
    
    public class func getAuthenticationStatus()->DriveBuddyAuthenticationStatus{
        return DriveBuddyCore.getAuthenticationStatus() as DriveBuddyAuthenticationStatus
    }
    
    public class func enable(automaticDrivingDetection auto:Bool=true, _ callback:@escaping (_ success:Bool)->Void){
        DriveBuddyCore.enable(automaticDrivingDetection:auto, callback)
    }
    
    public class func disable(){
        DriveBuddyCore.disable()
    }
    
    public class func restore(){
        DriveBuddyCore.restore()
    }
    
    public class func startDrivingActivity(){
        DriveBuddyCore.startDrivingActivity()
    }
    
    public class func stopDrivingActivity(){
        DriveBuddyCore.stopDrivingActivity()
    }
    
    public class func getDrivingActivityStatus(_ callback: @escaping (_ activeDrivingActivity:Bool)->Void){
        DriveBuddyCore.getDrivingActivityStatus(callback)
    }
    
    public class func uploadData(_ callback:@escaping (_ anyFileUploadTry:Bool)->Void){
        DriveBuddyCore.uploadData(callback)
    }
    
    
    public class func set(delegate:DriveBuddyDelegate?){
        DriveBuddyCore.set(delegate: delegate)
    }
    
    public class func uploadTestFile(line: String, _ callback:@escaping (_ success:Bool)->Void){
        DriveBuddyCore.uploadTestFile(line: line, callback)
    }

}

#endif


