import AppKit
import Foundation

let args = CommandLine.arguments
guard args.count >= 3 else { fputs("usage: frame_ipad <inDir> <outDir>\n", stderr); exit(1) }
let inDir = URL(fileURLWithPath: args[1])
let outDir = URL(fileURLWithPath: args[2])
try? FileManager.default.createDirectory(at: outDir, withIntermediateDirectories: true)

let canvasW: CGFloat = 2064, canvasH: CGFloat = 2752
let screenW: CGFloat = 1640, screenH: CGFloat = 2187   // preserves iPad 0.75 aspect
let screenX = (canvasW - screenW) / 2
let screenY = (canvasH - screenH) / 2
let framePad: CGFloat = 34
let frameRadius: CGFloat = 116
let screenRadius: CGFloat = 84

let files = ((try? FileManager.default.contentsOfDirectory(at: inDir, includingPropertiesForKeys: nil)) ?? [])
    .filter { $0.pathExtension.lowercased() == "png" }
    .sorted { $0.lastPathComponent < $1.lastPathComponent }

for file in files {
    guard let src = NSImage(contentsOf: file) else { fputs("skip \(file.lastPathComponent)\n", stderr); continue }
    guard let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(canvasW), pixelsHigh: Int(canvasH),
        bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
        colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0) else { continue }
    rep.size = NSSize(width: canvasW, height: canvasH)

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)

    // plain background
    NSColor(calibratedRed: 233/255, green: 240/255, blue: 245/255, alpha: 1).setFill()
    NSBezierPath(rect: NSRect(x: 0, y: 0, width: canvasW, height: canvasH)).fill()

    let frameRect = NSRect(x: screenX - framePad, y: screenY - framePad,
                           width: screenW + framePad * 2, height: screenH + framePad * 2)

    // device frame with soft shadow
    NSGraphicsContext.saveGraphicsState()
    let shadow = NSShadow()
    shadow.shadowColor = NSColor(white: 0, alpha: 0.28)
    shadow.shadowOffset = NSSize(width: 0, height: -18)
    shadow.shadowBlurRadius = 44
    shadow.set()
    NSColor(calibratedRed: 14/255, green: 16/255, blue: 18/255, alpha: 1).setFill()
    NSBezierPath(roundedRect: frameRect, xRadius: frameRadius, yRadius: frameRadius).fill()
    NSGraphicsContext.restoreGraphicsState()

    // inner bezel ring
    let bezel = NSBezierPath(roundedRect: frameRect.insetBy(dx: 9, dy: 9), xRadius: frameRadius - 9, yRadius: frameRadius - 9)
    NSColor(calibratedRed: 72/255, green: 74/255, blue: 76/255, alpha: 1).setStroke()
    bezel.lineWidth = 7
    bezel.stroke()

    // screen, clipped to rounded rect
    let screenRect = NSRect(x: screenX, y: screenY, width: screenW, height: screenH)
    NSGraphicsContext.saveGraphicsState()
    NSBezierPath(roundedRect: screenRect, xRadius: screenRadius, yRadius: screenRadius).addClip()
    src.draw(in: screenRect, from: .zero, operation: .copy, fraction: 1.0)
    NSGraphicsContext.restoreGraphicsState()

    NSGraphicsContext.restoreGraphicsState()

    let outURL = outDir.appendingPathComponent(file.lastPathComponent)
    if let data = rep.representation(using: .png, properties: [:]) {
        try? data.write(to: outURL)
        print("framed: \(file.lastPathComponent)")
    }
}
