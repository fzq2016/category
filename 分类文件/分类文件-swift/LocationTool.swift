//
//  LocationTool.swift
//  10-(了解) 定位工具类的封装(代理模式到block模式的转换)
//
//  Created by xmg on 16/5/18.
//  Copyright © 2016年 xmg. All rights reserved.
//

import UIKit
import CoreLocation

typealias RequestBlock = (location : CLLocation?, error : String?) -> ()

class LocationTool: NSObject {
    
    // MARK:- 懒加载
    private lazy var locationM : CLLocationManager = {
        let locationM = CLLocationManager()
        locationM.delegate = self
        
        // 1.获取info.plist文件判断有没有对应的key
        let infoDict = NSBundle.mainBundle().infoDictionary!
        // 在iOS8.0之后需要主动请求授权
        if #available (iOS 8.0, *) {
            
//            print(infoDict)
            // NSLocationWhenInUseUsageDescription
            // NSLocationAlwaysUsageDescription
            
            // 2.获取前后台定位授权key的值
            let alwaysStr = infoDict["NSLocationAlwaysUsageDescription"]
            
            // 3.获取前台定位授权key的值
            let whenInUseStr = infoDict["NSLocationWhenInUseUsageDescription"]
            
            // 4.判断
            // 如果两个key只有一个有值,那么请求对应授权
            // 如果两个都有值,那么请求前后台定位授权
            // 如果都没有,给开发者提示
            if alwaysStr != nil {
                // 请求前后台定位授权
                locationM.requestAlwaysAuthorization()
            } else if whenInUseStr != nil {
                // 请求前台定位授权
                locationM.requestWhenInUseAuthorization()
                
                // 判断当前后台模式有没有勾选
                // location
                // 获取后台模式数组
                let backMode = infoDict["UIBackgroundModes"] as! [String]
                
                // 判断是否开启了位置后台模式
                if backMode.contains("location") {
                    
                    // 在iOS9.0之后,在前台定位授权情况下,想要在后台获取用户的位置信息,除了开启后台模式,还需要允许后台定位
                    if #available (iOS 9.0, *) {
                        locationM.allowsBackgroundLocationUpdates = true
                    }
                } else {
                    print("在iOS8.0之后前台定位授权情况下,如果想要在后台获取用户位置信息,需要开启后台模式 location updates")
                }
                
                
            } else {
                // 给用户提示
                print("这位开发者,难道你忘了吗?在iOS8.0之后,如果想要获取用户的位置信息,必须在info.plist文件中配置对应key NSLocationWhenInUseUsageDescription或者NSLocationAlwaysUsageDescription")
            }

        } else {
             let backMode = infoDict["UIBackgroundModes"] as! [String]
            // 判断是否开启了位置后台模式
            if !backMode.contains("location") {
                print("如果想要在后台获取用户位置信息,需要开启后台模式 location updates")
            }
        }
        
        return locationM
    }()

    // MARK:- 用于记录block
    private var requestBlock : RequestBlock?
    
    // MARK:- 单例
    static let shareInstance = LocationTool()
    
    // 如果想要创建一个工具类分以下几步
    // 1.确定接口的类型:是对象方法还是类方法,如果无法确定,先使用类方法
    // 2.确定方法名:见名知意
    // 3.确定参数:如果不知道,先传空
    // 4.确定返回值:如果不知道,什么都不返回

    func getCurrentLocation(requestBlock :RequestBlock) {

        // 1.记录block
        self.requestBlock = requestBlock
        
        // 2.开始定位
        locationM.startUpdatingLocation()
    }
}

// MARK:- CLLocationManagerDelegate
extension LocationTool : CLLocationManagerDelegate {
    /**
     当获取到用户的位置时,就会调用该方法
     
     - parameter manager:   位置管理者
     - parameter locations: 位置数组
     */
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 1.获取位置对象
        guard let location = locations.last else {
            self.requestBlock!(location: nil, error: "未获取用户的位置")
            return
        }
        
        // 2.判断位置是否有效
        if location.horizontalAccuracy < 0 {return}
        
        // 3.返回当前位置
        self.requestBlock!(location: location, error: nil)
        
    }
    
    
}



