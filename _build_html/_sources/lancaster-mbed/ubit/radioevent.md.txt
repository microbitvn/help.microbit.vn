#uBit.radio.event

##Overview

It is also possible to transparently send and receive events over the `MicroBitRadio` channel. This can provide very simple and easy to integrate
support for event driven applications. Once configured, an event raised on one micro:bit can be detected on another - in the just the same way as
a local event such as a button click.

To use this functionality, all that is needed is to register the event codes that you would like to be sent over the radio, then write event handlers
for the message bus as with all other events. See the documentation for the [`MicroBitMessageBus`](messageBus.md) for details of how to write
event handlers.

For example, if you wanted to share an event SOMETHING with another micro:bit whenever ButtonA is pressed, you might write code like this on the sending micro:bit:

```cpp
#define MY_APP_ID           4000
#define SOMETHING           1

int main()
{
    uBit.radio.enable();

    // Ensure the radio is listening out to forward our events
    uBit.radio.event.listen(MY_APP_ID, MICROBIT_EVT_ANY);

    while(1)
    {
        if (uBit.buttonA.isPressed())
            MicroBitEvent(MY_APP_ID, SOMETHING);

        uBit.sleep(1000);
    }
}
```

...and on the micro:bits wanting to receive the event:


```cpp
#define MY_APP_ID           4000
#define SOMETHING           1

void onSomething(MicroBitEvent e)
{
    uBit.display.scrollAsync("Something!");
}

int main()
{
    uBit.messageBus.listen(MY_APP_ID, SOMETHING, onSomething);
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
[comment]: <> ({"className":"MicroBitRadioEvent"})
##Constructor
<br/>
####MicroBitRadioEvent( <div style='color:#a71d5d; display:inline-block'>MicroBitRadio  &</div> r)
#####Description
Constructor.  

 Creates an instance of  MicroBitRadioEvent  which offers the ability to extend the micro:bit's default  EventModel  to other micro:bits in the vicinity.  

   
 
 r 
 
 
 The underlying radio module used to send and receive data.   
 
 
          


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitRadio  &</div> r - The underlying radio module used to send and receive data. 
##listen
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>listen</div>( <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id,  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> value)
#####Description
Associates the given event with the radio channel.  

 Once registered, all events matching the given registration sent to this micro:bit's default  EventModel  will be automatically retransmitted on the radio.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id - The id of the event to register.

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> value - the value of the event to register.
#####Returns
MICROBIT_OK on success, or MICROBIT_NO_RESOURCES if no default  EventModel  is available.

!!! note
    The wildcards MICROBIT_ID_ANY and MICROBIT_EVT_ANY can also be in place of the id and value fields. 

<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>listen</div>( <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id,  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> value,  <div style='color:#a71d5d; display:inline-block'>EventModel  &</div> eventBus)
#####Description
Associates the given event with the radio channel.  

 Once registered, all events matching the given registration sent to the given  EventModel  will be automatically retransmitted on the radio.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id - The id of the events to register.

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> value - the value of the event to register.

>  <div style='color:#a71d5d; display:inline-block'>EventModel  &</div> eventBus - The  EventModel  to listen for events on.
#####Returns
MICROBIT_OK on success.

!!! note
    The wildcards MICROBIT_ID_ANY and MICROBIT_EVT_ANY can also be in place of the id and value fields. 

##ignore
<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>ignore</div>( <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id,  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> value)
#####Description
Disassociates the given event with the radio channel.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id - The id of the events to deregister.

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> value - The value of the event to deregister.
#####Returns
MICROBIT_OK on success, or MICROBIT_INVALID_PARAMETER if the default message bus does not exist.

!!! note
    MICROBIT_EVT_ANY can be used to deregister all event values matching the given id. 

<br/>
####<div style='color:#a71d5d; display:inline-block'>int</div> <div style='color:#795da3; display:inline-block'>ignore</div>( <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id,  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> value,  <div style='color:#a71d5d; display:inline-block'>EventModel  &</div> eventBus)
#####Description
Disassociates the given events with the radio channel.  

 


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> id - The id of the events to deregister.

>  <div style='color:#a71d5d; display:inline-block'>uint16_t</div> value - The value of the event to deregister.

>  <div style='color:#a71d5d; display:inline-block'>EventModel  &</div> eventBus - The  EventModel  to deregister on.
#####Returns
MICROBIT_OK on success.

!!! note
    MICROBIT_EVT_ANY can be used to deregister all event values matching the given id. 

##packetReceived
<br/>
####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>packetReceived</div>()
#####Description
Protocol handler callback. This is called when the radio receives a packet marked as using the event protocol.  

 This function process this packet, and fires the event contained inside onto the default  EventModel .           


##eventReceived
<br/>
####<div style='color:#a71d5d; display:inline-block'>void</div> <div style='color:#795da3; display:inline-block'>eventReceived</div>( <div style='color:#a71d5d; display:inline-block'>MicroBitEvent</div> e)
#####Description
Event handler callback. This is called whenever an event is received matching one of those registered through the registerEvent() method described above. Upon receiving such an event, it is wrapped into a radio packet and transmitted to any other micro:bits in the same group.           


#####Parameters

>  <div style='color:#a71d5d; display:inline-block'>MicroBitEvent</div> e
____
[comment]: <> ({"end":"MicroBitRadioEvent"})
