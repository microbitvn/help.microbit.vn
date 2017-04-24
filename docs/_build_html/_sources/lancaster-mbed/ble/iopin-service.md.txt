# Bluetooth IO Pin Service

## Introduction

This Bluetooth service is an optional part of the standard bluetooth profile for the micro:bit. It is a passive service, that can operate transparently in the
background as your main program is running. It provides the ability to read and write digital and analog values from/to any of the pins exposed on the micro:bit edge connector, including the 3 main ring ports.
This data can be transparently read and written by a connected Bluetooth master device such as a smartphone. You do not need to explicitly address an API on the service to achieve this.

## Enabling the Service

This service is disabled by default. To enable the service, simply create an instance of this class in your program, at any time after the uBit object has been initialised:

```cpp
    new MicroBitIOPinService(*uBit.ble, uBit.io);
```

!!! note
    Using Bluetooth services is memory hungry. By default, some of the memory normally used by Nordic's Bluetooth protocol stack (known as a SoftDevice), is reclaimed by the micro:bit runtime as general purpose memory for your applications. if you enable more Bluetooth services, then you may need to provide more memory back to Soft Device to ensure proper operation. If after enabling this service your Bluetooth application cannot access the service reliably, you should consider increasing the value of MICROBIT_SD_GATT_TABLE_SIZE in your inc/MicroBitConfig.h. The more service you add, the larger this will need to be, up to the limit defined in MicroBitConfig.h.

## Bluetooth Service Specification

 Please see the [micro:bit Bluetooth profile specification](../resources/bluetooth/microbit-profile-V1.9-Level-2.pdf).

## Example Applications for Android/IOS/Android

### General Procedures

Applications should first configure the pins they wish to work with over Bluetooth. Configuration involves specifying that a pin is to be used for digital I/O or analogue I/O and that it is to be used for input or for output. These two types of configuration are handled by two characteristics in the IO Pin Service namely Pin AD Configuration and Pin IO Configuration. 

The Pin AD Configuration characteristic contains A bit mask (32 bit) which defines which inputs will be read. If the Pin AD Configuration bit mask is also set the pin will be read as an analogue input, if not it will be read as a digital input.  

Note that in practice, setting a pin's mask bit means that it will be read by the micro:bit runtime and, if notifications have been enabled on the Pin Data characteristic, data read will be transmitted to the connected Bluetooth peer device in a Pin Data notification. If the pin's bit is clear, it  simply means that it will not be read by the micro:bit runtime.By default, pins are configured for output.

The Pin Data characteristic  is used to read values from one or more pins concurrently via Bluetooth read operations or write data to pins using Bluetooth writes. Notifications are also supported as a means of receiving input data. See the reference documentation for further information.

The PWM Control characteristic allows a client to use up to 2 micro:bit pins at a time for PWM output and to set the period and value of the pin(s). This is useful for applications such as the analogue control of LEDs and simple audio tone generation. Note that not all pins support PWM on micro:bit.

!!! note
    If PWM is used for the generation of audio tones via speakers or similar, then tones will not sound as "clean and pure" as they would if the pins were set to the same period and value directly on a micro:bit which has Bluetooth disabled. This is due to a combination of factors including the fact that PWM on micro:bit is implemented partly in software and the Nordic Semiconductor Bluetooth stack takes priority with respect to interrupts.

### Android

<img src="../../resources/bluetooth/io_pin_demo.png" alt="IO Pin Demo">

#### Android Bluetooth APIs

Android developers should make themselves familiar with the [Android Bluetooth low energy APIs](http://developer.android.com/guide/topics/connectivity/bluetooth-le.html)

#### microbit-ble-demo-android

The open source microbit-ble-demo-android application contains a demonstration of the micro:bit Bluetooth IO Pin service which involves switching a connected LED on and off from a smartphone over Bluetooth. The main body of code for this demonstration can be found in ui.IoDigitalOutputActivity.java except for the Bluetooth operations themselves which are in bluetooth.BleAdapterService which acts as a kind of higher level Bluetooth API for activities to use without needing to directly concern themselves too closely with the Android APIs themselves. In most cases, operations are asynchronous so that the activity code initiates a Bluetooth operation by calling one of the methods in bluetooth.BleAdapterService (e.g. readCharacteristic(....) ) and later receives a message containing the result of the operation from this object via a Handler object. The message is examined in the Handler code and acted upon.

Key parts of the IO Pin demonstration in this application are explained next.

#### In bluetooth.BleAdapterService

``` java
public static String IOPINSERVICE_SERVICE_UUID = "E95D127B251D470AA062FA1922DFA9A8";
public static String PINDATA_CHARACTERISTIC_UUID = "E95D8D00251D470AA062FA1922DFA9A8";
public static String PINADCONFIGURATION_CHARACTERISTIC_UUID = "E95D5899251D470AA062FA1922DFA9A8";
public static String PINIOCONFIGURATION_CHARACTERISTIC_UUID = "E95DB9FE251D470AA062FA1922DFA9A8";
```

#### In ui.IoPinDigitalOutputActivity

``` java
// Configure pin 0
//   Digital
byte[] ad_flags = {0x00};
bluetooth_le_adapter.writeCharacteristic(
                    Utility.normaliseUUID(BleAdapterService.IOPINSERVICE_SERVICE_UUID), 
                    Utility.normaliseUUID(BleAdapterService.PINADCONFIGURATION_CHARACTERISTIC_UUID), ad_flags)
                    
//   Output
byte[] io_flags_out = {0x00};
bluetooth_le_adapter.writeCharacteristic(
                    Utility.normaliseUUID(BleAdapterService.IOPINSERVICE_SERVICE_UUID), 
                    Utility.normaliseUUID(BleAdapterService.PINIOCONFIGURATION_CHARACTERISTIC_UUID), io_flags_out);
```

``` java
// toggling the LED state when the user touches the graphical button on the screen
public boolean onTouch(View v, MotionEvent event) {
    if (v == led_switch) {
        if (on) {
            byte[] switch_off_pin_0 = {0x00, 0x00};
            bluetooth_le_adapter.writeCharacteristic(Utility.normaliseUUID(BleAdapterService.IOPINSERVICE_SERVICE_UUID), Utility.normaliseUUID(BleAdapterService.PINDATA_CHARACTERISTIC_UUID), switch_off_pin_0);
        } else {
            byte[] switch_on_pin_0 = {0x00, 0x01};
            bluetooth_le_adapter.writeCharacteristic(Utility.normaliseUUID(BleAdapterService.IOPINSERVICE_SERVICE_UUID), Utility.normaliseUUID(BleAdapterService.PINDATA_CHARACTERISTIC_UUID), switch_on_pin_0);
        }
    }
    return false;
}
```


#### Video Demonstration - starts at 3:49

<iframe src="https://player.vimeo.com/video/153078747" width="750" height="422" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>


