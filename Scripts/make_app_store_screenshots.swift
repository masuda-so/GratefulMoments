import AppKit

struct ScreenshotSpec {
    let sourceFolder: String
    let source: String
    let output: String
    let headline: [String]
}

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let outputRoot = root.appendingPathComponent("AppStoreConnectAssets")

let specs = [
    ScreenshotSpec(
        sourceFolder: "SourceScreensSample",
        source: "01-Moments.png",
        output: "AppStoreScreenshot-01-Moments.png",
        headline: ["ありがとうが", "続く日記。"]
    ),
    ScreenshotSpec(
        sourceFolder: "SourceScreensSample",
        source: "02-Achievements.png",
        output: "AppStoreScreenshot-02-Achievements.png",
        headline: ["達成バッジで", "習慣が見える。"]
    ),
    ScreenshotSpec(
        sourceFolder: "SourceScreens",
        source: "03-Create.png",
        output: "AppStoreScreenshot-03-Entry.png",
        headline: ["写真を添えて", "すぐに記録。"]
    )
]

let canvasSize = NSSize(width: 1242, height: 2688)
let phoneRect = NSRect(x: 98, y: -438, width: 1046, height: 2240)
let phoneRadius: CGFloat = 132
let screenInset: CGFloat = 22

func drawText(_ text: String, in rect: NSRect, font: NSFont, color: NSColor, alignment: NSTextAlignment = .center) {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = alignment
    paragraph.lineBreakMode = .byWordWrapping
    paragraph.lineSpacing = 6

    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: color,
        .paragraphStyle: paragraph
    ]
    text.draw(with: rect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes)
}

func drawRoundedRect(_ rect: NSRect, radius: CGFloat, fill: NSColor) {
    let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
    fill.setFill()
    path.fill()
}

func drawBackground() {
    let canvas = NSRect(origin: .zero, size: canvasSize)
    let gradient = NSGradient(colors: [
        NSColor(calibratedRed: 0.87, green: 0.98, blue: 1.00, alpha: 1.0),
        NSColor(calibratedRed: 0.78, green: 0.96, blue: 1.00, alpha: 1.0)
    ])
    gradient?.draw(in: canvas, angle: 90)

    let softHighlight = NSGradient(colors: [
        NSColor.white.withAlphaComponent(0.62),
        NSColor.white.withAlphaComponent(0.0)
    ])
    softHighlight?.draw(
        in: NSRect(x: -180, y: -140, width: 920, height: 720),
        relativeCenterPosition: NSPoint(x: -0.25, y: -0.2)
    )
}

func drawDeviceFrame(in rect: NSRect, image: NSImage) {
    NSGraphicsContext.current?.saveGraphicsState()
    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.13)
    shadow.shadowBlurRadius = 28
    shadow.shadowOffset = NSSize(width: 0, height: -8)
    shadow.set()

    drawRoundedRect(rect, radius: phoneRadius, fill: .black)
    NSGraphicsContext.current?.restoreGraphicsState()

    let screenRect = rect.insetBy(dx: screenInset, dy: screenInset)
    let screenPath = NSBezierPath(
        roundedRect: screenRect,
        xRadius: phoneRadius - screenInset,
        yRadius: phoneRadius - screenInset
    )

    NSGraphicsContext.current?.saveGraphicsState()
    screenPath.addClip()
    NSColor.white.setFill()
    screenRect.fill()

    let imageSize = image.size
    let scale = max(screenRect.width / imageSize.width, screenRect.height / imageSize.height)
    let drawSize = NSSize(width: imageSize.width * scale, height: imageSize.height * scale)
    let drawRect = NSRect(
        x: screenRect.midX - drawSize.width / 2,
        y: screenRect.maxY - drawSize.height,
        width: drawSize.width,
        height: drawSize.height
    )
    image.draw(in: drawRect)
    NSGraphicsContext.current?.restoreGraphicsState()
}

for spec in specs {
    let sourceURL = root
        .appendingPathComponent("AppStoreConnectAssets")
        .appendingPathComponent(spec.sourceFolder)
        .appendingPathComponent(spec.source)

    guard let sourceImage = NSImage(contentsOf: sourceURL) else {
        fatalError("Missing source image: \(spec.sourceFolder)/\(spec.source)")
    }

    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(canvasSize.width),
        pixelsHigh: Int(canvasSize.height),
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
    bitmap.size = canvasSize

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)

    drawBackground()

    drawText(
        spec.headline.joined(separator: "\n"),
        in: NSRect(x: 86, y: 2208, width: 1070, height: 300),
        font: NSFont.systemFont(ofSize: 90, weight: .regular),
        color: .black
    )

    drawDeviceFrame(in: phoneRect, image: sourceImage)

    NSGraphicsContext.restoreGraphicsState()

    guard let png = bitmap.representation(using: .png, properties: [:]) else {
        fatalError("Could not create PNG for \(spec.output)")
    }
    try png.write(to: outputRoot.appendingPathComponent(spec.output))
}
