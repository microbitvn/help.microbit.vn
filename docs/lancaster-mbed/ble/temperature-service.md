# Bluetooth Temperature Service

## Introduction

This Bluetooth service is an optional part of the standard bluetooth profile for the micro:bit. It is a passive service, that can operate transparently in the
background as your main program is running. It provides live temperature data to a connected Bluetooth master device such as a smartphone. You do not need to explicitly address an API on the service to achieve this.
Please note that the temperature data is inferred from the die temperature of the Nordic nrf51822 CPU. Whilst this sensor has a high precision, it is not calibrated, so will exhibit
a linear shift (although changes in temperature will be accurate). See [MicroBitThermometer](/ubit/thermometer.md) for information on the API to allow calibration.

## Enabling the Service

This service is disabled by default. To enable the service, simply create an instance of this class in your program, at any time after the uBit object has been initialised:

```cpp
    new MicroBitTemperatureService(*uBit.ble, uBit.thermometer);
```

!!! note
    Using Bluetooth services is memory hungry. By default, some of the memory normally used by Nordic's Bluetooth protocol stack (known as a SoftDevice), is reclaimed by the micro:bit runtime as general purpose memory for your applications. if you enable more Bluetooth services, then you may need to provide more memory back to Soft Device to ensure proper operation. If after enabling this service your Bluetooth application cannot access the service reliably, you should consider increasing the value of MICROBIT_SD_GATT_TABLE_SIZE in your inc/MicroBitConfig.h. The more service you add, the larger this will need to be, up to the limit defined in MicroBitConfig.h.

## Bluetooth Service Specification

 Please see the [micro:bit Bluetooth profile specification](../resources/bluetooth/microbit-profile-V1.9-Level-2.pdf).

## Example Applications for Android/IOS/Android


### General Procedures

micro:bit can acquire a temperature reading from the surface of the nrf51822 processor and this can be shared with connected Bluetooth clients, either via Bluetooth notifications or by the client reading the current value of the Temperature characteristic. The frequency with which Temperature notifications are sent (more accurately, the frequency with which the temperature is sampled) may be configured by writing a ms value to the Temperature Period characteristic.  


See the profile page and profile reference documentation for data format and UUID details.

### Android

<img src="../../resources/bluetooth/temperature_demo.png" alt="Temperature Demo">

#### Android Bluetooth APIs

Android developers should make themselves familiar with the [Android Bluetooth low energy APIs](http://developer.android.com/guide/topics/connectivity/bluetooth-le.html)

#### microbit-ble-demo-android

The open source microbit-ble-demo-android application contains a full demonstration of the micro:bit Bluetooth temperature service. The main body of code for this demonstration can be found in ui.TemperatureActivity.java except for the Bluetooth operations themselves which are in bluetooth.BleAdapterService which acts as a kind of higher level Bluetooth API for activities to use without needing to directly concern themselves too closely with the Android APIs themselves. In most cases, operations are asynchronous so that the activity code initiates a Bluetooth operation by calling one of the methods in bluetooth.BleAdapterService (e.g. readCharacteristic(....) ) and later receives a message containing the result of the operation from this object via a Handler object. The message is examined in the Handler code and acted upon.

Key parts of the button demonstration in this application are explained next.

#### In bluetooth.BleAdapterService

``` java
public static String TEMPERATURESERVICE_SERVICE_UUID = "E95D6100251D470AA062FA1922DFA9A8";
public static String TEMPERATURE_CHARACTERISTIC_UUID = "E95D9250251D470AA062FA1922DFA9A8";
```

#### In ui.TemperatureActivity

``` java
// enable temperature notifications
bluetooth_le_adapter.setNotificationsState(
                    Utility.normaliseUUID(BleAdapterService.TEMPERATURESERVICE_SERVICE_UUID), 
                    Utility.normaliseUUID(BleAdapterService.TEMPERATURE_CHARACTERISTIC_UUID), true)
```


```java
// receiving temperature notifications
case BleAdapterService.NOTIFICATION_RECEIVED:
    bundle = msg.getData();
    service_uuid = bundle.getString(BleAdapterService.PARCEL_SERVICE_UUID);
    characteristic_uuid = bundle.getString(BleAdapterService.PARCEL_CHARACTERISTIC_UUID);
    b = bundle.getByteArray(BleAdapterService.PARCEL_VALUE);
    byte temperature = b[0];
    Log.d(Constants.TAG, "Value=" + Utility.byteArrayAsHexString(b));
    if (characteristic_uuid.equalsIgnoreCase((Utility.normaliseUUID(BleAdapterService.TEMPERATURE_CHARACTERISTIC_UUID)))) {
        Log.d(Constants.TAG, "Temperature received: " + temperature);
        TextView temp = (TextView) TemperatureActivity.this.findViewById(R.id.temperature);
        temp.setText(""+temperature);
    }
    break;
}
```


#### Video Demonstration - starts at 3:05

<iframe src="https://player.vimeo.com/video/153078747" width="750" height="422" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>



