//
//  MemoCell.swift
//  NoteToDo
//
//  Created by Kang on 03/06/2019.
//  Copyright © 2019 Kang. All rights reserved.
//

import UIKit
// Cell의 내용.
class MemoCell: UITableViewCell {
    @IBOutlet var subject: UILabel!     //제목
    @IBOutlet var contents: UILabel!    //내용
    @IBOutlet var regdate: UILabel!     //날짜
    @IBOutlet var img: UIImageView!     //이미지(미리보기)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
