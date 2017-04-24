#MicroBit

##Overview

Although the runtime is built from lots of small components, we also provide an easy to use pre-packaged collection of the commonly used components
all in one place. This makes it much easier to start programming your micro:bit in C.

This grouping is provided by a C++ class called `MicroBit`.  The `MicroBit` class has a number of
member variables, that operate as device drivers to control the most commonly used features of the micro:bit.

There is an instance of the `MicroBit` class created as a global variable in all the sample programs, called `uBit`:

>    uBit {<br/>
>    &emsp;&emsp;[.i2c](ubit/i2c.md),<br/>
>    &emsp;&emsp;[.storage](ubit/storage.md),<br/>
>    &emsp;&emsp;[.serial](ubit/serial.md),<br/>
>    &emsp;&emsp;[.MessageBus](ubit/messageBus.md),<br/>
>    &emsp;&emsp;[.buttonA](ubit/button.md),<br/>
>    &emsp;&emsp;[.buttonB](ubit/button.md),<br/>
>    &emsp;&emsp;[.buttonAB](ubit/button.md),<br/>
>    &emsp;&emsp;[.display](ubit/display.md),<br/>
>    &emsp;&emsp;[.accelerometer](ubit/accelerometer.md),<br/>
>    &emsp;&emsp;[.compass](ubit/compass.md),<br/>
>    &emsp;&emsp;[.thermometer](ubit/thermometer.md),<br/>
>    &emsp;&emsp;[.io](ubit/io.md),<br/>
>    &emsp;&emsp;[.radio](ubit/radio.md),<br/>
>    }

You can use dot operator '.' to any of these resources inside uBit to access any of the functions they provide. There is a complete list of the
functions available under the `uBit` menu item in the navigation bar at the top of the page.

For example, if we needed to scroll some text across the display, we simply would write the following:

```cpp
uBit.display.scroll("HELLO!");
```

Similarly, if we wanted to send some text over serial, we could write the following
code:

```cpp
for(int i = 3; i > 0; i--)
{
    uBit.serial.printf("%d...", i);
    uBit.sleep(1000);
}

// or alternatively...
uBit.serial.send("Code!");
```

The runtime also contains a scheduler, which uses lightweight threads (called fibers)
to control the rate of execution.

To place the current fiber into a power efficient <a href="#sleep">sleep</a> write the following:

```cpp
// where X is an integer in milliseconds for the amount of time you would like to sleep for.
uBit.sleep(X);
```

##Message Bus ID

> None

##Message Bus Events

> None

#API

[comment]: <> ({"className":"MicroBit"})

##Constructor

<br/>

####MicroBit()

#####Description

Constructor.  

 Create a representation of a  MicroBit  device, which includes member variables that represent various device drivers used to control aspects of the micro:bit.           


##init

<br/>

####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>init</div>()

#####Description

Post constructor initialisation method.  

 This call will initialised the scheduler, memory allocator and Bluetooth stack.  

 This is required as the Bluetooth stack can't be brought up in a static context i.e. in a constructor.  

 

 


#####Example

```cpp
 uBit.init(); 
```

!!! note
    This method must be called before user code utilises any functionality contained by uBit. 

##reset

<br/>

####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>reset</div>()

#####Description

Will reset the micro:bit when called.  

 


#####Example

```cpp
 uBit.reset(); 
```

##sleep

<br/>

####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>sleep</div>( <div style='color:#a71d5d; display:inline-block'>uint32_t</div> milliseconds)

#####Description

Delay execution for the given amount of time.  

 If the scheduler is running, this will deschedule the current fiber and perform a power efficient, concurrent sleep operation.  

 If the scheduler is disabled or we're running in an interrupt context, this will revert to a busy wait.  

 Alternatively: wait, wait_ms, wait_us can be used which will perform a blocking sleep operation.  

 

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint32_t</div> milliseconds - the amount of time, in ms, to wait for. This number cannot be negative.

#####Returns

MICROBIT_OK on success, MICROBIT_INVALID_PARAMETER milliseconds is less than zero.

#####Example

```cpp
 uBit.sleep(20); //sleep for 20ms 
```

!!! note
    This operation is currently limited by the rate of the system timer, therefore the granularity of the sleep operation is limited to 6 ms unless the rate of the system timer is modified. 

##seedRandom

<br/>

####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>seedRandom</div>()

#####Description

Seed the pseudo random number generator using the hardware random number generator.  

 


#####Example

```cpp
 uBit.seedRandom(); 
```

<br/>

####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>seedRandom</div>( <div style='color:#a71d5d; display:inline-block'>uint32_t</div> seed)

#####Description

Seed the pseudo random number generator using the given value.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint32_t</div> seed - The 32-bit value to seed the generator with.

#####Example

```cpp
 uBit.seedRandom(0xBB5EED); 
```

##random

<br/>

####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>random</div>( <div style='color:#a71d5d; display:inline-block'>int</div> max)

#####Description

Generate a random number in the given range. We use a simple Galois LFSR random number generator here, as a Galois LFSR is sufficient for our applications, and much more lightweight than the hardware random number generator built int the processor, which takes a long time and uses a lot of energy.  

 KIDS: You shouldn't use this is the real world to generate cryptographic keys though... have a think why not. :-)  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> max - the upper range to generate a number for. This number cannot be negative.

#####Returns

A random, natural number between 0 and the max-1. Or MICROBIT_INVALID_VALUE if max is <= 0.

#####Example

```cpp
 uBit.random(200); //a number between 0 and 199 
```

##systemTime

<br/>

####<div style='color:#a71d5d; display:inline-block'>unsigned long</div> <div style='color:#795da3; display:inline-block'>systemTime</div>()

#####Description

Determine the time since this  MicroBit  was last reset.  

 


#####Returns

The time since the last reset, in milliseconds.

!!! note
    This will value overflow after 1.6 months. 

##systemVersion

<br/>

####<div style='color:#a71d5d; display:inline-block'>const char \*</div> <div style='color:#795da3; display:inline-block'>systemVersion</div>()

#####Description

Determine the version of the micro:bit runtime currently in use.  

 


#####Returns

A textual description of the version of the micro:bit runtime that is currently running on this device. 

##panic

<br/>

####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>panic</div>()

#####Description

Triggers a microbit panic where an loop will display a panic face and the status code, if provided.  

 This loop will continue for panic_timeout iterations, defaults to 0 (infinite).  

 panic_timeout can be configured via a call to microbit_panic_timeout.  

 


#####Example

```cpp
 microbit_panic_timeout(4); 
 
 // will display loop for 4 iterations. 
 uBit.panic(10); 
```

<br/>

####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>panic</div>( <div style='color:#a71d5d; display:inline-block'>int</div> statusCode)

#####Description

Triggers a microbit panic where an loop will display a panic face and the status code, if provided.  

 This loop will continue for panic_timeout iterations, defaults to 0 (infinite).  

 panic_timeout can be configured via a call to microbit_panic_timeout.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> statusCode - the status code of the associated error.

#####Example

```cpp
 microbit_panic_timeout(4); 
 
 // will display loop for 4 iterations. 
 uBit.panic(10); 
```

##addSystemComponent

<br/>

####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>addSystemComponent</div>( <div style='color:#a71d5d; display:inline-block'>MicroBitComponent  \*</div> component)

#####Description

Add a component to the array of system components. This component will then receive periodic callbacks, once every tick period in interrupt context.  

 

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitComponent  \*</div> component - The component to add.

#####Returns

MICROBIT_OK on success or MICROBIT_NO_RESOURCES if the component array is full.

#####Example

```cpp
 // heap allocated - otherwise it will be paged out! 
 MicroBitDisplay* display = new MicroBitDisplay(); 
 
 uBit.addSystemComponent(display); 
```

!!! note
    This interface is now deprecated, and will be removed in the next major release. Please use  system_timer_add_component() . 

##removeSystemComponent

<br/>

####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>removeSystemComponent</div>( <div style='color:#a71d5d; display:inline-block'>MicroBitComponent  \*</div> component)

#####Description

Remove a component from the array of system components. This component will no longer receive periodic callbacks.  

 

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitComponent  \*</div> component - The component to remove.

#####Returns

MICROBIT_OK on success or MICROBIT_INVALID_PARAMETER is returned if the given component has not been previously added.

#####Example

```cpp
 // heap allocated - otherwise it will be paged out! 
 MicroBitDisplay* display = new MicroBitDisplay(); 
 
 uBit.addSystemComponent(display); 
 
 uBit.removeSystemComponent(display); 
```

!!! note
    This interface is now deprecated, and will be removed in the next major release. Please use  system_timer_remove_component() . 

##addIdleComponent

<br/>

####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>addIdleComponent</div>( <div style='color:#a71d5d; display:inline-block'>MicroBitComponent  \*</div> component)

#####Description

Adds a component to the array of idle thread components, which are processed when the run queue is empty.  

 The system timer will poll isIdleCallbackNeeded on each component to determine if the scheduler should schedule the idle_task imminently.  

 

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitComponent  \*</div> component - The component to add to the array.

#####Returns

MICROBIT_OK on success or MICROBIT_NO_RESOURCES if the fiber components array is full.

#####Example

```cpp
 MicroBitI2C i2c(I2C_SDA0, I2C_SCL0); 
 
 // heap allocated - otherwise it will be paged out! 
 MicroBitAccelerometer* accelerometer = new MicroBitAccelerometer(i2c); 
 
 fiber_add_idle_component(accelerometer); 
```

!!! note
    This interface is now deprecated, and will be removed in the next major release. Please use  fiber_add_idle_component() . 

##removeIdleComponent

<br/>

####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>removeIdleComponent</div>( <div style='color:#a71d5d; display:inline-block'>MicroBitComponent  \*</div> component)

#####Description

Remove a component from the array of idle thread components  

 

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitComponent  \*</div> component - The component to remove from the idle component array.

#####Returns

MICROBIT_OK on success. MICROBIT_INVALID_PARAMETER is returned if the given component has not been previously added.

#####Example

```cpp
 MicroBitI2C i2c(I2C_SDA0, I2C_SCL0); 
 
 // heap allocated - otherwise it will be paged out! 
 MicroBitAccelerometer* accelerometer = new MicroBitAccelerometer(i2c); 
 
 uBit.addIdleComponent(accelerometer); 
 
 uBit.removeIdleComponent(accelerometer); 
```

!!! note
    This interface is now deprecated, and will be removed in the next major release. Please use  fiber_remove_idle_component() . 

____

[comment]: <> ({"end":"MicroBit"})
