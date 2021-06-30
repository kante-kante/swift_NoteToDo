//
//  DatePickerVC.swift
//  NoteToDo
//
//  Created by Kang on 04/06/2019.
//  Copyright © 2019 Kang. All rights reserved.
//
import UserNotifications
import UIKit

class DatePickerVC: UIViewController {
    //AppDelegate에 선언한 내용을 참조하여 가져온다.
   var appDelegate = UIApplication.shared.delegate as? AppDelegate
    //데이트 피커
    @IBOutlet var timmerPicker: UIDatePicker!
    //알람 설정하기 버튼
    @IBAction func showNotificationAction(_ sender: Any) {
        print("date = \(timmerPicker.date)")
        appDelegate?.showNotification(date: timmerPicker.date)
        
        //알람 설정 확인 창 띄우기
        let alert = UIAlertController(title: "알림 설정", message: "알림이 설정되었습니다", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        self.present(alert, animated: false)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
