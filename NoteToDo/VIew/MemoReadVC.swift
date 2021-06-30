//
//  MemoReadVC.swift
//  NoteToDo
//
//  Created by Kang on 03/06/2019.
//  Copyright © 2019 Kang. All rights reserved.
//

import UIKit
//메모 상세보기. 메모를 눌렀을때 보여지는 페이지
class MemoReadVC: UIViewController {
    //MemoData의 내용 저장.
    var param: MemoData?
    
    //제목
    @IBOutlet var contents: UILabel!
    //내용
    @IBOutlet var subject: UILabel!
    //이미지 뷰
    @IBOutlet var img: UIImageView!
    
   
    
    override func viewDidLoad() {
        //각 부분의 텍스트를 제목,내용,이미지로 사용
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        //날짜 형식 설정.
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        //상세보기에서 네비게이션의 타이틀
        let dateString = formatter.string(from: (param?.regdate)!)
        self.navigationItem.title = dateString
        
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
