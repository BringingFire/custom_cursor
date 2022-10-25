import Cocoa
import FlutterMacOS

let mimeTextPlain = "text/plain"
let mimeTextHtml = "text/html"

public class CustomCursorPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.bringingfire.custom_cursor", binaryMessenger: registrar.messenger)
        let instance = CustomCursorPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    var cursors: [String: NSCursor] = [:]

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "register":
            let args = call.arguments as! [String: Any]
            let name = args["name"] as! String
            let image = (args["image"] as! FlutterStandardTypedData).data
            let hotSpotDict = args["hotSpot"] as! [String: Int]
            let hotSpot = NSPoint(x: hotSpotDict["x"]!, y: hotSpotDict["y"]!)
            register(name, image, hotSpot)
            result(nil)
        case "isRegistered":
            result(isRegistered(call.arguments as! String))
        case "showCursor":
            showCursor(call.arguments as! String)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func register(_ name: String, _ imageData: Data, _ hotSpot: NSPoint) {
        guard let image = NSImage(data: imageData) else {
            return
        }
        let cursor = NSCursor(image: image, hotSpot: hotSpot)
        cursors[name] = cursor
    }

    public func isRegistered(_ name: String) -> Bool {
        cursors[name] != nil
    }

    public func showCursor(_ name: String) {
        cursors[name]?.set()
        NSCursor.unhide()
    }
}
