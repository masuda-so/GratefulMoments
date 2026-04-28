//
//  MomentExporter.swift
//  GratefulMoments
//
//  Created by Codex on 2026/04/28.
//

import Foundation
import SwiftUI
import UIKit

enum MomentExportFormat: String, CaseIterable, Identifiable {
    case pdf
    case csv
    
    var id: String {
        rawValue
    }
    
    var title: LocalizedStringResource {
        switch self {
        case .pdf:
            return "PDF"
        case .csv:
            return "CSV"
        }
    }
    
    var fileExtension: String {
        rawValue
    }
}

struct ExportedMomentFile: Identifiable {
    let id = UUID()
    let url: URL
}

enum MomentExporter {
    static func export(moments: [Moment], format: MomentExportFormat) throws -> URL {
        let sortedMoments = moments.sorted { $0.timestamp < $1.timestamp }
        let url = try exportURL(for: format)
        
        switch format {
        case .pdf:
            try writePDF(moments: sortedMoments, to: url)
        case .csv:
            try writeCSV(moments: sortedMoments, to: url)
        }
        
        return url
    }
    
    private static func exportURL(for format: MomentExportFormat) throws -> URL {
        let directory = FileManager.default.temporaryDirectory.appending(
            path: "GratefulMomentsExports",
            directoryHint: .isDirectory
        )
        try FileManager.default.createDirectory(
            at: directory,
            withIntermediateDirectories: true
        )
        
        let timestamp = ISO8601DateFormatter()
            .string(from: .now)
            .replacingOccurrences(of: ":", with: "-")
        return directory.appending(
            path: "GratefulMoments-\(timestamp).\(format.fileExtension)"
        )
    }
    
    private static func writeCSV(moments: [Moment], to url: URL) throws {
        var rows = [
            ["Date", "Title", "Note", "Has Photo"].map(csvField).joined(separator: ",")
        ]
        
        for moment in moments {
            let date = ISO8601DateFormatter().string(from: moment.timestamp)
            let row = [
                date,
                moment.title,
                moment.note,
                moment.imageData == nil ? "No" : "Yes"
            ].map(csvField).joined(separator: ",")
            rows.append(row)
        }
        
        try rows
            .joined(separator: "\n")
            .write(to: url, atomically: true, encoding: .utf8)
    }
    
    private nonisolated static func csvField(_ value: String) -> String {
        "\"\(value.replacingOccurrences(of: "\"", with: "\"\""))\""
    }
    
    private static func writePDF(moments: [Moment], to url: URL) throws {
        let pageBounds = CGRect(x: 0, y: 0, width: 612, height: 792)
        let renderer = UIGraphicsPDFRenderer(bounds: pageBounds)
        
        try renderer.writePDF(to: url) { context in
            if moments.isEmpty {
                context.beginPage()
                drawHeader("GratefulMoments", in: pageBounds)
                drawBodyText("No moments yet.", y: 104, in: pageBounds)
                return
            }
            
            for (index, moment) in moments.enumerated() {
                context.beginPage()
                drawMoment(moment, number: index + 1, in: pageBounds)
            }
        }
    }
    
    private static func drawMoment(_ moment: Moment, number: Int, in pageBounds: CGRect) {
        let margin: CGFloat = 48
        let contentWidth = pageBounds.width - margin * 2
        var y = margin
        
        drawHeader("GratefulMoments", in: pageBounds)
        y += 56
        
        let date = moment.timestamp.formatted(date: .abbreviated, time: .omitted)
        drawText(
            "#\(number)  \(date)",
            y: y,
            width: contentWidth,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .subheadline),
                .foregroundColor: UIColor.secondaryLabel
            ]
        )
        y += 28
        
        y += drawText(
            moment.title,
            y: y,
            width: contentWidth,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .title2),
                .foregroundColor: UIColor.label
            ]
        ) + 16
        
        if !moment.note.isEmpty {
            y += drawText(
                moment.note,
                y: y,
                width: contentWidth,
                attributes: [
                    .font: UIFont.preferredFont(forTextStyle: .body),
                    .foregroundColor: UIColor.label
                ]
            ) + 20
        }
        
        if let image = moment.image {
            drawImage(image, y: y, width: contentWidth, pageBounds: pageBounds)
        }
    }
    
    private static func drawHeader(_ text: String, in pageBounds: CGRect) {
        drawText(
            text,
            y: 40,
            width: pageBounds.width - 96,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .headline),
                .foregroundColor: UIColor.systemOrange
            ]
        )
    }
    
    @discardableResult
    private static func drawBodyText(_ text: String, y: CGFloat, in pageBounds: CGRect) -> CGFloat {
        drawText(
            text,
            y: y,
            width: pageBounds.width - 96,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .body),
                .foregroundColor: UIColor.label
            ]
        )
    }
    
    @discardableResult
    private static func drawText(
        _ text: String,
        y: CGFloat,
        width: CGFloat,
        attributes: [NSAttributedString.Key: Any]
    ) -> CGFloat {
        let rect = CGRect(x: 48, y: y, width: width, height: 600)
        let height = (text as NSString).boundingRect(
            with: rect.size,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        ).height.rounded(.up)
        
        (text as NSString).draw(
            with: CGRect(x: rect.minX, y: rect.minY, width: width, height: height),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        
        return height
    }
    
    private static func drawImage(
        _ image: UIImage,
        y: CGFloat,
        width: CGFloat,
        pageBounds: CGRect
    ) {
        let maxHeight = min(CGFloat(300), pageBounds.maxY - y - 48)
        guard maxHeight > 80 else { return }
        
        let scale = min(width / image.size.width, maxHeight / image.size.height)
        let imageSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let rect = CGRect(x: 48, y: y, width: imageSize.width, height: imageSize.height)
        image.draw(in: rect)
    }
}
