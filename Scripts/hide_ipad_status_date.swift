import AppKit

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let screenshotLocale = ProcessInfo.processInfo.environment["APP_STORE_SCREENSHOT_LOCALE"] ?? "ja-JP"
let isEnglishStore = screenshotLocale == "en-US"
let sourceRoot = root.appendingPathComponent(isEnglishStore ? "AppStoreConnectAssets/en-US/iPad13Source" : "AppStoreConnectAssets/iPad13")
let imageURLs = [
    sourceRoot.appendingPathComponent("01-Moments.png"),
    sourceRoot.appendingPathComponent("02-Achievements.png"),
    sourceRoot.appendingPathComponent("03-Entry.png")
]

struct Pixel {
    let red: UInt8
    let green: UInt8
    let blue: UInt8
    let alpha: UInt8
}

func backgroundPixel(for imageURL: URL) -> Pixel {
    guard
        let data = try? Data(contentsOf: imageURL),
        let rep = NSBitmapImageRep(data: data),
        let sourceData = rep.bitmapData
    else {
        return Pixel(red: 255, green: 255, blue: 255, alpha: 255)
    }

    let offset = 20 * rep.bytesPerRow + 20 * 4
    return Pixel(
        red: sourceData[offset],
        green: sourceData[offset + 1],
        blue: sourceData[offset + 2],
        alpha: sourceData[offset + 3]
    )
}

func hideStatusDate(in imageURL: URL) throws {
    guard let image = NSImage(contentsOf: imageURL) else {
        fatalError("Missing image: \(imageURL.path)")
    }

    let width = Int(image.size.width)
    let height = Int(image.size.height)
    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: width,
        pixelsHigh: height,
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    ) else {
        fatalError("Could not create bitmap for \(imageURL.lastPathComponent)")
    }
    bitmap.size = image.size

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
    image.draw(in: NSRect(origin: .zero, size: image.size))

    let fillPixel = backgroundPixel(for: imageURL)
    if let destinationData = bitmap.bitmapData {
        for y in 6..<72 {
            for x in 122..<394 {
                let offset = y * bitmap.bytesPerRow + x * 4
                destinationData[offset] = fillPixel.red
                destinationData[offset + 1] = fillPixel.green
                destinationData[offset + 2] = fillPixel.blue
                destinationData[offset + 3] = fillPixel.alpha
            }
        }
    }
    NSGraphicsContext.restoreGraphicsState()

    guard let png = bitmap.representation(using: .png, properties: [:]) else {
        fatalError("Could not create PNG for \(imageURL.lastPathComponent)")
    }
    try png.write(to: imageURL)
}

for imageURL in imageURLs {
    try hideStatusDate(in: imageURL)
}
