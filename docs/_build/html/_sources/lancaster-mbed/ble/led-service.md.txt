# Bluetooth LED Service

## Introduction

This Bluetooth service is an optional part of the standard bluetooth profile for the micro:bit. It is a passive service, that can operate transparently in the
background as your main program is running. It allows a connected Bluetooth master device such as a smartphone to read and write the status of the LEDs on the display. This includes reading and writing
bitmap pattern values and sending text messages to be scrolled across the display. Scrolling speed may also be controlled over Bluetooth via a control point characteristic designed for this purpose.

## Enabling the Service

This service is disabled by default. To enable the service, simply create an instance of this class in your program, at any time after the uBit object has been initialised:

```cpp
    new MicroBitLEDService(*uBit.ble, uBit.display);
```

!!! note
    Using Bluetooth services is memory hungry. By default, some of the memory normally used by Nordic's Bluetooth protocol stack (known as a SoftDevice), is reclaimed by the micro:bit runtime as general purpose memory for your applications. if you enable more Bluetooth services, then you may need to provide more memory back to Soft Device to ensure proper operation. If after enabling this service your Bluetooth application cannot access the service reliably, you should consider increasing the value of MICROBIT_SD_GATT_TABLE_SIZE in your inc/MicroBitConfig.h. The more service you add, the larger this will need to be, up to the limit defined in MicroBitConfig.h.

## Bluetooth Service Specification

 Please see the [micro:bit Bluetooth profile specification](../resources/bluetooth/microbit-profile-V1.9-Level-2.pdf).

## Example Applications for Android/IOS/Android

### General Procedures

micro:bit has an LED display with 5 rows and 5 columns i.e. 25 LEDs in total. The Bluetooth LED service allows the entire grid to be addressed as a bitmap using the LED Matrix State characteristic which supports both read and write operations. Text strings can be sent to the micro:bit for display by writing to the LED Text characteristic and the speed with which it is scrolled can be controlled by setting a delay value in milliseconds by writing to the Scrolling Delay characteristic.


See the profile page and profile reference documentation for data format and UUID details.

### Android

<img src="../../resources/bluetooth/led_demo.png" alt="LED Demo">

#### Android Bluetooth APIs

Android developers should make themselves familiar with the [Android Bluetooth low energy APIs](http://developer.android.com/guide/topics/connectivity/bluetooth-le.html)

#### microbit-ble-demo-android

The open source microbit-ble-demo-android application contains a full demonstration of the micro:bit Bluetooth LED service. The main body of code for this demonstration can be found in ui.LEDsActivity.java except for the Bluetooth operations themselves which are in bluetooth.BleAdapterService which acts as a kind of higher level Bluetooth API for activities to use without needing to directly concern themselves too closely with the Android APIs themselves. In most cases, operations are asynchronous so that the activity code initiates a Bluetooth operation by calling one of the methods in bluetooth.BleAdapterService (e.g. readCharacteristic(....) ) and later receives a message containing the result of the operation from this object via a Handler object. The message is examined in the Handler code and acted upon.

Key parts of the button demonstration in this application are explained next.

#### In bluetooth.BleAdapterService

``` java
public static String LEDSERVICE_SERVICE_UUID = "E95DD91D251D470AA062FA1922DFA9A8";
public static String LEDMATRIXSTATE_CHARACTERISTIC_UUID = "E95D7B77251D470AA062FA1922DFA9A8";
public static String LEDTEXT_CHARACTERISTIC_UUID = "E95D93EE251D470AA062FA1922DFA9A8";
public static String SCROLLINGDELAY_CHARACTERISTIC_UUID = "E95D0D2D251D470AA062FA1922DFA9A8";
```

#### In ui.LEDsActivity

``` java
private short scrolling_delay;
//    Octet 0, LED Row 1: bit4 bit3 bit2 bit1 bit0
//    Octet 1, LED Row 2: bit4 bit3 bit2 bit1 bit0
//    Octet 2, LED Row 3: bit4 bit3 bit2 bit1 bit0
//    Octet 3, LED Row 4: bit4 bit3 bit2 bit1 bit0
//    Octet 4, LED Row 5: bit4 bit3 bit2 bit1 bit0
private byte[] led_matrix_state;
```
                       

``` java
// read the current LED matrix state so the application UI can be initialised to match the current micro:bit display state
bluetooth_le_adapter.readCharacteristic(
                    Utility.normaliseUUID(BleAdapterService.LEDSERVICE_SERVICE_UUID), 
                    Utility.normaliseUUID(BleAdapterService.LEDMATRIXSTATE_CHARACTERISTIC_UUID))
```

```java
// send a short text string from the application to the micro:bit
public void onSendText(View view) {
    EditText text = (EditText) LEDsActivity.this.findViewById(R.id.display_text);
    try {
        byte[] utf8_bytes = text.getText().toString().getBytes("UTF-8");
        Log.d(Constants.TAG, "UTF8 bytes: 0x" + Utility.byteArrayAsHexString(utf8_bytes));
        bluetooth_le_adapter.writeCharacteristic(
                            Utility.normaliseUUID(BleAdapterService.LEDSERVICE_SERVICE_UUID), 
                            Utility.normaliseUUID(BleAdapterService.LEDTEXT_CHARACTERISTIC_UUID), 
                            utf8_bytes);
    } catch (UnsupportedEncodingException e) {
        showMsg("Unable to convert text to UTF8 bytes");
    }
}
```

```java
// update the local state and UI in response to user interactions
    @Override
    public boolean onTouch(View v, MotionEvent event) {
        Log.d(Constants.TAG, "onTouch - " + event.actionToString((event.getAction())));
        if (led_matrix_state == null) {
            Log.d(Constants.TAG, "onTouch - LED state array has not yet been initialised so ignoring touch");
            return true;
        }
        if (event.getAction() == MotionEvent.ACTION_DOWN) {
            GridLayout grid = (GridLayout) LEDsActivity.this.findViewById(R.id.grid);
            int count = grid.getChildCount();
            int display_row = 0;
            int led_in_row = 4;
            for (int i = 0; i < count; i++) {
                View child = grid.getChildAt(i);
                if (child == v) {
                    Log.d(Constants.TAG,"Touched row "+display_row+", LED "+led_in_row);
                    if ((led_matrix_state[display_row] & (1 << led_in_row)) != 0) {
                        child.setBackgroundColor(Color.parseColor("#C0C0C0"));
                        led_matrix_state[display_row] = (byte) (led_matrix_state[display_row] & ~(1 << led_in_row));
                    } else {
                        child.setBackgroundColor(Color.RED);
                        led_matrix_state[display_row] = (byte) (led_matrix_state[display_row] | (1 << led_in_row));
                    }
                    return true;
                }
                led_in_row = led_in_row - 1;
                if (led_in_row < 0) {
                    led_in_row = 4;
                    display_row++;
                }
            }
            return true;
        }
        return false;
    }
```

```java
// send new display state to micro:bit so it mirrors that shown on the application UI
public void onSetDisplay(View view) {
    bluetooth_le_adapter.writeCharacteristic(
                        Utility.normaliseUUID(BleAdapterService.LEDSERVICE_SERVICE_UUID), 
                        Utility.normaliseUUID(BleAdapterService.LEDMATRIXSTATE_CHARACTERISTIC_UUID), led_matrix_state);
}
```


#### Video Demonstration - starts at 2:00

<iframe src="https://player.vimeo.com/video/153078747" width="750" height="422" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>



