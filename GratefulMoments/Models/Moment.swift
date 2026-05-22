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
    static var sample: Moment { sampleData[0] }
    static var longTextSample: Moment { sampleData[1] }
    static var imageSample: Moment { sampleData[4] }
    
    static var sampleData: [Moment] {
        [
            Moment(
                title: String(localized: "First Tomato", comment: "Sample moment title."),
                note: String(
                    localized: "I harvested tomatoes from the balcony. They were small, sweet, and made me smile.",
                    comment: "Sample moment note."
                )
            ),
            Moment(
                title: String(localized: "Made it through the exam", comment: "Sample moment title."),
                note: String(
                    localized: "Chemistry was tough, but studying with friends helped me stay calm and do my best.",
                    comment: "Sample moment note."
                ),
                imageData: UIImage(named: "Study")?.pngData()
            ),
            Moment(
                title: String(localized: "A restful night", comment: "Sample moment title."),
                note: String(
                    localized: "After a busy week, it felt good to spend an evening doing absolutely nothing.",
                    comment: "Sample moment note."
                ),
                imageData: UIImage(named: "Relax")?.pngData()
            ),
            Moment(
                title: String(localized: "Family time", comment: "Sample moment title."),
                note: ""
            ),
            Moment(
                title: String(localized: "Lifted by live music", comment: "Sample moment title."),
                note: String(
                    localized: "Hearing my favorite songs up close kept me smiling the whole way home.",
                    comment: "Sample moment note."
                ),
                imageData: UIImage(named: "Concert")?.pngData()
            )
        ]
    }
}
