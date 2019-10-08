//
//  NotifyCententUtil.swift
//  NotificationTest
//
//  Created by admin on 2019/10/8.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit
import UserNotifications

class NotifyCententUtil {
    //单例
    static let shared = NotifyCententUtil()
    
    private var content: UNMutableNotificationContent? = nil
    
    func build() -> UNMutableNotificationContent {
        if content != nil {
            return content!
        }
        return UNMutableNotificationContent()
    }
    
    //创建通知载体
    func createNotificationContent() -> NotifyCententUtil {
        content = UNMutableNotificationContent()
        return .shared
    }
    
    //设置通知标题
    func setTitle(title: String) -> NotifyCententUtil {
        //设置推送内容
        content?.title = title
        return .shared
    }
    
    //设置通知次级标题
    func setSubtitle(subtitle: String) -> NotifyCententUtil {
        //设置推送内容
        content?.subtitle = subtitle
        return .shared
    }
    
    //设置通知内容
    func setBody(body: String) -> NotifyCententUtil {
        //设置推送内容
        content?.body = body
        return .shared
    }
    
    //设置通知徽章
    func setBadge(badge: NSNumber) -> NotifyCententUtil {
        //设置推送内容
        content?.badge = badge
        return .shared
    }
    
    //设置通知附件
    func setAttachments(attachments: [UNNotificationAttachment]) -> NotifyCententUtil {
        content?.attachments = attachments
        return .shared
    }
    
    //设置通知已注册的UNNotificationCategory的标识符
    func setCategoryIdentifier(categoryIdentifier: String) -> NotifyCententUtil {
        content?.categoryIdentifier = categoryIdentifier
        return .shared
    }
    
    //设置从通知中打开应用程序时将使用的启动图像。
    func setLaunchImageName(launchImageName: String) -> NotifyCententUtil {
        content?.launchImageName = launchImageName
        return .shared
    }
    
    //设置通知将会播放的声音。
    func setSound(sound: UNNotificationSound) -> NotifyCententUtil {
        content?.sound = sound
        return .shared
    }
    
    //设置与此通知请求相关的线程或会话的唯一标识符
    func setThreadIdentifier(threadIdentifier: String) -> NotifyCententUtil {
        content?.threadIdentifier = threadIdentifier
        return .shared
    }
    
    //设置通知负载的内容
    func setUserInfo(userInfo: [AnyHashable : Any]) -> NotifyCententUtil {
        content?.userInfo = userInfo
        return .shared
    }
    
    //设置要插入到此通知摘要中的参数。
    @available(iOS 12.0, *)
    func setSummaryArgument(summaryArgument: String) -> NotifyCententUtil {
        content?.summaryArgument = summaryArgument
        return .shared
    }
    
    //设置摘要中有多少项在摘要中表示的数字，默认为1，不能为0
    @available(iOS 12.0, *)
    func setSummaryArgumentCount(summaryArgumentCount: Int) -> NotifyCententUtil {
        content?.summaryArgumentCount = summaryArgumentCount
        return .shared
    }
}
