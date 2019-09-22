//
//  Const.swift
//  NoSchool
//
//  Created on 2019/05/25.
//  Copyright © 2019 inuko. All rights reserved.
//
import UIKit

final class Const {
    static let keyChainAccessToken = "access_token"
    static let keyChainRefreshToken = "refresh_token"
    static let keyChainExpiredTime = "expired_time"
    static let keyChainUserId = "user_id"
    static let userData = "user_data"
    static let expiredTime = "expired_time"
    static let prefectures: Dictionary = [1: "北海道", 2: "青森県", 3: "岩手県", 4: "宮城県", 5: "秋田県", 6: "山形県", 7: "福島県", 8: "茨城県", 9: "栃木県", 10: "群馬県",
                                          11: "埼玉県", 12: "千葉県", 13: "東京都", 14: "神奈川県", 15: "新潟県", 16: "富山県", 17: "石川県", 18: "福井県", 19: "山梨県", 20: "長野県",
                                          21: "岐阜県", 22: "静岡県", 23: "愛知県", 24: "三重県", 25: "滋賀県", 26: "京都府", 27: "大阪府", 28: "兵庫県", 29: "奈良県", 30: "和歌山県",
                                          31: "鳥取県", 32: "島根県", 33: "岡山県", 34: "広島県", 35: "山口県", 36: "徳島県", 37: "香川県", 38: "愛媛県", 39: "高知県", 40: "福岡県",
                                          41: "佐賀県", 42: "長崎県", 43: "熊本県", 44: "大分県", 45: "宮崎県", 46: "鹿児島県", 47: "沖縄県"]
    static let lessons = [
        "塾に通っている",
        "家庭教師を利用している",
        "通信教育を利用している",
        "何も利用していない"
    ]
    static let subjects: Dictionary = [
        0: "すべて-絞り込み[科目]",
        40: "英語に関する質問",
        43: "日本史に関する質問",
        44: "世界史に関する質問",
        45: "理科に関する質問",
        46: "化学に関する質問",
        47: "物理に関する質問",
        48: "算数に関する質問",
        49: "数学(中学)に関する質問",
        50: "数学(高校)に関する質問",
        51: "国語に関する質問",
        52: "古典に関する質問",
        53: "社会に関する質問",
        212: "その他に関する質問",
        2643: "情報処理に関する質問"
    ]
    static let questionType: Dictionary = [
        1: "全て/ほとんどわかりません",
        2: "1つだけわからないところがあります",
        3: "私の考えはどこがおかしいですか？"
    ]
    // register
    static let id = "id"
    static let masterPrefectureId = "masterPrefectureId"
    static let masterStudyServiceUsageId = "masterStudyServiceUsageId"
    static let email = "email"
    static let privacy = "privacy"
    // password
    static let password = "password"
    static let currentPassword = "current_password"
    static let refreshToken = "refresh_token"
    static let result = "result"
    //先生・家庭教師一覧画面の並び替え
    static let teacherSorts: Dictionary = [
        "new": "新着順",
        "answerCount": "おすすめ順"
    ]
    static let appScheme = "noschool://"
    static let noticeTokenKey = "noticeToken"
    static let baseColor = UIColor(hex: "239348")
    /// カラー管理
    static let colors: Dictionary = [
        "baseGreen": UIColor(hex: "239348"),
        "subGreen": UIColor(hex: "879E70"),
        "doveGray": UIColor(hex: "666666"),
        "dustyGray": UIColor(hex: "999999"),
        "silver": UIColor(hex: "CCCCCC")
    ]
}
