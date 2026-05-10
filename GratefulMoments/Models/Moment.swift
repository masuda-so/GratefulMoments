//
//  Moment.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/04/17.
//

import Foundation
import SwiftData
import UIKit

@Model
class Moment {
    var title: String
    var note: String
    var imageData: Data?
    var timestamp: Date
    
    var badges: [Badge]
    
    init(title: String, note: String, imageData: Data? = nil, timestamp: Date = .now) {
        self.title = title
        self.note = note
        self.imageData = imageData
        self.timestamp = timestamp
        self.badges = []
    }
    
    var image: UIImage? {
        imageData.flatMap {
            UIImage(data: $0)
        }
    }
}

extension Moment {
    static let sample = sampleData[0]
    static let longTextSample = sampleData[1]
    static let imageSample = sampleData[4]
    
    static let sampleData = [
        Moment(
            title: "初めてのトマト",
            note: "ベランダで育てたトマトを収穫できた。小さいけれど、ちゃんと甘くてうれしい。"
        ),
        Moment(
            title: "試験を乗り切った",
            note: "化学の試験は難しかったけれど、友だちと一緒に勉強したおかげで落ち着いて解けた。",
            imageData: UIImage(named: "Study")?.pngData()
        ),
        Moment(
            title: "ゆっくり休めた夜",
            note: "忙しい一週間のあと、何もしない時間を過ごせてほっとした。",
            imageData: UIImage(named: "Relax")?.pngData()
        ),
        Moment(
            title: "家族の時間",
            note: ""
        ),
        Moment(
            title: "ライブで元気をもらった",
            note: "大好きな音楽を近くで聴けて、帰り道までずっと楽しい気持ちが続いた。",
            imageData: UIImage(named: "Concert")?.pngData()
        )
    ]
}
