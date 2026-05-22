import AppKit

struct IPadScreenshotSpec {
    let source: String
    let output: String
    let kicker: String
    let headline: [String]
    let subheadline: String
    let theme: IPadScreenshotTheme
}

struct IPadScreenshotTheme {
    let backgroundTop: NSColor
    let backgroundBottom: NSColor
    let accent: NSColor
    let secondary: NSColor
    let tertiary: NSColor
    let text: NSColor
    let softText: NSColor
}

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let assetRoot = root.appendingPathComponent("AppStoreConnectAssets")
let screenshotLocale = ProcessInfo.processInfo.environment["APP_STORE_SCREENSHOT_LOCALE"] ?? "ja-JP"
let isEnglishStore = screenshotLocale == "en-US"
let sourceRoot = assetRoot.appendingPathComponent(isEnglishStore ? "en-US/iPad13Source" : "iPad13")
let outputRoot = assetRoot.appendingPathComponent(isEnglishStore ? "en-US/iPad13" : "iPad13Polished")

try FileManager.default.createDirectory(at: outputRoot, withIntermediateDirectories: true)

func color(_ red: Int, _ green: Int, _ blue: Int, alpha: CGFloat = 1) -> NSColor {
    NSColor(
        calibratedRed: CGFloat(red) / 255,
        green: CGFloat(green) / 255,
        blue: CGFloat(blue) / 255,
        alpha: alpha
    )
}

let japaneseSpecs = [
    IPadScreenshotSpec(
        source: "01-Moments.png",
        output: "01-Moments.png",
        kicker: "TODAY'S MOMENTS",
        headline: ["今日の幸せを", "大きく眺めよう。"],
        subheadline: "写真と一緒に、ありがとうが増えていく。",
        theme: IPadScreenshotTheme(
            backgroundTop: color(255, 241, 227),
            backgroundBottom: color(230, 250, 253),
            accent: color(255, 122, 0),
            secondary: color(26, 138, 210),
            tertiary: color(255, 67, 121),
            text: color(22, 24, 28),
            softText: color(61, 70, 78)
        )
    ),
    IPadScreenshotSpec(
        source: "02-Achievements.png",
        output: "02-Achievements.png",
        kicker: "KEEP GOING",
        headline: ["達成が見えると", "また書きたくなる。"],
        subheadline: "バッジと連続記録が、習慣を明るくする。",
        theme: IPadScreenshotTheme(
            backgroundTop: color(255, 242, 248),
            backgroundBottom: color(238, 248, 255),
            accent: color(232, 75, 93),
            secondary: color(255, 122, 0),
            tertiary: color(31, 140, 208),
            text: color(22, 24, 28),
            softText: color(61, 70, 78)
        )
    ),
    IPadScreenshotSpec(
        source: "03-Entry.png",
        output: "03-Entry.png",
        kicker: "CAPTURE THE FEELING",
        headline: ["うれしい瞬間を", "逃さない。"],
        subheadline: "iPadでも、写真と言葉をすぐに保存。",
        theme: IPadScreenshotTheme(
            backgroundTop: color(238, 255, 249),
            backgroundBottom: color(255, 242, 224),
            accent: color(255, 122, 0),
            secondary: color(36, 151, 118),
            tertiary: color(255, 67, 121),
            text: color(22, 24, 28),
            softText: color(61, 70, 78)
        )
    )
]

let englishSpecs = [
    IPadScreenshotSpec(
        source: "01-Moments.png",
        output: "01-Moments.png",
        kicker: "TODAY'S MOMENTS",
        headline: ["See your gratitude", "grow."],
        subheadline: "A wider canvas for everyday thanks.",
        theme: japaneseSpecs[0].theme
    ),
    IPadScreenshotSpec(
        source: "02-Achievements.png",
        output: "02-Achievements.png",
        kicker: "KEEP GOING",
        headline: ["Turn progress", "into momentum."],
        subheadline: "Streaks and badges keep your habit visible.",
        theme: japaneseSpecs[1].theme
    ),
    IPadScreenshotSpec(
        source: "03-Entry.png",
        output: "03-Entry.png",
        kicker: "CAPTURE THE FEELING",
        headline: ["Capture a", "grateful moment."],
        subheadline: "Add a note and photo from iPad, too.",
        theme: japaneseSpecs[2].theme
    )
]

let specs = isEnglishStore ? englishSpecs : japaneseSpecs

let canvasSize = NSSize(width: 2064, height: 2752)
let deviceRect = NSRect(x: 282, y: 106, width: 1500, height: 2000)
let deviceRadius: CGFloat = 74
let screenInset: CGFloat = 14
func drawText(_ text: String, in rect: NSRect, font: NSFont, color: NSColor, alignment: NSTextAlignment = .center) {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = alignment
    paragraph.lineBreakMode = .byWordWrapping
    paragraph.lineSpacing = 12

    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: color,
        .paragraphStyle: paragraph
    ]
    text.draw(with: rect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes)
}

func drawShadowedText(_ text: String, in rect: NSRect, font: NSFont, color: NSColor, alignment: NSTextAlignment = .center) {
    NSGraphicsContext.current?.saveGraphicsState()
    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.28)
    shadow.shadowBlurRadius = 20
    shadow.shadowOffset = NSSize(width: 0, height: -6)
    shadow.set()
    drawText(text, in: rect, font: font, color: color, alignment: alignment)
    NSGraphicsContext.current?.restoreGraphicsState()
}

func roundedFont(ofSize size: CGFloat, weight: NSFont.Weight) -> NSFont {
    let base = NSFont.systemFont(ofSize: size, weight: weight)
    guard let roundedDescriptor = base.fontDescriptor.withDesign(.rounded) else {
        return base
    }
    return NSFont(descriptor: roundedDescriptor, size: size) ?? base
}

func drawRoundedRect(_ rect: NSRect, radius: CGFloat, fill: NSColor) {
    let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
    fill.setFill()
    path.fill()
}

func drawOval(_ rect: NSRect, fill: NSColor) {
    let path = NSBezierPath(ovalIn: rect)
    fill.setFill()
    path.fill()
}

func drawRoundedRect(_ rect: NSRect, radius: CGFloat, fill: NSColor, stroke: NSColor, lineWidth: CGFloat) {
    let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
    fill.setFill()
    path.fill()
    path.lineWidth = lineWidth
    stroke.setStroke()
    path.stroke()
}

func drawPolygon(_ points: [NSPoint], fill: NSColor) {
    guard let first = points.first else {
        return
    }

    let path = NSBezierPath()
    path.move(to: first)
    points.dropFirst().forEach { path.line(to: $0) }
    path.close()
    fill.setFill()
    path.fill()
}

func hexagonPath(center: NSPoint, radius: CGFloat) -> NSBezierPath {
    let path = NSBezierPath()

    for index in 0..<6 {
        let angle = CGFloat.pi / 6 + CGFloat(index) * CGFloat.pi / 3
        let point = NSPoint(
            x: center.x + cos(angle) * radius,
            y: center.y + sin(angle) * radius
        )

        if index == 0 {
            path.move(to: point)
        } else {
            path.line(to: point)
        }
    }

    path.close()
    return path
}

func drawHexagonOutline(center: NSPoint, radius: CGFloat, color: NSColor, lineWidth: CGFloat) {
    let path = hexagonPath(center: center, radius: radius)
    path.lineWidth = lineWidth
    color.setStroke()
    path.stroke()
}

func drawBackground(theme: IPadScreenshotTheme) {
    let canvas = NSRect(origin: .zero, size: canvasSize)
    let gradient = NSGradient(colors: [
        theme.backgroundBottom,
        theme.backgroundTop
    ])
    gradient?.draw(in: canvas, angle: 90)

    drawPolygon([
        NSPoint(x: -240, y: 520),
        NSPoint(x: canvasSize.width + 260, y: 900),
        NSPoint(x: canvasSize.width + 240, y: 1550),
        NSPoint(x: -240, y: 1190)
    ], fill: theme.accent.withAlphaComponent(0.13))

    drawPolygon([
        NSPoint(x: -220, y: 900),
        NSPoint(x: canvasSize.width + 220, y: 1180),
        NSPoint(x: canvasSize.width + 220, y: 1470),
        NSPoint(x: -220, y: 1210)
    ], fill: NSColor.white.withAlphaComponent(0.36))

    drawPolygon([
        NSPoint(x: -240, y: 1380),
        NSPoint(x: canvasSize.width + 240, y: 1110),
        NSPoint(x: canvasSize.width + 240, y: 760),
        NSPoint(x: -240, y: 1010)
    ], fill: theme.secondary.withAlphaComponent(0.10))

    drawPolygon([
        NSPoint(x: -220, y: 1760),
        NSPoint(x: canvasSize.width + 220, y: 1530),
        NSPoint(x: canvasSize.width + 220, y: 1260),
        NSPoint(x: -220, y: 1440)
    ], fill: theme.tertiary.withAlphaComponent(0.08))

    drawHexagonOutline(
        center: NSPoint(x: 1842, y: 2238),
        radius: 150,
        color: theme.tertiary.withAlphaComponent(0.14),
        lineWidth: 10
    )
    drawHexagonOutline(
        center: NSPoint(x: 1790, y: 456),
        radius: 184,
        color: theme.secondary.withAlphaComponent(0.12),
        lineWidth: 12
    )

    let topWash = NSGradient(colors: [
        NSColor.white.withAlphaComponent(0.54),
        NSColor.white.withAlphaComponent(0.0)
    ])
    topWash?.draw(in: NSRect(x: 0, y: 2056, width: canvasSize.width, height: 696), angle: 90)
}

func drawAccentRule(theme: IPadScreenshotTheme) {
    let ruleRect = NSRect(x: 817, y: 2130, width: 430, height: 12)
    drawRoundedRect(ruleRect, radius: 5, fill: theme.accent)
}

func drawKicker(_ text: String, theme: IPadScreenshotTheme) {
    let rect = NSRect(x: 672, y: 2532, width: 720, height: 60)
    drawRoundedRect(
        rect,
        radius: 30,
        fill: NSColor.white.withAlphaComponent(0.74),
        stroke: theme.accent.withAlphaComponent(0.22),
        lineWidth: 2
    )
    drawText(
        text,
        in: NSRect(x: rect.minX + 36, y: rect.minY + 14, width: rect.width - 72, height: 32),
        font: roundedFont(ofSize: 24, weight: .bold),
        color: theme.softText
    )
}

func drawDeviceStage(in rect: NSRect, theme: IPadScreenshotTheme) {
    let backPlate = rect.insetBy(dx: -34, dy: -30)
    NSGraphicsContext.current?.saveGraphicsState()
    let shadow = NSShadow()
    shadow.shadowColor = theme.secondary.withAlphaComponent(0.20)
    shadow.shadowBlurRadius = 36
    shadow.shadowOffset = NSSize(width: 0, height: -18)
    shadow.set()
    drawRoundedRect(backPlate, radius: deviceRadius + 22, fill: NSColor.white.withAlphaComponent(0.48))
    NSGraphicsContext.current?.restoreGraphicsState()
}

func drawDeviceFrame(in rect: NSRect, image: NSImage) {
    NSGraphicsContext.current?.saveGraphicsState()
    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.22)
    shadow.shadowBlurRadius = 52
    shadow.shadowOffset = NSSize(width: 0, height: -18)
    shadow.set()

    drawRoundedRect(rect, radius: deviceRadius, fill: .black)
    NSGraphicsContext.current?.restoreGraphicsState()

    let screenRect = rect.insetBy(dx: screenInset, dy: screenInset)
    let screenPath = NSBezierPath(
        roundedRect: screenRect,
        xRadius: deviceRadius - screenInset,
        yRadius: deviceRadius - screenInset
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
    let sourceURL = sourceRoot.appendingPathComponent(spec.source)

    guard let sourceImage = NSImage(contentsOf: sourceURL) else {
        fatalError("Missing source image: \(spec.source)")
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

    drawBackground(theme: spec.theme)
    drawKicker(spec.kicker, theme: spec.theme)
    drawDeviceStage(in: deviceRect, theme: spec.theme)
    drawDeviceFrame(in: deviceRect, image: sourceImage)
    drawText(
        spec.headline.joined(separator: "\n"),
        in: NSRect(x: 156, y: 2266, width: 1752, height: 250),
        font: roundedFont(ofSize: 90, weight: .heavy),
        color: spec.theme.text
    )
    drawText(
        spec.subheadline,
        in: NSRect(x: 220, y: 2162, width: 1624, height: 72),
        font: roundedFont(ofSize: 42, weight: .bold),
        color: spec.theme.softText
    )
    drawAccentRule(theme: spec.theme)

    NSGraphicsContext.restoreGraphicsState()

    guard let png = bitmap.representation(using: .png, properties: [:]) else {
        fatalError("Could not create PNG for \(spec.output)")
    }
    try png.write(to: outputRoot.appendingPathComponent(spec.output))
}
