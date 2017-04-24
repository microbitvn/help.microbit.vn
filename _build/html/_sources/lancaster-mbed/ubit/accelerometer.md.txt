#uBit.accelerometer

##Overview

Onboard the micro:bit is an accelerometer, and it is linked to the
[i2c](i2c.md) bus which is used to read data from the accelerometer.

The accelerometer on the micro:bit detects the acceleration (*in milli-g*) in 3 planes: x and y
(*the horizontal planes*), and z (*the vertical plane*).

As well as detecting acceleration, accelerometers can also detect orientation, which
is used in smart phones and tablets to rotate content as you tilt the device. This means
that the micro:bit can infer its own orientation as well!

As well as being used to detect acceleration, accelerometers are also used to detect
the rate of deceleration. A great example of an application of accelerometers are
airbags in modern vehicles, where an accelerometer is used to detect the rapid deceleration
of a vehicle. If rapid deceleration were to occur, the airbags are deployed.

Accelerometers can also be used to detect when an object is in free fall, which is
when only the force gravity is acting upon an object. If you were to throw a ball directly
into the air, free fall would begin as soon as the ball begins its decent after the
acceleration from your throw has subsided.

The micro:bit uses the [MMA8653](../resources/datasheets/MMA8653.pdf).

### Real time updates

When using the standard uBit presentation, the accelerometer is continuously updated
in the background using an idle thread (after it is first used), which is executed
whenever the micro:bit has no other tasks to perform..

If there is no scheduler running, the values are synchronously read on `get[X,Y,Z]()`
calls. Additionally, if you would like to drive accelerometer updates manually `updateSample()`
can be used.

##Message Bus ID

| Constant | Value |
| ------------- |-------------|
| MICROBIT_ID_ACCELEROMETER | 4 |
| MICROBIT_ID_GESTURE | 27 |

##Message Bus Events: 

### MICROBIT_ID_ACCELEROMETER 

| Constant | Value |
| ------------- |-------------|
| MICROBIT_ACCELEROMETER_EVT_DATA_UPDATE | 1 |

### MICROBIT_ID_GESTURE 

| Constant | Value |
| ------------- |-------------|
| MICROBIT_ACCELEROMETER_EVT_TILT_UP | 1 |
| MICROBIT_ACCELEROMETER_EVT_TILT_DOWN | 2 |
| MICROBIT_ACCELEROMETER_EVT_TILT_LEFT | 3 |
| MICROBIT_ACCELEROMETER_EVT_TILT_RIGHT | 4 |
| MICROBIT_ACCELEROMETER_EVT_FACE_UP | 5 |
| MICROBIT_ACCELEROMETER_EVT_FACE_DOWN | 6 |
| MICROBIT_ACCELEROMETER_EVT_FREEFALL | 7 |
| MICROBIT_ACCELEROMETER_EVT_3G | 8 |
| MICROBIT_ACCELEROMETER_EVT_6G | 9 |
| MICROBIT_ACCELEROMETER_EVT_8G | 10 |
| MICROBIT_ACCELEROMETER_EVT_SHAKE | 11 |

##API
[comment]: <> ({"className":"MicroBitAccelerometer"})
##Constructor
<br/>
####MicroBitAccelerometer( <div style='color:#a71d5d; display:inline-block'>MicroBitI2C  &</div> _i2c)
#####Description
Constructor. Create a software abstraction of an accelerometer.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitI2C  &</div> _i2c - an instance of  MicroBitI2C  used to communicate with the onboard accelerometer.
#####Example
```cpp
 MicroBitI2C i2c = MicroBitI2C(I2C_SDA0, I2C_SCL0); 
 
 MicroBitAccelerometer accelerometer = MicroBitAccelerometer(i2c); 
```
<br/>
####MicroBitAccelerometer( <div style='color:#a71d5d; display:inline-block'>MicroBitI2C  &</div> _i2c,  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> address)
#####Description
Constructor. Create a software abstraction of an accelerometer.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitI2C  &</div> _i2c - an instance of  MicroBitI2C  used to communicate with the onboard accelerometer.

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> address - the default I2C address of the accelerometer. Defaults to: MMA8653_DEFAULT_ADDR.
#####Example
```cpp
 MicroBitI2C i2c = MicroBitI2C(I2C_SDA0, I2C_SCL0); 
 
 MicroBitAccelerometer accelerometer = MicroBitAccelerometer(i2c); 
```
<br/>
####MicroBitAccelerometer( <div style='color:#a71d5d; display:inline-block'>MicroBitI2C  &</div> _i2c,  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> address,  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id)
#####Description
Constructor. Create a software abstraction of an accelerometer.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitI2C  &</div> _i2c - an instance of  MicroBitI2C  used to communicate with the onboard accelerometer.

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> address - the default I2C address of the accelerometer. Defaults to: MMA8653_DEFAULT_ADDR.

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id - the unique  EventModel  id of this component. Defaults to: MICROBIT_ID_ACCELEROMETER
#####Example
```cpp
 MicroBitI2C i2c = MicroBitI2C(I2C_SDA0, I2C_SCL0); 
 
 MicroBitAccelerometer accelerometer = MicroBitAccelerometer(i2c); 
```
##configure
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>configure</div>()
#####Description
Configures the accelerometer for G range and sample rate defined in this object. The nearest values are chosen to those defined that are supported by the hardware. The instance variables are then updated to reflect reality.  

 


#####Returns
MICROBIT_OK on success, MICROBIT_I2C_ERROR if the accelerometer could not be configured. 
##updateSample
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>updateSample</div>()
#####Description
Reads the acceleration data from the accelerometer, and stores it in our buffer. This only happens if the accelerometer indicates that it has new data via int1.  

 On first use, this member function will attempt to add this component to the list of fiber components in order to constantly update the values stored by this object.  

 This technique is called lazy instantiation, and it means that we do not obtain the overhead from non-chalantly adding this component to fiber components.  

 


#####Returns
MICROBIT_OK on success, MICROBIT_I2C_ERROR if the read request fails. 
##setPeriod
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>setPeriod</div>( <div style='color:#a71d5d; display:inline-block'>int</div> period)
#####Description
Attempts to set the sample rate of the accelerometer to the specified value (in ms).  

 

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> period - the requested time between samples, in milliseconds.
#####Returns
MICROBIT_OK on success, MICROBIT_I2C_ERROR is the request fails.
#####Example
```cpp
 // sample rate is now 20 ms. 
 accelerometer.setPeriod(20); 
```

!!! note
    The requested rate may not be possible on the hardware. In this case, the nearest lower rate is chosen. 

##getPeriod
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getPeriod</div>()
#####Description
Reads the currently configured sample rate of the accelerometer.  

 


#####Returns
The time between samples, in milliseconds. 
##setRange
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>setRange</div>( <div style='color:#a71d5d; display:inline-block'>int</div> range)
#####Description
Attempts to set the sample range of the accelerometer to the specified value (in g).  

 

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> range - The requested sample range of samples, in g.
#####Returns
MICROBIT_OK on success, MICROBIT_I2C_ERROR is the request fails.
#####Example
```cpp
 // the sample range of the accelerometer is now 8G. 
 accelerometer.setRange(8); 
```

!!! note
    The requested range may not be possible on the hardware. In this case, the nearest lower range is chosen. 

##getRange
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getRange</div>()
#####Description
Reads the currently configured sample range of the accelerometer.  

 


#####Returns
The sample range, in g. 
##whoAmI
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>whoAmI</div>()
#####Description
Attempts to read the 8 bit ID from the accelerometer, this can be used for validation purposes.  

 


#####Returns
the 8 bit ID returned by the accelerometer, or MICROBIT_I2C_ERROR if the request fails.
#####Example
```cpp
 accelerometer.whoAmI(); 
```
##getX
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getX</div>()
#####Description
Reads the value of the X axis from the latest update retrieved from the accelerometer.  

 


#####Returns
The force measured in the X axis, in milli-g.
#####Example
```cpp
 accelerometer.getX(); 
```
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getX</div>( <div style='color:#a71d5d; display:inline-block'>MicroBitCoordinateSystem</div> system)
#####Description
Reads the value of the X axis from the latest update retrieved from the accelerometer.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitCoordinateSystem</div> system - The coordinate system to use. By default, a simple cartesian system is provided.
#####Returns
The force measured in the X axis, in milli-g.
#####Example
```cpp
 accelerometer.getX(); 
```
##getY
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getY</div>()
#####Description
Reads the value of the Y axis from the latest update retrieved from the accelerometer.  

 


#####Returns
The force measured in the Y axis, in milli-g.
#####Example
```cpp
 accelerometer.getY(); 
```
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getY</div>( <div style='color:#a71d5d; display:inline-block'>MicroBitCoordinateSystem</div> system)
#####Description
Reads the value of the Y axis from the latest update retrieved from the accelerometer.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitCoordinateSystem</div> system
#####Returns
The force measured in the Y axis, in milli-g.
#####Example
```cpp
 accelerometer.getY(); 
```
##getZ
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getZ</div>()
#####Description
Reads the value of the Z axis from the latest update retrieved from the accelerometer.  

 


#####Returns
The force measured in the Z axis, in milli-g.
#####Example
```cpp
 accelerometer.getZ(); 
```
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getZ</div>( <div style='color:#a71d5d; display:inline-block'>MicroBitCoordinateSystem</div> system)
#####Description
Reads the value of the Z axis from the latest update retrieved from the accelerometer.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitCoordinateSystem</div> system
#####Returns
The force measured in the Z axis, in milli-g.
#####Example
```cpp
 accelerometer.getZ(); 
```
##getPitch
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getPitch</div>()
#####Description
Provides a rotation compensated pitch of the device, based on the latest update retrieved from the accelerometer.  

 


#####Returns
The pitch of the device, in degrees.
#####Example
```cpp
 accelerometer.getPitch(); 
```
##getPitchRadians
<br/>
####<div style='color:#a71d5d; display:inline-block'>float</div> <div style='color:#795da3; display:inline-block'>getPitchRadians</div>()
#####Description
Provides a rotation compensated pitch of the device, based on the latest update retrieved from the accelerometer.  

 


#####Returns
The pitch of the device, in radians.
#####Example
```cpp
 accelerometer.getPitchRadians(); 
```
##getRoll
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getRoll</div>()
#####Description
Provides a rotation compensated roll of the device, based on the latest update retrieved from the accelerometer.  

 


#####Returns
The roll of the device, in degrees.
#####Example
```cpp
 accelerometer.getRoll(); 
```
##getRollRadians
<br/>
####<div style='color:#a71d5d; display:inline-block'>float</div> <div style='color:#795da3; display:inline-block'>getRollRadians</div>()
#####Description
Provides a rotation compensated roll of the device, based on the latest update retrieved from the accelerometer.  

 


#####Returns
The roll of the device, in radians.
#####Example
```cpp
 accelerometer.getRollRadians(); 
```
##getGesture
<br/>
####<div style='color:#a71d5d; display:inline-block'>uint16_t</div> <div style='color:#795da3; display:inline-block'>getGesture</div>()
#####Description
Retrieves the last recorded gesture.  

 


#####Returns
The last gesture that was detected.
#####Example
```cpp
 MicroBitDisplay display; 
 
 if (accelerometer.getGesture() == SHAKE) 
 display.scroll("SHAKE!"); 
```
____
[comment]: <> ({"end":"MicroBitAccelerometer"})
