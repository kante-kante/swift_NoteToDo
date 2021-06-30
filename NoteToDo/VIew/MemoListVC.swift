//
//  MemoListVC.swift
//  NoteToDo
//
//  Created by Kang on 03/06/2019.
//  Copyright © 2019 Kang. All rights reserved.
//

import UIKit
//메모의 목록을 확인하는 창
class MemoListVC: UITableViewController {
    //앱 델리게이트에 저장한 내용을 가져옴.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //MemoDAO에 작성한 내용 사용
    lazy var dao = MemoDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Edit 버튼 추가
        self.navigationItem.leftBarButtonItem = editButtonItem
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //메모 목록화면이 나타날 때 복사한 내용들을 표시
        self.appDelegate.memolist = self.dao.fetch()
        // 테이블 데이터 리로드
        self.tableView.reloadData()
    }
    
    // 테이블 뷰의 셀 개수를 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.memolist.count
    }
    
    // 개별 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // memolist 배열에서 주어진 행에 맞는 데이터를 꺼냄
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 이미지 속성이 비어 있고 없고에 따라 프로토타입 셀 식별자를 변경
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        // 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달 받음
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MemoCell
        
        // 내용 구성. 셀의 텍스트와 이미지를 각각의 제목, 내용, 이미지로 지정.
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        // 날짜를 포맷에 맞게 형식 지정
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)
        
        return cell
    }
    
    // 테이블 행을 선택하면 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 상세 화면 인스턴스 생성
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        // 값을 전달한 다음 상세 화면으로 이동
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    //에디트 버튼을 눌렀을 때 선택 행을 삭제하는 메소드 추가
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        let data = self.appDelegate.memolist[indexPath.row]
        
        //선택한 행과 행의 데이터를 삭제하는 메소드 추가.
        if dao.delete(data.objectID!){
            self.appDelegate.memolist.remove(at: (indexPath as NSIndexPath).row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //에디트 버튼의 Delete를 한글로 바꿈
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "삭제하기"
    }
}
