import AppKit

struct PreviewSpec {
    let title: String
    let output: String
    let images: [String]
    let canvasSize: NSSize
    let thumbnailHeight: CGFloat
}

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let assetRoot = root.appendingPathComponent("AppStoreConnectAssets")
let screenshotLocale = ProcessInfo.processInfo.environment["APP_STORE_SCREENSHOT_LOCALE"] ?? "ja-JP"
let isEnglishStore = screenshotLocale == "en-US"

let japaneseSpecs = [
    PreviewSpec(
        title: "iPhone screenshots",
        output: "Preview-iPhone.png",
        images: [
            "AppStoreScreenshot-01-Moments.png",
            "AppStoreScreenshot-02-Achievements.png",
            "AppStoreScreenshot-03-Entry.png"
        ],
        canvasSize: NSSize(width: 1920, height: 1440),
        thumbnailHeight: 1120
    ),
    PreviewSpec(
        title: "iPad 13-inch screenshots",
        output: "Preview-iPad13.png",
        images: [
            "iPad13Polished/01-Moments.png",
            "iPad13Polished/02-Achievements.png",
            "iPad13Polished/03-Entry.png"
        ],
        canvasSize: NSSize(width: 2400, height: 1440),
        thumbnailHeight: 1040
    )
]

let englishSpecs = [
    PreviewSpec(
        title: "English iPhone screenshots",
        output: "en-US/Preview-iPhone.png",
        images: [
            "en-US/iPhone/01-Moments.png",
            "en-US/iPhone/02-Achievements.png",
            "en-US/iPhone/03-Entry.png"
        ],
        canvasSize: NSSize(width: 1920, height: 1440),
        thumbnailHeight: 1120
    ),
    PreviewSpec(
        title: "English iPad 13-inch screenshots",
        output: "en-US/Preview-iPad13.png",
        images: [
            "en-US/iPad13/01-Moments.png",
            "en-US/iPad13/02-Achievements.png",
            "en-US/iPad13/03-Entry.png"
        ],
        canvasSize: NSSize(width: 2400, height: 1440),
        thumbnailHeight: 1040
    )
]

let specs = isEnglishStore ? englishSpecs : japaneseSpecs

func color(_ red: Int, _ green: Int, _ blue: Int, alpha: CGFloat = 1) -> NSColor {
    NSColor(
        calibratedRed: CGFloat(red) / 255,
        green: CGFloat(green) / 255,
        blue: CGFloat(blue) / 255,
        alpha: alpha
    )
}

func roundedFont(ofSize size: CGFloat, weight: NSFont.Weight) -> NSFont {
    let base = NSFont.systemFont(ofSize: size, weight: weight)
    guard let roundedDescriptor = base.fontDescriptor.withDesign(.rounded) else {
        return base
    }
    return NSFont(descriptor: roundedDescriptor, size: size) ?? base
}

func drawText(_ text: String, in rect: NSRect, font: NSFont, color: NSColor, alignment: NSTextAlignment = .center) {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = alignment
    paragraph.lineBreakMode = .byWordWrapping

    text.draw(
        with: rect,
        options: [.usesLineFragmentOrigin, .usesFontLeading],
        attributes: [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraph
        ]
    )
}

func drawRoundedRect(_ rect: NSRect, radius: CGFloat, fill: NSColor) {
    let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
    fill.setFill()
    path.fill()
}

func drawShadowedImage(_ image: NSImage, in rect: NSRect) {
    NSGraphicsContext.current?.saveGraphicsState()
    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.18)
    shadow.shadowBlurRadius = 28
    shadow.shadowOffset = NSSize(width: 0, height: -10)
    shadow.set()
    drawRoundedRect(rect.insetBy(dx: -2, dy: -2), radius: 18, fill: .white)
    NSGraphicsContext.current?.restoreGraphicsState()

    image.draw(in: rect)
}

for spec in specs {
    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(spec.canvasSize.width),
        pixelsHigh: Int(spec.canvasSize.height),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    ) else {
        fatalError("Could not create bitmap for \(spec.output)")
    }
    bitmap.size = spec.canvasSize

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)

    let canvas = NSRect(origin: .zero, size: spec.canvasSize)
    let gradient = NSGradient(colors: [
        color(250, 253, 255),
        color(255, 244, 232)
    ])
    gradient?.draw(in: canvas, angle: 90)

    drawText(
        spec.title,
        in: NSRect(x: 80, y: spec.canvasSize.height - 164, width: spec.canvasSize.width - 160, height: 86),
        font: roundedFont(ofSize: 54, weight: .bold),
        color: color(22, 28, 33)
    )

    let loadedImages = spec.images.map { relativePath -> NSImage in
        let url = assetRoot.appendingPathComponent(relativePath)
        guard let image = NSImage(contentsOf: url) else {
            fatalError("Missing image: \(relativePath)")
        }
        return image
    }

    let thumbnailSizes = loadedImages.map { image -> NSSize in
        let scale = spec.thumbnailHeight / image.size.height
        return NSSize(width: image.size.width * scale, height: spec.thumbnailHeight)
    }
    let gap: CGFloat = 46
    let totalWidth = thumbnailSizes.reduce(CGFloat(0)) { $0 + $1.width } + gap * CGFloat(thumbnailSizes.count - 1)
    var x = (spec.canvasSize.width - totalWidth) / 2
    let y: CGFloat = 112

    for (image, size) in zip(loadedImages, thumbnailSizes) {
        drawShadowedImage(image, in: NSRect(x: x, y: y, width: size.width, height: size.height))
        x += size.width + gap
    }

    NSGraphicsContext.restoreGraphicsState()

    guard let png = bitmap.representation(using: .png, properties: [:]) else {
        fatalError("Could not create PNG for \(spec.output)")
    }
    let outputURL = assetRoot.appendingPathComponent(spec.output)
    try FileManager.default.createDirectory(at: outputURL.deletingLastPathComponent(), withIntermediateDirectories: true)
    try png.write(to: outputURL)
}
