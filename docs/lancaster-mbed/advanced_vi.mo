��    B      ,  Y   <      �  K   �  -   �       E  :  H   �    �  �  �
  �   �  "   B  %   e  #   �  "   �     �     �       .   $  #   S  y   w  �   �  �   x  �     �   �  �   7  �   �  G   �  �   �  Y   |  �   �     �  �   �  9  e  �   �  ~   L  j   �  ]   6  �   �  
  �  X  �  |   �  R   e  �   �  N   u  �   �  �   �  
  _  z   j   q   �   �   W!  E   "     R"  r  o"  s   �&  �   V'  O   �'  +   ,(  +   X(  �   �(  N   	)  X   X)  {   �)  %   -*  =   S*  M   �*    �*  |  �;  1  y>  K   �?  -   �?     %@  `  D@  w   �C  �  D  �  �F  �   �I  *   kJ  ;   �J  *   �J      �J  ;   K  "   ZK  /   }K  G   �K  =   �K  �   3L  �   �L  �   }M  �   N  �   �N  �   �O    oP  q   xQ  �   �Q  m   �R  f  1S     �T  �   �T  �  ?U  �   �V  �   �W  |   fX  b   �X  1  FY  D  xZ  �  �[  �   �]  i   A^  �   �^  q   �_    `  I  .a  [  xb  �   �c  �   �d  �   e  c   �e     Vf  r  sf  s   �j  u   Zk  ?   �k     l     -l  u   Jl  ?   �l  X    m  {   Ym  %   �m  =   �m  M   9n    �n    ��                .      /             !         >      +                  =   	   8   6   :      (      B       <       @   )   $                 
   ?       ,         A      %   1         &   3              2       *   9   '   "   ;   -           4              0      7                 5       #                                      bus.listen(MICROBIT_ID_BUTTON_A, MICROBIT_BUTTON_EVT_CLICK, onPressed);     while(1)
        fiber_sleep(1000);
}
```     while(1)
    {
    }
}
```  - Firstly, create a program that does **not** create or initialise a uBit object.
 - Include `MicroBit.h` (or if you prefer, just the header files of the components you want to use). Including `MicroBit.h` is however, simpler.
 - Instead, create C++ object instances of the classes that you want to use **as global variables** in your program. Create as many components as you need. You are free to use any of the constructors in this documentation.
 - Call functions on those instances to elicit the behaviour you need, using the name of your object instances instead of `uBit.*` !!! warning
    Only change these if you really know what you are doing! !!! warning
    Running a MessageBus without the Fiber Scheduler will result in all event handlers being registered as MESSAGE_BUS_LISTENER_IMMEDIATE (see [`MicroBitMessageBus`](ubit/messageBus.md) for details). This means that your event handler will be executed in the context of the code that raised the event. This may include interrupt context, which may not be safe for all operations. It is recommend that you always run the MessageBus with the Fiber Scheduler in order to allow the event to be decoupled from interrupt context. !!! warning
    micro:bit runtime components should **always** be brought up as global variables. They should **not** be created as local variables - either in your main method or anywhere else. The reason for this is the the runtime is a multi-threaded environment, and any variables created in stack memory (like local variables) may be paged out by the scheduler, and result in instability if they utilise interrupts or are accessed by other threads. So... don't do it! !!!note
    Function calls to `uBit.sleep()` must be replaced with the direct, equivalent calls to the scheduler using `fiber_sleep()`. # Advanced Features of the Runtime ## Compile Time Configuration Options ## Initialising the Fiber Scheduler ## Initialising the Heap Allocator ## Initialising the Message Bus ## System Components ## Using Components Directly ### Compile Time Options with MicroBitConfig.h ### Compile Time Options with Yotta Additionally, the options provided through `config.json` intuitively map onto the `#defines`
listed in `MicroBitConfig.h` Also, it is not really possible to transparently enter a power efficient sleep - as illustrated in the busy loop in the above example. An example of `config.json` in operation is available at the [microbit-samples](https://github.com/lancaster-university/microbit-samples) GitHub repository. For example, if you wanted to create a program that just used the LED matrix display driver, you might write a program like this: From the moment the fiber scheduler is initialised, it is then possible to block the processor in a power efficient way and to operate threaded event handlers: Here's a `config.json`, using all available configuration options, that matches the default values specified in `MicroBitConfig.h`: If a component has a dependency on another component (e.g. in the example below, the accelerometer is dependent on an I2C bus), then this will be requested as a mandatory parameter in the constructor. If you need other components, add them to your program in the same way. In addition to the flexibility to initialise only the components that you need, the runtime also provides a central, compile time configuration file called `MicroBitConfig.h`. Initialising the fiber scheduler is simple, and is demonstrated in the following example. It should be noted that **all** of the above options are optional, and will revert to their default values
if not specified. This means that we can also provide a subset of these options, to configure specific
parts of the runtime: MicroBitDisplay display; MicroBitI2C i2c = MicroBitI2C(I2C_SDA0, I2C_SCL0);
MicroBitAccelerometer accelerometer = MicroBitAccelerometer(i2c);
MicroBitDisplay display; Often when using asynchronous events, it is also useful to run the fiber scheduler. Without a scheduler in operation, all event handlers (such as the one above) will be executed with the threading mode `MESSAGE_BUS_LISTENER_IMMEDIATE`, as
described on the [`MicroBitMessageBus`](ubit/messageBus.md) documentation. Rather than edit the `MicroBitConfig.h` file to change the default behaviour of the runtime, if you are using
`yotta`, you can also provide a `config.json` in your project. See the 'Constructor' section of the each components' API documentation for details and examples.
```cpp
#include "MicroBit.h" Should you wish to also reclaim memory in this way, you can do so as follows:
```c++
#include "MicroBit.h" Taking advantage of the modular structure of the micro:bit runtime is fairly straightforward. The [`MicroBitMessageBus`](ubit/messageBus.md) allows events to be created and delivered to applications.  So if a [`MicroBitMessageBus`](ubit/messageBus.md) is not created, then all events in the micro:bit runtime will be quietly ignored. The `uBit` initialisation function will automatically release any memory unused by the Bluetooth stack for general purpose use in this fashion (this typically provides an additional 1K of SRAM under Bluetooth enabled builds, and another 8K if Bluetooth is disabled). The `uBit` object is provided as a collection of the commonly used components, all gathered together in one place
to make it easier for novice users to access the functionality of the device. However, there is no obligation to
use the `uBit` abstraction. More advanced users may prefer to create and use only the parts of the runtime they
need. The default settings will provide a stable working environment, but advanced users may want to further tailor the behaviour. The following options are configurable at compile time through `MicroBitConfig.h`: The micro:bit runtime provides an optional, heap memory allocator. This is primarily to permit the use of **multiple** regions of memory to be used as heap memory space for your variables. There are also some constants that define the geometry of the micro:bit memory There are also system components that provide background services. Without the `uBit` object, these will not be created by default.  Examples include the fiber scheduler, message bus and heap allocator. This provides more control and often frees up more memory resource for the application program - but does so
at the expense of the user taking more responsibility and additional complexity in their programs. To enable this functionality, simply create an instance of the [`MicroBitMessageBus`](ubit/messageBus.md) class. From that point onward in your program, you can raise and listen for events as described in the [`MicroBitMessageBus`](ubit/messageBus.md) documentation. To tailor the behaviour, simply edit the `MicroBitConfig.h` file to change the settings, and then perform a clean rebuild. Under the surface, the micro:bit runtime is a highly configurable, modular and component based piece of software. You are not required to initialise these components, but you should do so if you want to benefit from the functionality they provide. The following section describe how to do this. You can use this to reconfigure the default behaviour of the runtime. ```c++
#include "MicroBit.h" ```json
{
    "microbit-dal":{
        "bluetooth":{
            "enabled": 1,
            "pairing_mode": 1,
            "private_addressing": 0,
            "open": 0,
            "whitelist": 1,
            "advertising_timeout": 0,
            "tx_power": 0,
            "dfu_service": 1,
            "event_service": 1,
            "device_info_service": 1,
            "eddystone_url": 0
        },
        "reuse_sd": 1,
        "default_pullmode":"PullDown",
        "gatt_table_size": "0x300",
        "heap_allocator": 1,
        "nested_heap_proportion": 0.75,
        "system_tick_period": 6,
        "system_components": 10,
        "idle_components": 6,
        "use_accel_lsb": 0,
        "min_display_brightness": 1,
        "max_display_brightness": 255,
        "display_scroll_speed": 120,
        "display_scroll_stride": -1,
        "display_print_speed": 400,
        "panic_on_heap_full": 1,
        "debug": 0,
        "heap_debug": 0,
        "stack_size":2048,
        "sram_base":"0x20000008",
        "sram_end":"0x20004000",
        "sd_limit":"0x20002000",
        "gatt_table_start":"0x20001900"
    }
}
``` ```json
{
    "microbit-dal":{
        "bluetooth":{
            "open": 1
        },
        "debug":1
    }
}
``` advanced.md:110MicroBitMessageBus bus;
MicroBitButton buttonA(MICROBIT_PIN_BUTTON_A, MICROBIT_ID_BUTTON_A);
MicroBitDisplay display; advanced.md:114void onPressed(MicroBitEvent e)
{
    display.print("S");    
} advanced.md:24```cpp
#include "MicroBit.h" advanced.md:71```cpp
#include "MicroBit.h" advanced.md:74MicroBitMessageBus bus;
MicroBitButton buttonA(MICROBIT_PIN_BUTTON_A, MICROBIT_ID_BUTTON_A);
MicroBitDisplay display; advanced.md:78void onPressed(MicroBitEvent e)
{
    display.print("S");    
} int main()
{
    bus.listen(MICROBIT_ID_BUTTON_A, MICROBIT_BUTTON_EVT_CLICK, onPressed); int main()
{
    microbit_create_heap(MICROBIT_SD_GATT_TABLE_START + MICROBIT_SD_GATT_TABLE_SIZE, MICROBIT_SD_LIMIT);
}
``` int main()
{
    scheduler_init(bus); int main()
{
    while(1)
        display.scroll(":)");
}
``` int main()
{
    while(1)
        display.scroll(accelerometer.getX());
}
``` | Configuration option | Brief Description |
| ------------- |-------------|
| `MICROBIT_HEAP_ALLOCATOR` | Enables or disables the MicroBitHeapAllocator for `uBit` based builds. |
| `MICROBIT_HEAP_BLOCK_SIZE` | The Block size used by the heap allocator in bytes. |
| `MICROBIT_NESTED_HEAP_SIZE` | The proportion of SRAM available on the mbed heap to reserve for the micro:bit heap. |
| `MICROBIT_HEAP_REUSE_SD` | If set to '1', any unused areas of the Soft Device GATT table will be automatically reused as heap memory. |
| `MICROBIT_SD_GATT_TABLE_SIZE` | The amount of memory (bytes) to dedicate to the SoftDevice GATT table. |
| `SYSTEM_TICK_PERIOD_MS` | The default scheduling quantum |
| `EVENT_LISTENER_DEFAUT_FLAGS` | The default threading mode used when a `MicroBitMessageBus` listener is created. |
| `MESSAGE_BUS_LISTENER_MAX_QUEUE_DEPTH` | Maximum event queue depth. If a queue exceeds this depth, further events will be dropped. |
| `MICROBIT_SYSTEM_COMPONENTS` | The maximum size of the interrupt callback list. |
| `MICROBIT_IDLE_COMPONENTS` | The maximum size of the idle callback list. |
| `MICROBIT_BLE_ENABLED` | Enable/Disable Bluetooth during normal operation. If disabled, no Bluetooth communication is possible, but radio functionality is made possible, and an additional 8K of SRAM is released|
| `MICROBIT_BLE_PAIRING_MODE` | Enable/Disable Bluetooth pairing mode with A+B / reset at power up|
| `MICROBIT_BLE_PRIVATE_ADDRESSES` | Enable/Disable the use of private resolvable addresses. **This is known to be a feature that suffers compatibility issues with many Bluetooth central devices.** |
| `MICROBIT_BLE_OPEN` | Enable/Disable Bluetooth security entirely. Open Bluetooth links are not secure, but are highly useful during the development of Bluetooth services|
| `MICROBIT_BLE_SECURITY_LEVEL` | Define the default, global Bluetooth security requirements for MicroBit Bluetooth services|
| `MICROBIT_BLE_WHITELIST` | Enable/Disable the use of Bluetooth whitelisting.|
| `MICROBIT_BLE_ADVERTISING_TIMEOUT` | Define the period of time for which the Bluetooth stack will advertise (seconds).|
| `MICROBIT_BLE_DEFAULT_TX_POWER` | Defines default power level of the Bluetooth radio transmitter.|
| `MICROBIT_BLE_DFU_SERVICE` | Enable/Disable Bluetooth Service: MicroBitDFU. This allows over the air programming during normal operation.|
| `MICROBIT_BLE_EVENT_SERVICE` | Enable/Disable Bluetooth Service: MicroBitEventService. This allows routing of events from the micro:bit message bus over Bluetooth.|
| `MICROBIT_BLE_DEVICE_INFORMATION_SERVICE` | Enable/Disable Bluetooth Service: MicroBitDeviceInformationService. This enables the standard Bluetooth device information service.|
| `MICROBIT_BLE_EDDYSTONE_URL` | Enable/Disable Eddystone URL support. Enabling this enables you to broadcast a physical web url from the microbit |
| `USE_ACCEL_LSB` | Enable 10 bit sampling on the accelerometer. By default, a more efficient 8 bit sampling if used.|
| `MICROBIT_DISPLAY_TYPE` | Selects the default matrix configuration for the display driver.|
| `MICROBIT_DISPLAY_MINIMUM_BRIGHTNESS` | Selects the minimum permissible brightness level for the device.|
| `MICROBIT_DISPLAY_MAXIMUM_BRIGHTNESS` | Selects the maximum permissible brightness level for the device.|
| `MICROBIT_DISPLAY_DEFAULT_BRIGHTNESS` | Selects the default brightness level for the device.|
| `MICROBIT_DEFAULT_SCROLL_SPEED` | Selects the time taken to scroll a single pixel, in milliseconds.|
| `MICROBIT_DEFAULT_SCROLL_STRIDE` | Selects the number of pixels a scroll will move in each quantum.|
| `MICROBIT_DEFAULT_PRINT_SPEED` | Selects the time each character will be shown on the display during print operations, in milliseconds.|
| `MICROBIT_DEFAULT_SERIAL_MODE` | Configures the default serial mode used by serial read and send calls.|
| `MICROBIT_DEFAULT_PULLMODE` | Define the default mode in which the digital input pins are configured. Valid options are PullDown, PullUp and PullNone.|
| `MICROBIT_PANIC_HEAP_FULL` | Enable this to invoke a panic on out of memory conditions.|
| `MICROBIT_DBG` | Enable this to route debug messages through the USB serial interface.|
| `MICROBIT_HEAP_DBG` | Enable this to receive detailed diagnostic messages from the heap allocator via the USB serial interface.|
| `MICROBIT_DAL_VERSION` | Define the default version information of the runtime.| | Configuration option | Brief Description |
| ------------- |-------------|
| `MICROBIT_SRAM_BASE` |  The start address of usable RAM memory. |
| `MICROBIT_SRAM_END` |  The end address of usable RAM memory. |
| `MICROBIT_SD_LIMIT` |  The end address of RAM memory reserved for Soft Device (Nordic's Bluetooth stack). |
| `MICROBIT_SD_GATT_TABLE_START` |  The start address of the Bluetooth GATT table in RAM. |
| `CORTEX_M0_STACK_BASE` | The memory address of the top of the system stack. |
| `MICROBIT_STACK_SIZE` | Amount of memory reserved for the stack (in bytes). |
| `MICROBIT_HEAP_END` | The end address of the mbed heap space | Project-Id-Version: 
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2016-10-31 11:46+0200
PO-Revision-Date: 2016-11-22 15:19+0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 1.8.9
Last-Translator: Doãn Minh Đăng
Language-Team: 
Language: vi
     bus.listen(MICROBIT_ID_BUTTON_A, MICROBIT_BUTTON_EVT_CLICK, onPressed);     while(1)
        fiber_sleep(1000);
}
```     while(1)
    {
    }
}
```  - Thứ nhất, tạo ra một chương trình mà ** không ** tạo ra hoặc khởi tạo một đối tượng uBit.
 - Thêm vào (include) `MicroBit.h` (hoặc nếu bạn thích, chỉ cần các tập tin tiêu đề của các thành phần bạn muốn sử dụng). Tuy nhiên, thêm vào `MicroBit.h` thì đơn giản hơn.
 - Thay vào đó, tạo ra các đối tượng C++ là phiên bản (instance) của các lớp (class) mà bạn muốn sử dụng **như các biến toàn cục** trong chương trình của bạn. Tạo đủ các thành phần như bạn cần. Bạn có thể tự do sử dụng bất kỳ hàm khởi tạo (constructor) nào trong tài liệu này.
 - Gọi các hàm trên các phiên bản đó để thực thi hành vi mà bạn cần, dùng tên của đối tượng phiên bản của bạn thay vì `uBit.*` !!! warning "Cảnh báo" 
 Chỉ thay đổi những điều này nếu bạn thực sự biết mình đang làm gì! !!! warning "Cảnh báo"
 Chạy một MessageBus mà không có trình đặt lịch Fiber sẽ làm cho tất cả các trình xử lý sự kiện được đăng ký là MESSAGE_BUS_LISTENER_IMMEDIATE (xem [`MicroBitMessageBus`](ubit/messageBus.md) để biết chi tiết). Điều này có nghĩa là xử lý sự kiện của bạn sẽ được thực hiện trong context của đoạn mã gây nên sự kiện này. Điều này có thể bao gồm context về ngắt (interrupt), mà có thể không an toàn cho tất cả các hoạt động. Lời khuyên là bạn luôn chạy MessageBus với trình đặt lịch Fiber để cho phép sự kiện để được tách rời khỏi context về ngắt. !!! warning "Cảnh báo" 
  Các thành phần của micro:bit nên **luôn luôn** được đưa lên làm biến toàn cục. Chúng **không nên** được tạo ra ở dạng các biến địa phương - dù là trong hàm "main" ở bất cứ nơi nào khác. Lý do cho điều này là bộ runtime là một môi trường đa luồng, và bất kỳ biến nào được tạo ra trong bộ nhớ stack (như các biến địa phương) có thể bị đẩy ra bởi các trình đặt lịch (scheduler), và dẫn đến sự mất ổn định nếu chúng có sử dụng các ngắt hoặc được truy cập bởi các luồng khác. Vì vậy... đừng làm điều đó! !!! note "Lưu ý"
 Hàm gọi đến `uBit.sleep()` phải được thay thế bằng cách tương đương là gọi trực tiếp đến trình đặt lịch, sử dụng `fiber_sleep()`. # Tính năng nâng cao của bộ Runtime ## Tùy chọn cấu hình vào thời điểm biên dịch ## Khởi tạo trình đặt lịch Fiber ## Khởi tạo heap cấp phát ## Khởi tạo kênh truyền thông điệp (Message Bus) ## Các thành phần hệ thống ## Sử dụng trực tiếp các thành phần ### Tùy chọn vào thời điểm biên dịch với MicroBitConfig.h ### Tùy chọn tại thời điểm biên dịch với Yotta Ngoài ra, các tùy chọn được cung cấp qua `config.json` ánh xạ một cách tự nhiên lên `#defines`
listed in `MicroBitConfig.h` Ngoài ra, không thực sự có thể chuyển gọn vào trạng thái ngủ để tiết kiệm năng lượng - như minh họa trong vòng lặp bận rộn trong ví dụ trên. Một ví dụ của `config.json` khi hoạt động có tại  kho GitHub [microbit-samples](https://github.com/lancaster-university/microbit-samples). Ví dụ, nếu bạn muốn tạo ra một chương trình chỉ sử dụng driver điều khiển màn hình LED ma trận, bạn có thể viết một chương trình như thế này: Từ thời điểm trình đặt lịch fiber được khởi tạo, sau đó nó có thể chặn bộ xử lý bằng một cách tiết kiệm năng lượng và điều hành các luồng xử lý sự kiện: Dưới đây là một `config.json`, sử dụng tất cả các tùy chọn cấu hình có sẵn, phù hợp với các giá trị mặc định được quy định trong `MicroBitConfig.h`: Nếu một thành phần phụ thuộc vào một thành phần khác (như trong ví dụ dưới đây, gia tốc phụ thuộc vào một đường truyền I2C), thì cái này sẽ được yêu cầu là một tham số bắt buộc trong hàm khởi tạo. Nếu bạn cần các thành phần khác, thêm chúng vào chương trình của bạn với cùng cách đó. Ngoài sự linh hoạt để khởi tạo chỉ những thành phần mà bạn cần, bộ runtime cũng cung cấp ở trung tâm một tập tin cấu hình thời gian biên dịch, gọi là `MicroBitConfig.h`. Khởi tạo trình đặt lịch fiber là đơn giản, và được thể hiện trong ví dụ sau đây. Cần lưu ý rằng **tất cả** các tùy chọn ở trên là tùy chọn, và sẽ trở lại giá trị mặc định của chúng 
 nếu không được nhắc đến. Điều này có nghĩa rằng chúng ta cũng có thể cung cấp một tập hợp con của các tùy chọn này, để cấu hình
 các phần cụ thể của bộ runtime: MicroBitDisplay display; MicroBitI2C i2c = MicroBitI2C(I2C_SDA0, I2C_SCL0);
MicroBitAccelerometer accelerometer = MicroBitAccelerometer(i2c);
MicroBitDisplay display; Thông thường khi sử dụng các sự kiện không đồng bộ, dùng các trình đặt lịch Fiber cũng sẽ hữu ích. Nếu không có một trình xếp lịch đang hoạt động, tất cả các trình xử lý sự kiện (chẳng hạn như cái ở trên) sẽ được thực hiện với chế độ luồng `MESSAGE_BUS_LISTENER_IMMEDIATE`, 
 như mô tả trên tài liệu [`MicroBitMessageBus`](ubit/messageBus.md). Thay vì chỉnh sửa file `MicroBitConfig.h` để thay đổi hành vi mặc định của bộ runtime, nếu bạn đang sử dụng
 `yotta`, bạn cũng có thể cung cấp một `config.json` trong dự án của bạn. Xem phần 'Constructor' của tài liệu API mỗi thành phần để biết chi tiết và ví dụ. 
```cpp
#include "MicroBit.h" Nếu bạn muốn cũng lấy lại bộ nhớ theo cách này, bạn có thể làm như sau:
```c++
#include "MicroBit.h" Tận dụng lợi thế của cấu trúc mô-đun của micro:bit runtime là khá đơn giản. Các [`MicroBitMessageBus`](ubit/messageBus.md) cho phép các sự kiện được tạo ra và chuyển tới các ứng dụng. Vì vậy, nếu một [`MicroBitMessageBus`](ubit/messageBus.md) không được tạo ra, thì tất cả các sự kiện micro:bit runtime sẽ bị lặng lẽ bỏ qua. Hàm khởi tạo `uBit` sẽ tự động giải phóng bộ nhớ nào không dùng bởi ngăn xếp Bluetooth để phục vụ mục đích dùng chung theo cách này (điều này thường cung cấp thêm 1K của SRAM trong các bản biên dịch có dùng Bluetooth, và 8K nếu Bluetooth bị vô hiệu hóa). Các đối tượng `uBit` được cung cấp như một bộ sưu tập của các thành phần thường được sử dụng, tất cả tập trung lại với nhau ở một nơi
 giúp người dùng mới dễ truy cập vào các chức năng của thiết bị. Tuy nhiên, không bắt buộc phải
 dùng `uBit` trừu tượng. Người dùng cao cấp hơn có thể thích tạo ra và chỉ sử dụng các bộ phận của runtime mà họ cần. Các thiết lập mặc định sẽ cung cấp một môi trường làm việc ổn định, nhưng người dùng cao cấp có thể muốn chỉnh sửa thêm hành vi. Các tùy chọn sau đây được cấu hình tại thời điểm biên dịch qua `MicroBitConfig.h`: Các micro:bit runtime cung cấp một trình cấp phát bộ nhớ heap tùy chọn. Điều này chủ yếu là để cho phép sử dụng **nhiều** vùng của bộ nhớ như là không gian bộ nhớ heap cho các biến của bạn. Ngoài ra còn có một số hằng số định nghĩa (kích thước) hình học của bộ nhớ micro:bit. Ngoài ra còn có các thành phần hệ thống cung cấp các dịch vụ nền. Nếu không có đối tượng `uBit`, những cái này sẽ không được tạo ra một cách mặc định. Ví dụ như trình đặt lịch fiber, bus truyền tin và heap cấp phát. Điều này cung cấp khả năng kiểm soát nhiều hơn và thường giải phóng nhiều tài nguyên bộ nhớ cho chương trình ứng dụng - nhưng làm như vậy 
 cũng có cái giá là người lập trình cần đảm nhận trách nhiệm và sự phức tạp lớn hơn trong chương trình của họ. Để kích hoạt chức năng này, bạn chỉ cần tạo một phiên bản của lớp [`MicroBitMessageBus`](ubit/messageBus.md). Từ thời điểm đó trở đi trong chương trình của bạn, bạn có thể tạo ra và lắng nghe các sự kiện như mô tả trong phần tài liệu [`MicroBitMessageBus`](ubit/messageBus.md). Để chỉnh hành vi, chỉ cần chỉnh sửa file `MicroBitConfig.h` để thay đổi các thiết lập, và sau đó biên dịch lại từ đầu (clean rebuild). Ở tầng dưới, micro:bit runtime là một phần mềm có khả năng tùy biến cao, có tính mô-đun và dựa trên các bộ phận. Bạn không cần phải khởi tạo các thành phần này, nhưng bạn nên làm như vậy nếu bạn muốn dùng chức năng chúng cung cấp. Phần sau đây mô tả làm thế nào để làm điều này. Bạn có thể sử dụng để cấu hình lại các hành vi mặc định của bộ runtime. ```c++
#include "MicroBit.h" ```json
{
    "microbit-dal":{
        "bluetooth":{
            "enabled": 1,
            "pairing_mode": 1,
            "private_addressing": 0,
            "open": 0,
            "whitelist": 1,
            "advertising_timeout": 0,
            "tx_power": 0,
            "dfu_service": 1,
            "event_service": 1,
            "device_info_service": 1,
            "eddystone_url": 0
        },
        "reuse_sd": 1,
        "default_pullmode":"PullDown",
        "gatt_table_size": "0x300",
        "heap_allocator": 1,
        "nested_heap_proportion": 0.75,
        "system_tick_period": 6,
        "system_components": 10,
        "idle_components": 6,
        "use_accel_lsb": 0,
        "min_display_brightness": 1,
        "max_display_brightness": 255,
        "display_scroll_speed": 120,
        "display_scroll_stride": -1,
        "display_print_speed": 400,
        "panic_on_heap_full": 1,
        "debug": 0,
        "heap_debug": 0,
        "stack_size":2048,
        "sram_base":"0x20000008",
        "sram_end":"0x20004000",
        "sd_limit":"0x20002000",
        "gatt_table_start":"0x20001900"
    }
}
``` ```json
{
    "microbit-dal":{
        "bluetooth":{
            "open": 1
        },
        "debug":1
    }
}
``` MicroBitMessageBus bus;
MicroBitButton buttonA(MICROBIT_PIN_BUTTON_A, MICROBIT_ID_BUTTON_A);
MicroBitDisplay display; void onPressed(MicroBitEvent e)
{
    display.print("S");    
} ```cpp
#include "MicroBit.h" ```cpp
#include "MicroBit.h" MicroBitMessageBus bus;
MicroBitButton buttonA(MICROBIT_PIN_BUTTON_A, MICROBIT_ID_BUTTON_A);
MicroBitDisplay display; void onPressed(MicroBitEvent e)
{
    display.print("S");    
} int main()
{
    bus.listen(MICROBIT_ID_BUTTON_A, MICROBIT_BUTTON_EVT_CLICK, onPressed); int main()
{
    microbit_create_heap(MICROBIT_SD_GATT_TABLE_START + MICROBIT_SD_GATT_TABLE_SIZE, MICROBIT_SD_LIMIT);
}
``` int main()
{
    scheduler_init(bus); int main()
{
    while(1)
        display.scroll(":)");
}
``` int main()
{
    while(1)
        display.scroll(accelerometer.getX());
}
``` | Tùy chọn cấu hình | Mô tả tóm tắt | 
 | ------------- | ------------- | 
 | `MICROBIT_HEAP_ALLOCATOR` | Cho phép hoặc vô hiệu hóa các MicroBitHeapAllocator cho các bản biên dịch dựa trên `uBit`. | 
 | `MICROBIT_HEAP_BLOCK_SIZE` | Kích thước khối được sử dụng bởi bộ cấp phát heap theo số byte. | 
 | `MICROBIT_NESTED_HEAP_SIZE` | Tỷ lệ SRAM có sẵn trên mbed heap để dành cho micro:bit heap. | 
 | `MICROBIT_HEAP_REUSE_SD` | Nếu đặt là '1', bất kỳ khu vực chưa sử dụng nào của bảng Soft Device GATT sẽ được tự động tái sử dụng như là bộ nhớ heap. | 
 | `MICROBIT_SD_GATT_TABLE_SIZE` | Số lượng bộ nhớ (byte) để dành cho bảng Soft Device GATT. | 
 | `SYSTEM_TICK_PERIOD_MS` | Trình đặt lịch cơ sở mặc định | 
 | `EVENT_LISTENER_DEFAUT_FLAGS` | Chế độ luồng mặc định được sử dụng khi một trình lắng nghe `MicroBitMessageBus` được tạo ra. | 
 | `MESSAGE_BUS_LISTENER_MAX_QUEUE_DEPTH` | Độ sâu tối đa của hàng đợi sự kiện. Nếu một hàng đợi vượt quá độ sâu này, các sự kiện sau đó sẽ bị bỏ. | 
 | `MICROBIT_SYSTEM_COMPONENTS` | Kích thước tối đa của danh sách gọi lại ngắt. | 
 | `MICROBIT_IDLE_COMPONENTS` | Kích thước tối đa của danh sách gọi lại nhàn rỗi. | 
 | `MICROBIT_BLE_ENABLED` | Bật / Tắt Bluetooth trong khi hoạt động bình thường. Nếu bị vô hiệu, không thể giao tiếp Bluetooth, nhưng chức năng radio có thể được thực hiện, và có thêm 8K của SRAM được giải tỏa | 
 | `MICROBIT_BLE_PAIRING_MODE` | Bật / Tắt Bluetooth chế độ ghép nối với A+B / thiết lập lại khi mới cấp điện | 
 | `MICROBIT_BLE_PRIVATE_ADDRESSES` | Kích hoạt / Vô hiệu hóa việc sử dụng các địa chỉ riêng phân giải được. **Tính năng này được biết là gặp vấn đề tương thích với nhiều thiết bị trung tâm Bluetooth**. | 
 | `MICROBIT_BLE_OPEN` | Bật / Tắt việc bảo mật Bluetooth toàn diện. Mở liên kết Bluetooth là không an toàn, nhưng rất hữu ích trong việc phát triển các dịch vụ Bluetooth. | 
 | `MICROBIT_BLE_SECURITY_LEVEL` | Xác định các yêu cầu bảo mật toàn cục, mặc định cho các dịch vụ Bluetooth | 
 | `MICROBIT_BLE_WHITELIST` | Kích hoạt / Vô hiệu hóa việc sử dụng các danh sách trắng Bluetooth. | 
 | `MICROBIT_BLE_ADVERTISING_TIMEOUT` | Xác định khoảng thời gian mà các ngăn xếp Bluetooth sẽ quảng cáo (giây). | 
 | `MICROBIT_BLE_DEFAULT_TX_POWER` | Xác định mức năng lượng mặc định của bộ phát vô tuyến Bluetooth. | 
 | `MICROBIT_BLE_DFU_SERVICE` | Kích hoạt / Vô hiệu hoá dịch vụ Bluetooth: MicroBitDFU. Điều này cho phép các lập trình lại thiết bị trực tiếp (over the air) trong quá trình hoạt động bình thường. | 
 | `MICROBIT_BLE_EVENT_SERVICE` | Kích hoạt / Vô hiệu hoá dịch vụ Bluetooth: MicroBitEventService. Điều này cho phép chuyển các sự kiện từ bus thông điệp micro:bit qua Bluetooth. | 
 | `MICROBIT_BLE_DEVICE_INFORMATION_SERVICE` | Kích hoạt / Vô hiệu hoá dịch vụ Bluetooth: MicroBitDeviceInformationService. Dùng để bật các dịch vụ thông tin chuẩn của thiết bị Bluetooth. | 
 | `MICROBIT_BLE_EDDYSTONE_URL` | Kích hoạt / Vô hiệu hoá hỗ trợ URL Eddystone. Bật tính năng này cho phép bạn để phát sóng một url web vật lý từ micro:bit. | 
 | `USE_ACCEL_LSB` | Kích hoạt tính năng lấy mẫu 10 bit trên máy đo gia tốc. Chế độ mặc định sử dụng các lấy mẫu 8 bit tiết kiệm năng lượng hơn. | 
 | `MICROBIT_DISPLAY_TYPE` | Chọn cấu hình ma trận mặc định cho driver điều khiển hiển thị. | 
 | `MICROBIT_DISPLAY_MINIMUM_BRIGHTNESS` | Chọn mức độ sáng tối thiểu cho phép của thiết bị. | 
 | `MICROBIT_DISPLAY_MAXIMUM_BRIGHTNESS` | Chọn mức độ sáng tối đa cho phép của thiết bị. | 
 | `MICROBIT_DISPLAY_DEFAULT_BRIGHTNESS` | Chọn mức độ sáng mặc định cho thiết bị. | 
 | `MICROBIT_DEFAULT_SCROLL_SPEED` | Chọn thời gian dùng để cuộn một điểm ảnh duy nhất, trong mili giây. | 
 | `MICROBIT_DEFAULT_SCROLL_STRIDE` | Chọn số lượng điểm ảnh mà một cuộn sẽ di chuyển trong từng lượt. | 
 | `MICROBIT_DEFAULT_PRINT_SPEED` | Chọn thời gian mỗi ký tự sẽ được hiển thị trên màn hình trong các hoạt động in ra màn hình, trong mili giây. | 
 | `MICROBIT_DEFAULT_SERIAL_MODE` | Cấu hình mặc định chế độ giao tiếp nối tiếp (serial) được sử dụng bởi các lệnh đọc và ghi serial. | 
 | `MICROBIT_DEFAULT_PULLMODE` | Xác định chế độ mặc định để cấu hình các chân đầu vào kỹ thuật số. Các lựa chọn hợp lệ là PullDown, PullUp và PullNone. | 
 | `MICROBIT_PANIC_HEAP_FULL` | Kích hoạt tính năng này để tạo một báo động (panic) về những hoàn cảnh hết bộ nhớ. | 
 | `MICROBIT_DBG` | Kích hoạt tính năng này để chuyển thông điệp debug qua giao diện nối tiếp USB. | 
 | `MICROBIT_HEAP_DBG` | Kích hoạt tính năng này để nhận tin nhắn chẩn đoán chi tiết từ bộ cấp phát heap qua giao diện nối tiếp USB. | 
 | `MICROBIT_DAL_VERSION` | Xác định thông tin phiên bản mặc định của bộ runtime. | | Tùy chọn cấu hình | Mô tả tóm tắt | 
| ------------- |-------------|
| `MICROBIT_SRAM_BASE` |  Địa chỉ bắt đầu của bộ nhớ RAM có thể sử dụng. |
| `MICROBIT_SRAM_END` |  Địa chỉ cuối của bộ nhớ RAM có thể sử dụng. |
| `MICROBIT_SD_LIMIT` |  Địa chỉ cuối của bộ nhớ RAM để dành cho Soft Device (Nordic's Bluetooth stack). |
| `MICROBIT_SD_GATT_TABLE_START` |  Địa chỉ bắt đầu của bảng Bluetooth GATT table trong RAM. |
| `CORTEX_M0_STACK_BASE` | Địa chỉ bộ nhớ ở trên cùng của stack hệ thống. |
| `MICROBIT_STACK_SIZE` | Lượng bộ nhớ để dành cho stack (tính theo byte). |
| `MICROBIT_HEAP_END` | Địa chỉ cuối cùng của không gian mbed heap. | 