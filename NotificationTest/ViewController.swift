//
//  ViewController.swift
//  NotificationTest
//
//  Created by admin on 2019/10/7.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var etIdentifier: UITextField!
    @IBOutlet weak var etTitle: UITextField!
    @IBOutlet weak var etBody: UITextField!
    @IBOutlet weak var etTime: UITextField!
    @IBOutlet weak var etUserInfoKey: UITextField!
    @IBOutlet weak var etUserInfoValue: UITextField!
    
    private var userInfo: [AnyHashable : Any] = [AnyHashable : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        etIdentifier.delegate = self
        etTitle.delegate = self
        etBody.delegate = self
        etTime.delegate = self
        etUserInfoKey.delegate = self
        etUserInfoValue.delegate = self
        
    }
    
    //添加UserInfo
    @IBAction func addUserInfoAction(_ sender: Any) {
        let key = etUserInfoKey.text ?? ""
        let value = etUserInfoValue.text ?? ""
        if key.isEmpty || value.isEmpty {
            print("key 或 value 不能为空")
            return
        }
        etUserInfoKey.text = ""
        etUserInfoValue.text = ""
        userInfo[key] = value
    }
    
    //清除UserInfo
    @IBAction func clearUserInfoAction(_ sender: Any) {
        userInfo.removeAll()
        etUserInfoKey.text = ""
        etUserInfoValue.text = ""
    }
    
    //显示通知
    @IBAction func showNotifyAction(_ sender: Any) {
        var timeInt = Int(etTime.text ?? "0") ?? 0
        if timeInt <= 0 {
            timeInt = 1
        }
        
        let identifier = etIdentifier.text ?? ""
        if identifier.isEmpty {
            print("identifier 为空")
            return
        }
        
        let title = etTitle.text ?? ""
        let body = etBody.text ?? ""
        
        NotifyUtil.showNotification(content: NotifyCententUtil.shared.createNotificationContent().setTitle(title: title).setBody(body: body).setBadge(badge: 0).setUserInfo(userInfo: userInfo).build(), identifier: identifier, time: timeInt)
    }
    
    //清除通知
    @IBAction func clearNotifyAction(_ sender: Any) {
        let identifier = etIdentifier.text ?? ""
        if identifier.isEmpty {
            print("identifier 为空")
            return
        }
        NotifyUtil.removeDeliveredNotifications(identifieres: [identifier])
    }
    
}

extension ViewController: UITextFieldDelegate {
    //软键盘Return键监听
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
//        textField.resignFirstResponder()
        return true
    }
}
