
import Cocoa
import Foundation
import IOKit.hid

class TypingDetector {
    var manager: IOHIDManager
    var deviceList = NSArray() // Used in multiple matching dictionary
    var bundlePathURL = Bundle.main.bundleURL // Path to where the executable is present - Change this to use custom path

    init() {
        manager = IOHIDManagerCreate(kCFAllocatorDefault, IOOptionBits(kIOHIDOptionsTypeNone))

        if CFGetTypeID(manager) != IOHIDManagerGetTypeID() {
            print("Can't create manager")
            exit(1)
        }
        deviceList = deviceList.adding(CreateDeviceMatchingDictionary(inUsagePage: kHIDPage_GenericDesktop, inUsage: kHIDUsage_GD_Keyboard)) as NSArray
        deviceList = deviceList.adding(CreateDeviceMatchingDictionary(inUsagePage: kHIDPage_GenericDesktop, inUsage: kHIDUsage_GD_Keypad)) as NSArray

        IOHIDManagerSetDeviceMatchingMultiple(manager, deviceList as CFArray)

        let observer = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())

        /* Connected and Disconnected Call Backs */
        IOHIDManagerRegisterDeviceMatchingCallback(manager, CallBackFunctions.Handle_DeviceMatchingCallback, observer)

        IOHIDManagerRegisterDeviceRemovalCallback(manager, CallBackFunctions.Handle_DeviceRemovalCallback, observer)

        /* Input value Call Backs */
        IOHIDManagerRegisterInputValueCallback(manager, CallBackFunctions.Handle_IOHIDInputValueCallback, observer)

        /* Open HID Manager */
        let ioreturn: IOReturn = openHIDManager()
        if ioreturn != kIOReturnSuccess {
            print("Can't open HID!")
        }
    }

    /* For Keyboard */
    func CreateDeviceMatchingDictionary(inUsagePage: Int, inUsage: Int) -> CFMutableDictionary {
        /* // note: the usage is only valid if the usage page is also defined */

        let resultAsSwiftDic = [kIOHIDDeviceUsagePageKey: inUsagePage, kIOHIDDeviceUsageKey: inUsage]
        let resultAsCFDic: CFMutableDictionary = resultAsSwiftDic as! CFMutableDictionary
        return resultAsCFDic
    }

    func openHIDManager() -> IOReturn {
        return IOHIDManagerOpen(manager, IOOptionBits(kIOHIDOptionsTypeNone))
    }

    /* Scheduling the HID Loop */
    func start() {
        IOHIDManagerScheduleWithRunLoop(manager, CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue)
    }

    /* Un-scheduling the HID Loop */
    func stop() {
        IOHIDManagerUnscheduleFromRunLoop(manager, CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue)
    }
}