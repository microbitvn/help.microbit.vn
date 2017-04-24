#uBit.i2c

##Overview

i2c is a very common, widely used protocol for communicating with other devices
over a wire. i2c uses a very simple addressing scheme to access these other
devices.

Onboard the micro:bit itself there are two components which use i2c bus as a communication
mechanism, the [accelerometer](accelerometer.md) and the [compass](compass.md).

As well as being used internally, the i2c bus is exposed on two edge connector
pins, P19 and P20. This means other accessories that use i2c to communicate
can be used in conjunction with the micro:bit.

##Message Bus ID

> None.

##Message Bus Events

> None.

##API
[comment]: <> ({"className":"MicroBitI2C"})
##Constructor
<br/>
####MicroBitI2C( <div style='color:#a71d5d; display:inline-block'>PinName</div> sda,  <div style='color:#a71d5d; display:inline-block'>PinName</div> scl)
#####Description
Constructor.  

 Create an instance of  MicroBitI2C  for I2C communication.  

 

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>PinName</div> sda - the Pin to be used for SDA

>  <div style='color:#a71d5d; display:inline-block'>PinName</div> scl - the Pin to be used for SCL
#####Example
```cpp
 MicroBitI2C i2c(I2C_SDA0, I2C_SCL0); 
```

!!! note
    This class presents a wrapped mbed call to capture failed I2C operations caused by a known silicon bug in the nrf51822. Attempts to automatically reset and restart the I2C hardware if this case is detected. 

##read
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>read</div>( <div style='color:#a71d5d; display:inline-block'>int</div> address,  <div style='color:#a71d5d; display:inline-block'>char \*</div> data,  <div style='color:#a71d5d; display:inline-block'>int</div> length)
#####Description
Performs a complete read transaction. The bottom bit of the address is forced to 1 to indicate a read.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> address - 8-bit I2C slave address [ addr | 1 ]

>  <div style='color:#a71d5d; display:inline-block'>char \*</div> data - A pointer to a byte buffer used for storing retrieved data.

>  <div style='color:#a71d5d; display:inline-block'>int</div> length - Number of bytes to read.
#####Returns
MICROBIT_OK on success, MICROBIT_I2C_ERROR if an unresolved read failure is detected. 
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>read</div>( <div style='color:#a71d5d; display:inline-block'>int</div> address,  <div style='color:#a71d5d; display:inline-block'>char \*</div> data,  <div style='color:#a71d5d; display:inline-block'>int</div> length,  <div style='color:#a71d5d; display:inline-block'>bool</div> repeated)
#####Description
Performs a complete read transaction. The bottom bit of the address is forced to 1 to indicate a read.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> address - 8-bit I2C slave address [ addr | 1 ]

>  <div style='color:#a71d5d; display:inline-block'>char \*</div> data - A pointer to a byte buffer used for storing retrieved data.

>  <div style='color:#a71d5d; display:inline-block'>int</div> length - Number of bytes to read.

>  <div style='color:#a71d5d; display:inline-block'>bool</div> repeated - if true, stop is not sent at the end. Defaults to false.
#####Returns
MICROBIT_OK on success, MICROBIT_I2C_ERROR if an unresolved read failure is detected. 
##write
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>write</div>( <div style='color:#a71d5d; display:inline-block'>int</div> address,  <div style='color:#a71d5d; display:inline-block'>const char \*</div> data,  <div style='color:#a71d5d; display:inline-block'>int</div> length)
#####Description
Performs a complete write transaction. The bottom bit of the address is forced to 0 to indicate a write.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> address - 8-bit I2C slave address [ addr | 0 ]

>  <div style='color:#a71d5d; display:inline-block'>const char \*</div> data - A pointer to a byte buffer containing the data to write.

>  <div style='color:#a71d5d; display:inline-block'>int</div> length - Number of bytes to write
#####Returns
MICROBIT_OK on success, MICROBIT_I2C_ERROR if an unresolved write failure is detected. 
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>write</div>( <div style='color:#a71d5d; display:inline-block'>int</div> address,  <div style='color:#a71d5d; display:inline-block'>const char \*</div> data,  <div style='color:#a71d5d; display:inline-block'>int</div> length,  <div style='color:#a71d5d; display:inline-block'>bool</div> repeated)
#####Description
Performs a complete write transaction. The bottom bit of the address is forced to 0 to indicate a write.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> address - 8-bit I2C slave address [ addr | 0 ]

>  <div style='color:#a71d5d; display:inline-block'>const char \*</div> data - A pointer to a byte buffer containing the data to write.

>  <div style='color:#a71d5d; display:inline-block'>int</div> length - Number of bytes to write

>  <div style='color:#a71d5d; display:inline-block'>bool</div> repeated - if true, stop is not sent at the end. Defaults to false.
#####Returns
MICROBIT_OK on success, MICROBIT_I2C_ERROR if an unresolved write failure is detected. 
____
[comment]: <> ({"end":"MicroBitI2C"})
