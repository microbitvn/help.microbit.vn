# Bluetooth Connection Events

## Introduction

Two MicroBitEvent types are available for tracking changes in the state of Bluetooth connections between remote devices and the micro:bit.

## MICROBIT_BLE_EVT_CONNECTED

This event is produced when a remote peer device connects to the micro:bit over Bluetooth.

To listen for this event:

```cpp
uBit.messageBus.listen(MICROBIT_ID_BLE, MICROBIT_BLE_EVT_CONNECTED, onConnected);
```

## MICROBIT_BLE_EVT_DISCONNECTED

This event is produced when a remote Bluetooth device disconnects from the micro:bit.

To listen for this event:

```cpp
uBit.messageBus.listen(MICROBIT_ID_BLE, MICROBIT_BLE_EVT_DISCONNECTED, onDisconnected);
```

## Example micro:bit application - Keeping track of connection state

| Connected | Disconnected |
|:---------:|:------------:|
| <img src="../../resources/bluetooth/microbit_on_connected.png" alt="Connected"> | <img src="../../resources/bluetooth/microbit_on_disconnected.png" alt="Disconnected">             |

```cpp
#include "MicroBit.h"
#include "MicroBitSamples.h"
MicroBit uBit;
int connected = 0;

void onConnected(MicroBitEvent e)
{
    uBit.display.print("C");
    connected = 1;
}

void onDisconnected(MicroBitEvent e)
{
    uBit.display.print("D");
    connected = 0;
}

int main()
{
    // Initialise the micro:bit runtime.
    uBit.init();

    // listen for Bluetooth connection state changes
    uBit.messageBus.listen(MICROBIT_ID_BLE, MICROBIT_BLE_EVT_CONNECTED, onConnected);
    uBit.messageBus.listen(MICROBIT_ID_BLE, MICROBIT_BLE_EVT_DISCONNECTED, onDisconnected);

    uBit.display.scroll("READY");

    // If main exits, there may still be other fibers running or registered event handlers etc.
    // Simply release this fiber, which will mean we enter the scheduler. Worse case, we then
    // sit in the idle task forever, in a power efficient sleep.
    release_fiber();
}
```


