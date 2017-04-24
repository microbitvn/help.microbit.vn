# Bluetooth Accelerometer Service

## Introduction

This Bluetooth service is an optional part of the standard Bluetooth profile for the micro:bit. It is a passive service, that can operate transparently in the background as your main program is running. It provides live accelerometer data to a connected Bluetooth master device such as a smartphone. You do not need to explicitly address an API on the service object to achieve this.

## Enabling the Service

This service is disabled by default. To enable the service, simply create an instance of this class in your program, at any time after the uBit object has been initialised:

```cpp
    new MicroBitAccelerometerService(*uBit.ble, uBit.accelerometer);
```

!!! note
    Using Bluetooth services is memory hungry. By default, some of the memory normally used by Nordic's Bluetooth protocol stack (known as a SoftDevice), is reclaimed by the micro:bit runtime as general purpose memory for your applications. if you enable more Bluetooth services, then you may need to provide more memory back to Soft Device to ensure proper operation. If after enabling this service your Bluetooth application cannot access the service reliably, you should consider increasing the value of MICROBIT_SD_GATT_TABLE_SIZE in your inc/MicroBitConfig.h. The more service you add, the larger this will need to be, up to the limit defined in MicroBitConfig.h.

## Bluetooth Service Specification

 Please see the [micro:bit Bluetooth profile specification](../resources/bluetooth/microbit-profile-V1.9-Level-2.pdf).

## Example Applications for Android/IOS/Android

### General Procedures

Accelerometer data may be obtained from the Bluetooth Accelerometer Service. Each time the accelerometer is polled, an X, Y and Z value becomes available. All three values may be transmitted to a connected client application as a Bluetooth Notification. To make this happen, the application must first subscribe to notifications relating to the Accelerometer Data characteristic by setting its associated Client Characteristic Configuration Descriptor (CCCD) to 0x0100. Once this has been done, notification messages will be delivered periodically.

You can control how often the accelerometer is polled and therefore how often Accelerometer Data notifications are received by the client application by writing a value in milliseconds to the Accelerometer Service's Accelerometer Period characteristic.

See the profile page and profile reference documentation for data format and UUID details.

Raw accelerometer data received from the micro:bit can be a bit "jerky" and so a low pass filter function should be used to smooth the data.


### Android

<img src="../../resources/bluetooth/accelerometer_demo.png" alt="Accelerometer Demo">

#### Android Bluetooth APIs

Android developers should make themselves familiar with the [Android Bluetooth low energy APIs](http://developer.android.com/guide/topics/connectivity/bluetooth-le.html)

#### microbit-ble-demo-android

The open source microbit-ble-demo-android application contains a full demonstration of the micro:bit Bluetooth accelerometer service. The main body of code for this demonstration can be found in ui.AccelerometerActivity.java except for the Bluetooth operations themselves which are in bluetooth.BleAdapterService which acts as a kind of higher level Bluetooth API for activities to use without needing to directly concern themselves too closely with the Android APIs themselves. In most cases, operations are asynchronous so that the activity code initiates a Bluetooth operation by calling one of the methods in bluetooth.BleAdapterService (e.g. readCharacteristic(....) ) and later receives a message containing the result of the operation from this object via a Handler object. The message is examined in the Handler code and acted upon.

Key parts of the accelerometer demonstration in this application are explained next.

#### In bluetooth.BleAdapterService

``` java
public static String ACCELEROMETERSERVICE_SERVICE_UUID = "E95D0753251D470AA062FA1922DFA9A8";
public static String ACCELEROMETERDATA_CHARACTERISTIC_UUID = "E95DCA4B251D470AA062FA1922DFA9A8";
public static String ACCELEROMETERPERIOD_CHARACTERISTIC_UUID = "E95DFB24251D470AA062FA1922DFA9A8";
```

#### In ui.AccelerometerActivity

``` java
// initiate reading of the accelerometer period characteristic to establish the current value
bluetooth_le_adapter.readCharacteristic(Utility.normaliseUUID(BleAdapterService.ACCELEROMETERSERVICE_SERVICE_UUID), Utility.normaliseUUID(BleAdapterService.ACCELEROMETERPERIOD_CHARACTERISTIC_UUID));
```

``` java
// changing the accelerometer polling period
bluetooth_le_adapter.writeCharacteristic(Utility.normaliseUUID(BleAdapterService.ACCELEROMETERSERVICE_SERVICE_UUID), Utility.normaliseUUID(BleAdapterService.ACCELEROMETERPERIOD_CHARACTERISTIC_UUID), Utility.leBytesFromShort(Settings.getInstance().getAccelerometer_period()));
```

``` java
// enabling accelerometer notifications
bluetooth_le_adapter.setNotificationsState(
                    Utility.normaliseUUID(BleAdapterService.ACCELEROMETERSERVICE_SERVICE_UUID),
                    Utility.normaliseUUID(BleAdapterService.ACCELEROMETERDATA_CHARACTERISTIC_UUID), true);
```


``` java
// receiving, decoding and smoothing a notification
case BleAdapterService.NOTIFICATION_RECEIVED:
    bundle = msg.getData();
    service_uuid = bundle.getString(BleAdapterService.PARCEL_SERVICE_UUID);
    characteristic_uuid = bundle.getString(BleAdapterService.PARCEL_CHARACTERISTIC_UUID);
    b = bundle.getByteArray(BleAdapterService.PARCEL_VALUE);
    Log.d(Constants.TAG, "Value=" + Utility.byteArrayAsHexString(b));
    if (characteristic_uuid.equalsIgnoreCase((Utility.normaliseUUID(BleAdapterService.ACCELEROMETERDATA_CHARACTERISTIC_UUID)))) {
        notification_count++;
        if (System.currentTimeMillis() - start_time >= 60000) {
            showBenchmark();
            notification_count = 0;
            minute_number++;
            start_time = System.currentTimeMillis();
        }
        byte[] x_bytes = new byte[2];
        byte[] y_bytes = new byte[2];
        byte[] z_bytes = new byte[2];
        System.arraycopy(b, 0, x_bytes, 0, 2);
        System.arraycopy(b, 2, y_bytes, 0, 2);
        System.arraycopy(b, 4, z_bytes, 0, 2);
        short raw_x = Utility.shortFromLittleEndianBytes(x_bytes);
        short raw_y = Utility.shortFromLittleEndianBytes(y_bytes);
        short raw_z = Utility.shortFromLittleEndianBytes(z_bytes);
        Log.d(Constants.TAG, "Accelerometer Data received: x=" + raw_x + " y=" + raw_y + " z=" + raw_z);


        // range is -1024 : +1024
        // Starting with the LED display face up and level (perpendicular to gravity) and edge connector towards your body:
        // A negative X value means tilting left, a positive X value means tilting right
        // A negative Y value means tilting away from you, a positive Y value means tilting towards you
        // A negative Z value means ?

        float accel_x = raw_x / 1000f;
        float accel_y = raw_y / 1000f;
        float accel_z = raw_z / 1000f;
        Log.d(Constants.TAG, "Accelerometer data converted: x=" + accel_x + " y=" + accel_y + " z=" + accel_z);

        accel_input[0] = accel_x;
        accel_input[1] = accel_y;
        accel_input[2] = accel_z;
        accel_output = Utility.lowPass(accel_input, accel_output);
        Log.d(Constants.TAG, "Smoothed accelerometer data: x=" + accel_output[0] + " y=" + accel_output[1] + " z=" + accel_output[2]);

        double pitch = Math.atan(accel_output[0] / Math.sqrt(Math.pow(accel_output[1], 2) + Math.pow(accel_output[2], 2)));
        double roll = Math.atan(accel_output[1] / Math.sqrt(Math.pow(accel_output[0], 2) + Math.pow(accel_output[2], 2)));
        //convert radians into degrees
        pitch = pitch * (180.0 / Math.PI);
        roll = -1 * roll * (180.0 / Math.PI);

        showAccelerometerData(accel_output,pitch,roll);
```



#### Video Demonstration - starts at 0:18

<iframe src="https://player.vimeo.com/video/153078747" width="750" height="422" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
