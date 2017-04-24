# Bluetooth Button Service

## Introduction

This Bluetooth service is an optional part of the standard Bluetooth profile for the micro:bit. It is a passive service, that can operate transparently in the
background as your main program is running. It provides live updates of the state of the physical buttons on the device to a connected Bluetooth master device such as a smartphone. You do not need to explicitly address an API on the service to achieve this.

## Enabling the Service

To enable the service, simply create an instance of this class in your program, at any time after the uBit object has been initialised:

```cpp
    new MicroBitButtonService(*uBit.ble);
```

!!! note
    Using Bluetooth services is memory hungry. By default, some of the memory normally used by Nordic's Bluetooth protocol stack (known as a SoftDevice), is reclaimed by the micro:bit runtime as general purpose memory for your applications. if you enable more Bluetooth services, then you may need to provide more memory back to Soft Device to ensure proper operation. If after enabling this service your Bluetooth application cannot access the service reliably, you should consider increasing the value of MICROBIT_SD_GATT_TABLE_SIZE in your inc/MicroBitConfig.h. The more service you add, the larger this will need to be, up to the limit defined in MicroBitConfig.h.

## Bluetooth Service Specification

 Please see the [micro:bit Bluetooth profile specification](../resources/bluetooth/microbit-profile-V1.9-Level-2.pdf).

## Example Applications for Android/IOS/Android

### General Procedures

Each of the two front panel buttons, Button A and Button B is represented in the Bluetooth profile by a characteristic in the Button Service. The two characteristics are called Button A State and Button B State. Each supports read and notify operations, the most useful of which is notify.

To have your application notified of a change in the state of button A or button B, set the value of the Client Characteristic Configuration Descriptor (CCCD) associated with the appropriate characteristic to 0x0100. Once this has been done, notification messages will be received each time the state of a button changes. Note that buttons have 3 possible states; Not Pressed, Pressed and Long Press (pressed and held for at least 2 seconds) and these are represented by characteristic values 0, 1 and 2.

See the profile page and profile reference documentation for data format and UUID details.

### Android

<img src="../../resources/bluetooth/button_demo.png" alt="Button Demo">

#### Android Bluetooth APIs

Android developers should make themselves familiar with the [Android Bluetooth low energy APIs](http://developer.android.com/guide/topics/connectivity/bluetooth-le.html)

#### microbit-ble-demo-android

The open source microbit-ble-demo-android application contains a full demonstration of the micro:bit Bluetooth accelerometer service. The main body of code for this demonstration can be found in ui.ButtonActivity.java except for the Bluetooth operations themselves which are in bluetooth.BleAdapterService which acts as a kind of higher level Bluetooth API for activities to use without needing to directly concern themselves too closely with the Android APIs themselves. In most cases, operations are asynchronous so that the activity code initiates a Bluetooth operation by calling one of the methods in bluetooth.BleAdapterService (e.g. readCharacteristic(....) ) and later receives a message containing the result of the operation from this object via a Handler object. The message is examined in the Handler code and acted upon.

Key parts of the button demonstration in this application are explained next.

#### In bluetooth.BleAdapterService

``` java
public static String BUTTONSERVICE_SERVICE_UUID = "E95D9882251D470AA062FA1922DFA9A8";
public static String BUTTON1STATE_CHARACTERISTIC_UUID = "E95DDA90251D470AA062FA1922DFA9A8";
public static String BUTTON2STATE_CHARACTERISTIC_UUID = "E95DDA91251D470AA062FA1922DFA9A8";
```

#### In ui.ButtonActivity

``` java
// enabling button state change notifications
bluetooth_le_adapter.setNotificationsState(
                    Utility.normaliseUUID(BleAdapterService.BUTTONSERVICE_SERVICE_UUID),
                    Utility.normaliseUUID(BleAdapterService.BUTTON1STATE_CHARACTERISTIC_UUID), true)
                    
bluetooth_le_adapter.setNotificationsState(
                    Utility.normaliseUUID(BleAdapterService.BUTTONSERVICE_SERVICE_UUID), 
                    Utility.normaliseUUID(BleAdapterService.BUTTON2STATE_CHARACTERISTIC_UUID), true)                    
```
                       

``` java
// receiving, decoding and responding to a notification
case BleAdapterService.NOTIFICATION_RECEIVED:
    bundle = msg.getData();
    service_uuid = bundle.getString(BleAdapterService.PARCEL_SERVICE_UUID);
    characteristic_uuid = bundle.getString(BleAdapterService.PARCEL_CHARACTERISTIC_UUID);
    b = bundle.getByteArray(BleAdapterService.PARCEL_VALUE);
    byte btn_state = b[0];
    Log.d(Constants.TAG, "Value=" + Utility.byteArrayAsHexString(b));
    if (characteristic_uuid.equalsIgnoreCase((Utility.normaliseUUID(BleAdapterService.BUTTON1STATE_CHARACTERISTIC_UUID)))) {
        Log.d(Constants.TAG, "Button 1 State received: " + btn_state);
        ImageView b1_image = (ImageView) ButtonActivity.this.findViewById(R.id.button1);
        setButtonImage(b1_image, btn_state);
        TextView b1_label = (TextView) ButtonActivity.this.findViewById(R.id.button1_state);
        setButtonLabel(b1_label, btn_state);
    } else {
        if (characteristic_uuid.equalsIgnoreCase((Utility.normaliseUUID(BleAdapterService.BUTTON2STATE_CHARACTERISTIC_UUID)))) {
            Log.d(Constants.TAG, "Button 2 State received: " + btn_state);
            ImageView b2_image = (ImageView) ButtonActivity.this.findViewById(R.id.button2);
            setButtonImage(b2_image, btn_state);
            TextView b2_label = (TextView) ButtonActivity.this.findViewById(R.id.button2_state);
            setButtonLabel(b2_label, btn_state);
        }
    }
    break;
```



#### Video Demonstration - starts at 0:59

<iframe src="https://player.vimeo.com/video/153078747" width="750" height="422" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>


