//
//  UserMenu.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/15.
//

import Foundation

struct UserMenu {
    var menuName: String
    var menuImage: String
}

struct UserMenuList {
    let menu: [UserMenu] = [
        UserMenu(menuName: "공지사항", menuImage: "notice"),
        UserMenu(menuName: "자주 묻는 질문", menuImage: "faq"),
        UserMenu(menuName: "1:1 문의", menuImage: "qna"),
        UserMenu(menuName: "알림 설정", menuImage: "setting_alarm"),
        UserMenu(menuName: "이용약관", menuImage: "permit")
    ]
    
}
