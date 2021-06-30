//
//  MemoDao.swift
//  NoteToDo
//
//  Created by Kang on 12/06/2019.
//  Copyright © 2019 Kang. All rights reserved.
//

import Foundation
import UIKit
import CoreData
//코어 데이터를 이용하여 메모의 내용을 영구저장. Saving Data
class MemoDAO {
    
    lazy var context: NSManagedObjectContext = {
        // 앱 델리게이트에 저장된 내용을 가져옴
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()

    //메모 불러오기
    func fetch() -> [MemoData] {
        var memolist = [MemoData]()
        // 요청 객체 생성
        let fetchRequest: NSFetchRequest<MemoSD> = MemoSD.fetchRequest()
    
        // 최신 글 순으로 정렬하도록 설정
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        do {
            let resultset = try self.context.fetch(fetchRequest)
        
            // 읽어온 결과를 [MemoData] 타입으로 변환
            for record in resultset {
                // MemoData 객체 생성
                let data = MemoData()
            
                // MemoSD 값을 MemoData로 복사
                data.title = record.title
                data.contents = record.contents
                data.regdate = record.regdate! as Date
                data.objectID = record.objectID
            
                // 이미지가 있을 때 복사
                if let image = record.image as Data? {
                    data.image = UIImage(data: image)
                }
            
                // MemoData 객체를 memolist 배열에 추가
                memolist.append(data)
            }
        } catch let error as NSError {
            NSLog("Error : %s", error.localizedDescription)
        }
        return memolist
    }
    
    //메모 저장하기
    func saveMemo(_ data: MemoData) {
        // 관리 객체 인스턴스 생성
        let object = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: self.context) as! MemoSD
    
        // MemoData로부터 값을 복사
        object.title = data.title
        object.contents = data.contents
        object.regdate = data.regdate
        
        if let image = data.image {
            object.image = image.pngData()
        }
    
        // 코어 데이터 저장소에 변경 사항을 반영
        do {
            try self.context.save()
        } catch let error as NSError {
            NSLog("Error : %s", error.localizedDescription)
        }
    }
    
    func delete(_ objectID: NSManagedObjectID) -> Bool {
        // 삭제할 객체를 찾고 컨텍스트에서 삭제
        let object = self.context.object(with: objectID)
        self.context.delete(object)
        
        // 코어 데이터 저장소에 변경 사항을 반영
        do {
            try self.context.save()
            return true
        } catch let error as NSError {
            NSLog("Error: %s", error.localizedDescription)
            return false
        }
    }
    
}
