//
//  NotifyUtil.swift
//  NotificationTest
//
//  Created by admin on 2019/10/7.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit
import UserNotifications

open class NotifyUtil {
    
    //MARK:  注册推送
    open class func registerNotifications(_ application: UIApplication, delegate: UNUserNotificationCenterDelegate) {
        //-- 注册推送
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = delegate
            UNUserNotificationCenter.current().getNotificationSettings { (setting) in
                if setting.authorizationStatus == .notDetermined{
                    // 未注册
                    center.requestAuthorization(options: [.badge,.sound,.alert]) { (result, error) in
                        if(result){
                            //用户允许推送
                            if !(error != nil){
                                //注册成功
                                NotifyUtil.registerForRemoteNotifications()
                            }
                        } else{
                            //用户不允许推送
                        }
                    }
                } else if (setting.authorizationStatus == .denied){
                    //用户已经拒绝推送通知
                    //-- 弹出页面提示用户去显示
                    print("用户已经拒绝推送通知 -- 弹出页面提示用户去显示")
                }else if (setting.authorizationStatus == .authorized){
                    //已注册 已授权 --注册通知获取 token
                    print("已注册 已授权 --注册通知获取 token")
                    NotifyUtil.registerForRemoteNotifications()
                }else{
                    print("其它")
                }
            }
        }
        
    }
    
    // 注册通知，获取deviceToken
    open class func registerForRemoteNotifications() {
        // 请求授权时异步进行的，这里需要在主线程进行通知的注册
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    //显示通知
    open class func showNotification(content: UNMutableNotificationContent, identifier: String, time: Int) {
            //设置通知触发器
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
        //设置一个通知请求
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("1111111111111111111: Time Interval Notification scheduled: \(identifier)")
            } else {
                print("1111111111111111111: Time Interval Notification scheduled error: \(error?.localizedDescription ?? "显示通知失败")")
            }
        }
    }
    
    //取消指定的通知请求。
    open class func removePendingNotificationRequests(identifieres: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifieres)
    }
    
    //取消所有未决通知请求的时间表。
    open class func removeAllPendingNotificationRequests() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    //从通知中心移除指定的通知请求。
    open class func removeDeliveredNotifications(identifieres: [String]) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: identifieres)
    }
    
    //从NotificationCenter删除应用程序交付的所有通知。
    open class func removeAllDeliveredNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}
