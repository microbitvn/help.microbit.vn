#Introduction

The micro:bit runtime provides an easy to use environment for programming the BBC micro:bit
in the C/C++ language, written by Lancaster University. It contains device drivers for all the hardware capabilities of the micro:bit,
and also a suite of runtime mechanisms to make programming the micro:bit easier and more flexible. These
range from control of the LED matrix display to peer-to-peer radio communication and secure
Bluetooth Low Energy services. The micro:bit runtime is proudly built on the [ARM mbed](https://www.mbed.com)
and [Nordic nrf51](http://www.nordicsemi.com) platforms.

In addition to supporting development in C/C++, the runtime is also designed specifically to support
higher level languages provided by our partners that target the micro:bit. It is currently used as a support library for all the
languages on the BBC [www.microbit.co.uk](http://www.microbit.co.uk) website, including the Microsoft Block Editor, Microsoft Touch Develop, Code Kingdom's
JavaScript and Micropython languages.

On these pages you will find guidance on how to start using the runtime in C/C++, summaries of all the
components that make up the system and a full set of API documentation (the functions you can use to control the micro:bit).

Just to show how easy it is to get started, view a <a href="#next-steps">sample program</a>.

#Getting Started

Developing with the micro:bit runtime is simple, and there are multiple ways to create programs for your device.

<div class="col-sm-6">
    <center>
        <h3 id="online-environments">Online development</h3>
    </center>
    <p>
        A basic quick start guide to getting an example project building in an
        online programming environment.
    </p>
    <p>
        <center>
            <a href="online-toolchains" class="btn btn-lg btn-outline">
                Online development tools
            </a>
        </center>
    </p>
</div>
<div class="col-sm-6">
    <center>
        <h3 id="offline-environments">Offline development</h3>
    </center>
    <p>
        A full guide to installing offline development tools, and a tutorial on getting
        an example project building.
    </p>
    <p>
        <center>
            <a href="offline-toolchains" class="btn btn-lg btn-outline">
                Offline development tools
            </a>
        </center>
    </p>
</div>

## Next Steps

After you've chosen your development environment, the next step is obvious: **PROGRAM**!

Here is some sample code to get you started:

```cpp
#include "MicroBit.h"

MicroBit uBit;

int main()
{
    uBit.init();

    uBit.display.scroll("HELLO WORLD!");

    release_fiber();
}
```

### What is uBit?

uBit is an instance of the [MicroBit](ubit.md) class which provides a really simple way to interact
with the various components on the micro:bit itself.

This simplicity can be seen with this line of code:

```cpp
uBit.display.scroll("HELLO WORLD!");
```

This line scrolls the text `HELLO WORLD!` across the micro:bit's display.

#### Initialisation

In the above example, there is a line used to initialise the uBit object:

```cpp
uBit.init();
```

In this call the scheduler, memory allocator and Bluetooth stack are initialised.

!!!note
    This line is omitted in all examples you will find on this site simply to avoid
    repetition!


### What is a fiber and why do we release it?

Fibers are lightweight threads used by the runtime to perform operations asynchronously.

The function call `release_fiber();` is recommended at the end of main to release the main fiber, and enter
the scheduler indefinitely as you may have other fibers running elsewhere in the code.
It also means that the processor will enter a power efficient sleep if there are
no other processes running.

If this line is omitted, your program will cease all execution.
