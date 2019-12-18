
import Cocoa
import Foundation

class CallBackFunctions {
    static var CAPSLOCK = false
    static var calander = Calendar.current
    static var prev = ""

    static let Handle_DeviceMatchingCallback: IOHIDDeviceCallback = { _, _, _, _ in
    }

    static let Handle_DeviceRemovalCallback: IOHIDDeviceCallback = { _, _, _, _ in
    }

    static let Handle_IOHIDInputValueCallback: IOHIDValueCallback = { context, _, _, device in

        let mySelf = Unmanaged<TypingDetector>.fromOpaque(context!).takeUnretainedValue()
        let elem: IOHIDElement = IOHIDValueGetElement(device)
        var test: Bool
        if IOHIDElementGetUsagePage(elem) != 0x07 {
            return
        }
        let scancode = IOHIDElementGetUsage(elem)
        if scancode < 4 || scancode > 231 {
            return
        }
        let pressed = IOHIDValueGetIntegerValue(device)

        Outside: if pressed == 1 {
            if scancode == 57 {
                CallBackFunctions.CAPSLOCK = !CallBackFunctions.CAPSLOCK
                break Outside
            }
            if scancode >= 224, scancode <= 231 {
                // Original used to save to file here. Other than these places, it'll result in multiple calls.

                print("KEYDOWN")
                fflush(__stdoutp)

                break Outside
            }
            if CallBackFunctions.CAPSLOCK {
                // Original used to save to file here. Other than these places, it'll result in multiple calls.

                print("KEYDOWN")
                fflush(__stdoutp)

            } else {
                // Original used to save to file here. Other than these places, it'll result in multiple calls.

                print("KEYDOWN")
                fflush(__stdoutp)
            }
        } else {
            if scancode >= 224, scancode <= 231 {
                // Original used to save to file here. Other than these places, it'll result in multiple calls.

                print("KEYDOWN")
                fflush(__stdoutp) // In order for node to get it.
            }
        }
    }
}