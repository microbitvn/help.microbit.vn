#uBit.storage

##Overview

`MicroBitStorage` provides a simple way to store data on the micro:bit that persists
through power cycles. It currently takes the form of a key value store which contains
a number of key value pairs.

If a user wanted to determine if a micro:bit has just been flashed over USB they
could simply write the following:
```cpp
#include "MicroBit.h"

MicroBit    uBit;

int main()
{
    uBit.init();

    KeyValuePair* firstTime = uBit.storage.get("boot");

    int stored;

    if(firstTime == NULL)
    {
        //this is the first boot after a flash. Store a value!
        stored = 1;
        uBit.storage.put("boot", (uint8_t *)&stored, sizeof(int));
        uBit.display.scroll("Stored!");
    }
    else
    {
        //this is not the first boot, scroll our stored value.
        memcpy(&stored, firstTime->value, sizeof(int));
        delete firstTime;
        uBit.display.scroll(stored);
    }
}
```

###What is flash memory?
The micro:bit has 256 kB flash memory and 16 kB random access memory (RAM). Flash memory
is *non-volatile*, which essentially means that data is not forgotten when the device
is powered off, this is the technology that many USB sticks use.

The alternative, Random Access Memory (also known as *volatile* memory), cannot be persisted through power cycling the device as its
operation relies upon maintaining a constant supply of power.

Therefore, `MicroBitStorage` utilises the *non-volatile* nature of flash memory, to
store its data. This class is utilised by the [compass](compass.md), [accelerometer](compass.md)
and [bleManager](blemanager.md) to improve the user experience by persisting calibration
and bonding data.


###Operations

You can `put()`, `get()` and `remove()` key value pairs from the store.

Key Value pairs have a fixed length key of `16 bytes`, and a fixed length value of
`32 bytes`. This class only populates a single block (`1024 bytes`) in its current state,
which means that **21** Key Value pairs can be stored.

##Message Bus ID

> None.

##Message Bus Events

> None.

##API
[comment]: <> ({"className":"MicroBitStorage"})
##Constructor
<br/>
####MicroBitStorage()
#####Description
Default constructor.  

 Creates an instance of  MicroBitStorage  which acts like a  KeyValueStore  that allows the retrieval, addition and deletion of KeyValuePairs.           


##writeBytes
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>writeBytes</div>( <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> buffer,  <div style='color:#a71d5d; display:inline-block'>uint32_t</div> address,  <div style='color:#a71d5d; display:inline-block'>int</div> length)
#####Description
Writes the given number of bytes to the address specified.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> buffer - the data to write.

>  <div style='color:#a71d5d; display:inline-block'>uint32_t</div> address - the location in memory to write to.

>  <div style='color:#a71d5d; display:inline-block'>int</div> length - the number of bytes to write.

!!! note
    currently not implemented. 

##flashPageErase
<br/>
####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>flashPageErase</div>( <div style='color:#a71d5d; display:inline-block'>uint32_t \*</div> page_address)
#####Description
Method for erasing a page in flash.  

   
 
 page_address 
 
 
 Address of the first word in the page to be erased.   
 
 
          


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint32_t \*</div> page_address - Address of the first word in the page to be erased. 
##flashWordWrite
<br/>
####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>flashWordWrite</div>( <div style='color:#a71d5d; display:inline-block'>uint32_t \*</div> address,  <div style='color:#a71d5d; display:inline-block'>uint32_t</div> value)
#####Description
Method for writing a word of data in flash with a value.  

   
 
 address 
 
 
 Address of the word to change.  
 
 
 
 value 
 
 
 Value to be written to flash.   
 
 
          


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint32_t \*</div> address - Address of the word to change.

>  <div style='color:#a71d5d; display:inline-block'>uint32_t</div> value - Value to be written to flash. 
##put
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>put</div>( <div style='color:#a71d5d; display:inline-block'>const char \*</div> key,  <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> data,  <div style='color:#a71d5d; display:inline-block'>int</div> dataSize)
#####Description
Places a given key, and it's corresponding value into flash at the earliest available point.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>const char \*</div> key - the unique name that should be used as an identifier for the given data. The key is presumed to be null terminated.

>  <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> data - a pointer to the beginning of the data to be persisted.

>  <div style='color:#a71d5d; display:inline-block'>int</div> dataSize - the size of the data to be persisted
#####Returns
MICROBIT_OK on success, MICROBIT_INVALID_PARAMETER if the key or size is too large, MICROBIT_NO_RESOURCES if the storage page is full 
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>put</div>( <div style='color:#a71d5d; display:inline-block'>ManagedString</div> key,  <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> data,  <div style='color:#a71d5d; display:inline-block'>int</div> dataSize)
#####Description
Places a given key, and it's corresponding value into flash at the earliest available point.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>ManagedString</div> key - the unique name that should be used as an identifier for the given data.

>  <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> data - a pointer to the beginning of the data to be persisted.

>  <div style='color:#a71d5d; display:inline-block'>int</div> dataSize - the size of the data to be persisted
#####Returns
MICROBIT_OK on success, MICROBIT_INVALID_PARAMETER if the key or size is too large, MICROBIT_NO_RESOURCES if the storage page is full 
##get
<br/>
####<div style='color:#a71d5d; display:inline-block'>KeyValuePair</div> <div style='color:#795da3; display:inline-block'>get</div>( <div style='color:#a71d5d; display:inline-block'>const char \*</div> key)
#####Description
Retreives a  KeyValuePair  identified by a given key.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>const char \*</div> key - the unique name used to identify a  KeyValuePair  in flash.
#####Returns
a pointer to a heap allocated  KeyValuePair  struct, this pointer will be NULL if the key was not found in storage.

!!! note
    it is up to the user to free memory after use. 

<br/>
####<div style='color:#a71d5d; display:inline-block'>KeyValuePair</div> <div style='color:#795da3; display:inline-block'>get</div>( <div style='color:#a71d5d; display:inline-block'>ManagedString</div> key)
#####Description
Retreives a  KeyValuePair  identified by a given key.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>ManagedString</div> key - the unique name used to identify a  KeyValuePair  in flash.
#####Returns
a pointer to a heap allocated  KeyValuePair  struct, this pointer will be NULL if the key was not found in storage.

!!! note
    it is up to the user to free memory after use. 

##remove
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>remove</div>( <div style='color:#a71d5d; display:inline-block'>const char \*</div> key)
#####Description
Removes a  KeyValuePair  identified by a given key.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>const char \*</div> key - the unique name used to identify a  KeyValuePair  in flash.
#####Returns
MICROBIT_OK on success, or MICROBIT_NO_DATA if the given key was not found in flash. 
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>remove</div>( <div style='color:#a71d5d; display:inline-block'>ManagedString</div> key)
#####Description
Removes a  KeyValuePair  identified by a given key.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>ManagedString</div> key - the unique name used to identify a  KeyValuePair  in flash.
#####Returns
MICROBIT_OK on success, or MICROBIT_NO_DATA if the given key was not found in flash. 
##size
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>size</div>()
#####Description
The size of the flash based  KeyValueStore .  

 


#####Returns
the number of entries in the key value store 
____
[comment]: <> ({"end":"MicroBitStorage"})
