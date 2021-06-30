//
//  MemoData.swift
//  NoteToDo
//
//  Created by Kang on 03/06/2019.
//  Copyright © 2019 Kang. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class MemoData {
    var title: String?  //제목
    var contents: String?   //내용
    var image: UIImage?     //이미지 뷰
    var regdate: Date?      //날짜
    
    //NoteToDo.xcdatamodeld에 저장된 MemoSD를 참조
    var objectID: NSManagedObjectID?
}

