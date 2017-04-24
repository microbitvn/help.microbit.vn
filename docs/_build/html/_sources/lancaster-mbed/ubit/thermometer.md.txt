#uBit.thermometer

##Overview

MicroBitThermometer provides access to the surface temperature of the nrf51822.
The temperature reading therefore is not representative of the ambient temperature,
but rather the temperature relative to the surface temperature of the chip.

However, we can make it representative of the ambient temperature in software
through "calibrating" the thermometer.

Calibration is very simple, and is calculated by giving the current temperature
to the `setCalibration()` member function. From the temperature, an offset is
calculated, and is subsequently used to offset future temperature readings.


### Real time updates

When using the standard uBit presentation, the thermometer is continuously updated
in the background using an idle thread (after it is first used), which is executed
whenever the micro:bit has no other tasks to perform.

If there is no scheduler running, the values are synchronously read on `getTemperature()`
calls. Additionally, if you would like to drive thermometer updates manually `updateSample()`
can be used.

##Message Bus ID

| Constant | Value |
| ------------- |-------------|
| MICROBIT_ID_THERMOMETER | 28 |

##Message Bus Events

| Constant | Value |
| ------------- |-------------|
| MICROBIT_THERMOMETER_EVT_UPDATE | 1 |

##API
[comment]: <> ({"className":"MicroBitThermometer"})
##Constructor
<br/>
####MicroBitThermometer( <div style='color:#a71d5d; display:inline-block'>MicroBitStorage  &</div> _storage)
#####Description
Constructor. Create new  MicroBitThermometer  that gives an indication of the current temperature.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitStorage  &</div> _storage - an instance of  MicroBitStorage  used to persist temperature offset data
#####Example
```cpp
 MicroBitStorage storage; 
 MicroBitThermometer thermometer(storage); 
```
<br/>
####MicroBitThermometer( <div style='color:#a71d5d; display:inline-block'>MicroBitStorage  &</div> _storage,  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id)
#####Description
Constructor. Create new  MicroBitThermometer  that gives an indication of the current temperature.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitStorage  &</div> _storage - an instance of  MicroBitStorage  used to persist temperature offset data

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id - the unique  EventModel  id of this component. Defaults to MICROBIT_ID_THERMOMETER.
#####Example
```cpp
 MicroBitStorage storage; 
 MicroBitThermometer thermometer(storage); 
```
<br/>
####MicroBitThermometer()
#####Description
Constructor. Create new  MicroBitThermometer  that gives an indication of the current temperature.  

 


#####Example
```cpp
 MicroBitThermometer thermometer; 
```
<br/>
####MicroBitThermometer( <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id)
#####Description
Constructor. Create new  MicroBitThermometer  that gives an indication of the current temperature.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id - the unique  EventModel  id of this component. Defaults to MICROBIT_ID_THERMOMETER.
#####Example
```cpp
 MicroBitThermometer thermometer; 
```
##setPeriod
<br/>
####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>setPeriod</div>( <div style='color:#a71d5d; display:inline-block'>int</div> period)
#####Description
Set the sample rate at which the temperatureis read (in ms).  

 The default sample period is 1 second.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> period - the requested time between samples, in milliseconds.

!!! note
    the temperature is always read in the background, and is only updated when the processor is idle, or when the temperature is explicitly read. 

##getPeriod
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getPeriod</div>()
#####Description
Reads the currently configured sample rate of the thermometer.  

 


#####Returns
The time between samples, in milliseconds. 
##setOffset
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>setOffset</div>( <div style='color:#a71d5d; display:inline-block'>int</div> offset)
#####Description
Set the value that is used to offset the raw silicon temperature.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> offset - the offset for the silicon temperature
#####Returns
MICROBIT_OK on success 
##getOffset
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getOffset</div>()
#####Description
Retreive the value that is used to offset the raw silicon temperature.  

 


#####Returns
the current offset. 
##setCalibration
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>setCalibration</div>( <div style='color:#a71d5d; display:inline-block'>int</div> calibrationTemp)
#####Description
This member function fetches the raw silicon temperature, and calculates the value used to offset the raw silicon temperature based on a given temperature.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>int</div> calibrationTemp - the temperature used to calculate the raw silicon temperature offset.
#####Returns
MICROBIT_OK on success 
##getTemperature
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>getTemperature</div>()
#####Description
Gets the current temperature of the microbit.  

 


#####Returns
the current temperature, in degrees celsius.
#####Example
```cpp
 thermometer.getTemperature(); 
```
##updateSample
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>updateSample</div>()
#####Description
Updates the temperature sample of this instance of  MicroBitThermometer  only if  isSampleNeeded()  indicates that an update is required.  

 This call also will add the thermometer to fiber components to receive periodic callbacks.  

 


#####Returns
MICROBIT_OK on success. 
____
[comment]: <> ({"end":"MicroBitThermometer"})
