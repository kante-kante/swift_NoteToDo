//
//  AppDelegate.swift
//  NoteToDo
//
//  Created by Kang on 03/06/2019.
//  Copyright © 2019 Kang. All rights reserved.
//
import UserNotifications
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UNUserNotificationCenterDelegate{

    var window: UIWindow?
    //MemoData를 memolist 배열로 저장
    var memolist = [MemoData]()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //권한 허가 요청. 알림센터에 등록해두면 기기 내부 설정창에서 푸시 선택 가능.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound,.badge], completionHandler: { (authorized, error) in
            //권한설정 거부 시, 표시
            if !authorized {
                print("앱 권한을 허용하지 않았기 떄문에 앱을 사용 할 수 없습니다.")
            }
        })
        
        UNUserNotificationCenter.current().delegate = self
        // Override point for customization after application launch.
        return true
    }
    
    
    //상단 알림바의 알림 내용들을 설정.
    func showNotification(date: Date){
        
        let content = UNMutableNotificationContent()
        content.title = "메모장 알림"
        content.body = "메모해둔 일정들을 혹시 잊진 않으셨나요? 앱을 실행하여 확인해보세요!"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "Category"
        content.badge = 1
        
        //타이머 설정. 초단위로 설정. 반복여부 설정.
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: ex)3, repeats: false)
        
        //일정 설정. 년도,달 설정 가능.
        //let date = Date(timeIntervalSinceNow: 60)
        //let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        //let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,repeats: false)
        
        //주단위 설정.
        let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
        
        //하루만 설정. DatePicker를 이용한 알림 설정.
        //let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        //let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        
        
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request){ (error) in
            if let error = error {
                print("Error:\(error.localizedDescription)")
            }
        }
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NoteToDo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

