//
//  MemoFormVC.swift
//  NoteToDo
//
//  Created by Kang on 03/06/2019.
//  Copyright © 2019 Kang. All rights reserved.
//
import UserNotifications
import UIKit
//메모를 입력하는 창.
class MemoFormVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UNUserNotificationCenterDelegate {
        var subject: String!
        lazy var dao = MemoDAO()
        //텍스트 뷰
        @IBOutlet var contents: UITextView!
        // 이미지 뷰
        @IBOutlet var preview: UIImageView!
        
        override func viewDidLoad() {
            self.contents.delegate = self
            
            // Do any additional setup after loading the view.
        }
        //저장하기.
        @IBAction func save(_ sender: Any) {
            //텍스트가 입력되지 않았을 경우 경고창 표시.
            guard self.contents.text?.isEmpty == false else {
                let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
            // MemoData 객체를 생성하고 데이터를 담음
            let data = MemoData()
            
            data.title = self.subject                       // 제목
            data.contents = self.contents.text    // 내용
            data.image = self.preview.image      // 이미지
            data.regdate = Date()                        // 작성 시각
            
            // 앱 델리개이트 객체를 읽어온 다음 memolist 배열에 MemoData 객체를 추가
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memolist.append(data)
            // 코어 데이터에 메모 데이터 추가
            self.dao.saveMemo(data)
            
            // 작성폼 화면을 종료하고 이전 화면으로 돌아감
            self.navigationController?.popViewController(animated: true)
        }
        
        //카메라 버튼
        @IBAction func pick(_ sender: Any) {
            //이미지 피커 컨트롤러
            let picker = UIImagePickerController()
            
            picker.delegate = self
            picker.allowsEditing = true
            //카메라 버튼을 눌렀을 때 어떤 곳에서 이미지를 가져올지 설정하는 알림창 생성
            let alert = UIAlertController(title: nil, message: "이미지를 가져올 곳을 선택해주세요.", preferredStyle: .actionSheet)
            
            // 카메라
            let camera = UIAlertAction(title: "카메라", style: .default) { (_) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    picker.sourceType = .camera
                    // 이미지 피커 화면 표시
                    self.present(picker, animated: false)
                }
            }
            
            // 저장앨범
            let savedAlbum = UIAlertAction(title: "저장 앨범", style: .default) { (_) in
                picker.sourceType = .savedPhotosAlbum
                // 이미지 피커 화면 표시
                self.present(picker, animated: false)
            }
            // 사진 라이브러리
            let photoLibrary = UIAlertAction(title: "사진 라이브러리", style: .default) {(_) in
                picker.sourceType = .photoLibrary
                // 이미지 피커 화면 표시
                self.present(picker, animated: false)
            }
            
            // 취소
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            // 버튼을 컨트롤러에 등록
            alert.addAction(camera)
            alert.addAction(savedAlbum)
            alert.addAction(photoLibrary)
            alert.addAction(cancel)
            
            // 알림창 실행
            self.present(alert, animated: false)
            
        }
        //이미지 선택 완료 시 호출.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //이미지 미리보기에 표시
            self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            //이미지 피커 컨트롤러 닫기
            picker.dismiss(animated: false)
        }
        
        func textViewDidChange(_ textView: UITextView) {
            // 내용의 10자리까지 읽어 제목으로 사용
            let contents = textView.text as NSString
            let length = (contents.length > 10) ? 10 : contents.length
            self.subject = contents.substring(with: NSRange(location: 0, length: length))
            
            // 내비게이션 타이틀에 표시
            self.navigationItem.title = subject
            
            
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
