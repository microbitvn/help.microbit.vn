#uBit.radio.datagram

##Overview

This is the most flexible way to use the radio, and lets you easily send and receive up to 32 bytes of data at a time.
This data can be provided as array of bytes, a text string, or [`PacketBuffer`](../data-types/packetbuffer.md).

You can send a packet at any time using the `uBit.radio.datagram.send` function.

Any other micro:bits in range will detect the transmitted packet, and make the packet available through the
`uBit.radio.datagram.recv` function.

Any micro:bits receiving a datagram packet will also raise a `MICROBIT_RADIO_EVT_DATAGRAM` event to indicate
that some data is ready to be read.

For example, imagine you were creating a simple remote control car with one micro:bit acting as a remote controller, and another connected to some servos on the car.

You might decide that simply sending a `1` means turn left, and a `2` means turn right, so you may write a program like this for the remote control:

```cpp
int main()
{
    uBit.radio.enable();

    while(1)
    {
        if (uBit.buttonA.isPressed())
            uBit.radio.datagram.send("1");

        else if (uBit.buttonB.isPressed())
            uBit.radio.datagram.send("2");

        uBit.sleep(100);
    }
}
```

...and one like this for the remote control car:


```cpp
void onData(MicroBitEvent e)
{
    ManagedString s = uBit.radio.datagram.recv();

    if (s == "1")
        uBit.io.P0.setServoValue(0);

    if (s == "2")
        uBit.io.P0.setServoValue(180);
}

int main()
{
    uBit.messageBus.listen(MICROBIT_ID_RADIO, MICROBIT_RADIO_EVT_DATAGRAM, onData);
    uBit.radio.enable();

    while(1)
        uBit.sleep(1000);
}
```

##Message Bus ID

> None.

##Message Bus Events

> None.

#API
[comment]: <> ({"className":"MicroBitRadioDatagram"})
##Constructor
<br/>
####MicroBitRadioDatagram( <div style='color:#a71d5d; display:inline-block'>MicroBitRadio  &</div> r)
#####Description
Constructor.  

 Creates an instance of a  MicroBitRadioDatagram  which offers the ability to broadcast simple text or binary messages to other micro:bits in the vicinity  

   
 
 r 
 
 
 The underlying radio module used to send and receive data.   
 
 
          


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitRadio  &</div> r - The underlying radio module used to send and receive data. 
##recv
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>recv</div>( <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> buf,  <div style='color:#a71d5d; display:inline-block'>int</div> len)
#####Description
Retrieves packet payload data into the given buffer.  

 If a data packet is already available, then it will be returned immediately to the caller. If no data is available then MICROBIT_INVALID_PARAMETER is returned.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> buf - A pointer to a valid memory location where the received data is to be stored

>  <div style='color:#a71d5d; display:inline-block'>int</div> len - The maximum amount of data that can safely be stored in 'buf'
#####Returns
The length of the data stored, or MICROBIT_INVALID_PARAMETER if no data is available, or the memory regions provided are invalid. 
<br/>
####<div style='color:#a71d5d; display:inline-block'>PacketBuffer</div> <div style='color:#795da3; display:inline-block'>recv</div>()
#####Description
Retreives packet payload data into the given buffer.  

 If a data packet is already available, then it will be returned immediately to the caller in the form of a  PacketBuffer .  

 


#####Returns
the data received, or an empty  PacketBuffer  if no data is available. 
##send
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>send</div>( <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> buffer,  <div style='color:#a71d5d; display:inline-block'>int</div> len)
#####Description
Transmits the given buffer onto the broadcast radio.  

 This is a synchronous call that will wait until the transmission of the packet has completed before returning.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint8_t \*</div> buffer - The packet contents to transmit.

>  <div style='color:#a71d5d; display:inline-block'>int</div> len - The number of bytes to transmit.
#####Returns
MICROBIT_OK on success, or MICROBIT_INVALID_PARAMETER if the buffer is invalid, or the number of bytes to transmit is greater than  MICROBIT_RADIO_MAX_PACKET_SIZE + MICROBIT_RADIO_HEADER_SIZE . 
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>send</div>( <div style='color:#a71d5d; display:inline-block'>PacketBuffer</div> data)
#####Description
Transmits the given string onto the broadcast radio.  

 This is a synchronous call that will wait until the transmission of the packet has completed before returning.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>PacketBuffer</div> data - The packet contents to transmit.
#####Returns
MICROBIT_OK on success, or MICROBIT_INVALID_PARAMETER if the buffer is invalid, or the number of bytes to transmit is greater than  MICROBIT_RADIO_MAX_PACKET_SIZE + MICROBIT_RADIO_HEADER_SIZE . 
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>send</div>( <div style='color:#a71d5d; display:inline-block'>ManagedString</div> data)
#####Description
Transmits the given string onto the broadcast radio.  

 This is a synchronous call that will wait until the transmission of the packet has completed before returning.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>ManagedString</div> data - The packet contents to transmit.
#####Returns
MICROBIT_OK on success, or MICROBIT_INVALID_PARAMETER if the buffer is invalid, or the number of bytes to transmit is greater than  MICROBIT_RADIO_MAX_PACKET_SIZE + MICROBIT_RADIO_HEADER_SIZE . 
##packetReceived
<br/>
####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>packetReceived</div>()
#####Description
Protocol handler callback. This is called when the radio receives a packet marked as a datagram.  

 This function process this packet, and queues it for user reception.           


____
[comment]: <> ({"end":"MicroBitRadioDatagram"})
