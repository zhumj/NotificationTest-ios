//
//  AppDelegate.swift
//  NotificationTest
//
//  Created by admin on 2019/10/7.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //请求通知权限
        NotifyUtil.registerNotifications(application, delegate: self)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    // 注册远程通知成功的回调
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //TODO: 注册远程通知, 将deviceToken传递过去
        let deviceStr = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        print("注册远程通知成功: \(deviceStr)")
    }

    //注册远程通知失败的回调
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //TODO: 注册失败后的结果, 可以在这里记录失败结果, 以后再伺机弹框给用户打开通知
        print("注册远程通知失败: \(error.localizedDescription)")
    }
    
    //远程通知点击 - 在前台调用下面该方法,该方法需要设置Background Modes --> Remote Notifications
    //用户点击通知以后才会调用，如果想一收到消息（用户还没点击通知）就会调用该方法，需要有3个条件
    //1、设置Background Modes –> Remote Notifications
    //2、在代理方法中调用代码块completionHandler(UIBackgroundFetchResultNewData);
    //3、App服务器发送数据时要增加一个”content-available”字段，值随意写
    //满足以上三个条件，当接收到通知时立即会调用代理方法
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let status = application.applicationState
        switch status {
        case .active:
            NSLog("在前台收到推送")
            break
        case .inactive:
            NSLog("后台->前台")
            break
        case .background:
            NSLog("后台")
            break
        @unknown default:
            NSLog("不知道哪里")
            break
        }
        completionHandler(.newData)
    }
    
    
    //app通知的点击事件
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //收到推送的请求
        let request = response.notification.request;
        //收到的内容
        let content = request.content;
        //收到用户的基本信息
        let userInfo = content.userInfo;
        //收到消息的角标
        let badge = content.badge;
        //收到消息的body
        let body = content.body;
        //收到消息的声音
        let sound = content.sound;
        //推送消息的副标题
        let subtitle = content.subtitle;
        //推送消息的标题
        let title = content.title;
        print("app通知的点击收到通知:body = \(body),title = \(title),subtitle = \(subtitle),badge = \(badge),sound = \(sound),userInfo = \(userInfo)")
        completionHandler()
    }
    
    //app在前台收到通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //收到推送的请求
        let request = notification.request;
        
        //收到的内容
        let content = request.content;
        
        //收到用户的基本信息
        let userInfo = content.userInfo;
        
        //收到消息的角标
        let badge = content.badge;
        
        //收到消息的body
        let body = content.body;
        //收到消息的声音
        let sound = content.sound;
        //推送消息的副标题
        let subtitle = content.subtitle;
        //推送消息的标题
        let title = content.title;
//        if ((notification.request.trigger?.isKind(of: UNNotificationTrigger.self)) ?? false) {
//            print("前台收到通知: userInfo = \(userInfo)");
//        }else{
            print("前台收到通知:body = \(body),title = \(title),subtitle = \(subtitle),badge = \(badge),sound = \(sound),userInfo = \(userInfo)")
//        }
        completionHandler([.badge, .alert, .sound])
    }
    
}
