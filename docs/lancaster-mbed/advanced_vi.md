# Tính năng nâng cao của bộ Runtime

Ở tầng dưới, micro:bit runtime là một phần mềm có khả năng tùy biến cao, có tính mô-đun và dựa trên các bộ phận.

Các đối tượng `uBit` được cung cấp như một bộ sưu tập của các thành phần thường được sử dụng, tất cả tập trung lại với nhau ở một nơi
 giúp người dùng mới dễ truy cập vào các chức năng của thiết bị. Tuy nhiên, không bắt buộc phải
 dùng `uBit` trừu tượng. Người dùng cao cấp hơn có thể thích tạo ra và chỉ sử dụng các bộ phận của runtime mà họ cần.

Điều này cung cấp khả năng kiểm soát nhiều hơn và thường giải phóng nhiều tài nguyên bộ nhớ cho chương trình ứng dụng - nhưng làm như vậy 
 cũng có cái giá là người lập trình cần đảm nhận trách nhiệm và sự phức tạp lớn hơn trong chương trình của họ.

## Sử dụng trực tiếp các thành phần

Tận dụng lợi thế của cấu trúc mô-đun của micro:bit runtime là khá đơn giản.

 - Thứ nhất, tạo ra một chương trình mà ** không ** tạo ra hoặc khởi tạo một đối tượng uBit.
 - Thêm vào (include) `MicroBit.h` (hoặc nếu bạn thích, chỉ cần các tập tin tiêu đề của các thành phần bạn muốn sử dụng). Tuy nhiên, thêm vào `MicroBit.h` thì đơn giản hơn.
 - Thay vào đó, tạo ra các đối tượng C++ là phiên bản (instance) của các lớp (class) mà bạn muốn sử dụng **như các biến toàn cục** trong chương trình của bạn. Tạo đủ các thành phần như bạn cần. Bạn có thể tự do sử dụng bất kỳ hàm khởi tạo (constructor) nào trong tài liệu này.
 - Gọi các hàm trên các phiên bản đó để thực thi hành vi mà bạn cần, dùng tên của đối tượng phiên bản của bạn thay vì `uBit.*`

Ví dụ, nếu bạn muốn tạo ra một chương trình chỉ sử dụng driver điều khiển màn hình LED ma trận, bạn có thể viết một chương trình như thế này:

```cpp
#include "MicroBit.h"

MicroBitDisplay display;

int main()
{
    while(1)
        display.scroll(":)");
}
```

Nếu bạn cần các thành phần khác, thêm chúng vào chương trình của bạn với cùng cách đó.

Nếu một thành phần phụ thuộc vào một thành phần khác (như trong ví dụ dưới đây, gia tốc phụ thuộc vào một đường truyền I2C), thì cái này sẽ được yêu cầu là một tham số bắt buộc trong hàm khởi tạo.

Xem phần 'Constructor' của tài liệu API mỗi thành phần để biết chi tiết và ví dụ. 
```cpp
#include "MicroBit.h"

MicroBitI2C i2c = MicroBitI2C(I2C_SDA0, I2C_SCL0);
MicroBitAccelerometer accelerometer = MicroBitAccelerometer(i2c);
MicroBitDisplay display;

int main()
{
    while(1)
        display.scroll(accelerometer.getX());
}
```

!!! warning "Cảnh báo" 
  Các thành phần của micro:bit nên **luôn luôn** được đưa lên làm biến toàn cục. Chúng **không nên** được tạo ra ở dạng các biến địa phương - dù là trong hàm "main" ở bất cứ nơi nào khác. Lý do cho điều này là bộ runtime là một môi trường đa luồng, và bất kỳ biến nào được tạo ra trong bộ nhớ stack (như các biến địa phương) có thể bị đẩy ra bởi các trình đặt lịch (scheduler), và dẫn đến sự mất ổn định nếu chúng có sử dụng các ngắt hoặc được truy cập bởi các luồng khác. Vì vậy... đừng làm điều đó!

## Các thành phần hệ thống

Ngoài ra còn có các thành phần hệ thống cung cấp các dịch vụ nền. Nếu không có đối tượng `uBit`, những cái này sẽ không được tạo ra một cách mặc định. Ví dụ như trình đặt lịch fiber, bus truyền tin và heap cấp phát.

Bạn không cần phải khởi tạo các thành phần này, nhưng bạn nên làm như vậy nếu bạn muốn dùng chức năng chúng cung cấp. Phần sau đây mô tả làm thế nào để làm điều này.

## Khởi tạo kênh truyền thông điệp (Message Bus)

Các [`MicroBitMessageBus`](ubit/messageBus.md) cho phép các sự kiện được tạo ra và chuyển tới các ứng dụng. Vì vậy, nếu một [`MicroBitMessageBus`](ubit/messageBus.md) không được tạo ra, thì tất cả các sự kiện micro:bit runtime sẽ bị lặng lẽ bỏ qua.

Để kích hoạt chức năng này, bạn chỉ cần tạo một phiên bản của lớp [`MicroBitMessageBus`](ubit/messageBus.md). Từ thời điểm đó trở đi trong chương trình của bạn, bạn có thể tạo ra và lắng nghe các sự kiện như mô tả trong phần tài liệu [`MicroBitMessageBus`](ubit/messageBus.md).

```cpp
#include "MicroBit.h"

MicroBitMessageBus bus;
MicroBitButton buttonA(MICROBIT_PIN_BUTTON_A, MICROBIT_ID_BUTTON_A);
MicroBitDisplay display;

void onPressed(MicroBitEvent e)
{
    display.print("S");    
}

int main()
{
    bus.listen(MICROBIT_ID_BUTTON_A, MICROBIT_BUTTON_EVT_CLICK, onPressed);

    while(1)
    {
    }
}
```

!!! warning "Cảnh báo"
 Chạy một MessageBus mà không có trình đặt lịch Fiber sẽ làm cho tất cả các trình xử lý sự kiện được đăng ký là MESSAGE_BUS_LISTENER_IMMEDIATE (xem [`MicroBitMessageBus`](ubit/messageBus.md) để biết chi tiết). Điều này có nghĩa là xử lý sự kiện của bạn sẽ được thực hiện trong context của đoạn mã gây nên sự kiện này. Điều này có thể bao gồm context về ngắt (interrupt), mà có thể không an toàn cho tất cả các hoạt động. Lời khuyên là bạn luôn chạy MessageBus với trình đặt lịch Fiber để cho phép sự kiện để được tách rời khỏi context về ngắt.

## Khởi tạo trình đặt lịch Fiber

Thông thường khi sử dụng các sự kiện không đồng bộ, dùng các trình đặt lịch Fiber cũng sẽ hữu ích. Nếu không có một trình xếp lịch đang hoạt động, tất cả các trình xử lý sự kiện (chẳng hạn như cái ở trên) sẽ được thực hiện với chế độ luồng `MESSAGE_BUS_LISTENER_IMMEDIATE`, 
 như mô tả trên tài liệu [`MicroBitMessageBus`](ubit/messageBus.md).

Ngoài ra, không thực sự có thể chuyển gọn vào trạng thái ngủ để tiết kiệm năng lượng - như minh họa trong vòng lặp bận rộn trong ví dụ trên.

Khởi tạo trình đặt lịch fiber là đơn giản, và được thể hiện trong ví dụ sau đây.

Từ thời điểm trình đặt lịch fiber được khởi tạo, sau đó nó có thể chặn bộ xử lý bằng một cách tiết kiệm năng lượng và điều hành các luồng xử lý sự kiện:

```c++
#include "MicroBit.h"

MicroBitMessageBus bus;
MicroBitButton buttonA(MICROBIT_PIN_BUTTON_A, MICROBIT_ID_BUTTON_A);
MicroBitDisplay display;

void onPressed(MicroBitEvent e)
{
    display.print("S");    
}

int main()
{
    scheduler_init(bus);

    bus.listen(MICROBIT_ID_BUTTON_A, MICROBIT_BUTTON_EVT_CLICK, onPressed);

    while(1)
        fiber_sleep(1000);
}
```

!!! note "Lưu ý"
 Hàm gọi đến `uBit.sleep()` phải được thay thế bằng cách tương đương là gọi trực tiếp đến trình đặt lịch, sử dụng `fiber_sleep()`.

## Khởi tạo heap cấp phát

Các micro:bit runtime cung cấp một trình cấp phát bộ nhớ heap tùy chọn. Điều này chủ yếu là để cho phép sử dụng **nhiều** vùng của bộ nhớ như là không gian bộ nhớ heap cho các biến của bạn.

Hàm khởi tạo `uBit` sẽ tự động giải phóng bộ nhớ nào không dùng bởi ngăn xếp Bluetooth để phục vụ mục đích dùng chung theo cách này (điều này thường cung cấp thêm 1K của SRAM trong các bản biên dịch có dùng Bluetooth, và 8K nếu Bluetooth bị vô hiệu hóa).

Nếu bạn muốn cũng lấy lại bộ nhớ theo cách này, bạn có thể làm như sau:
```c++
#include "MicroBit.h"

int main()
{
    microbit_create_heap(MICROBIT_SD_GATT_TABLE_START + MICROBIT_SD_GATT_TABLE_SIZE, MICROBIT_SD_LIMIT);
}
```

## Tùy chọn cấu hình vào thời điểm biên dịch

Ngoài sự linh hoạt để khởi tạo chỉ những thành phần mà bạn cần, bộ runtime cũng cung cấp ở trung tâm một tập tin cấu hình thời gian biên dịch, gọi là `MicroBitConfig.h`.

Bạn có thể sử dụng để cấu hình lại các hành vi mặc định của bộ runtime.

Các thiết lập mặc định sẽ cung cấp một môi trường làm việc ổn định, nhưng người dùng cao cấp có thể muốn chỉnh sửa thêm hành vi.

Để chỉnh hành vi, chỉ cần chỉnh sửa file `MicroBitConfig.h` để thay đổi các thiết lập, và sau đó biên dịch lại từ đầu (clean rebuild).

### Tùy chọn vào thời điểm biên dịch với MicroBitConfig.h

Các tùy chọn sau đây được cấu hình tại thời điểm biên dịch qua `MicroBitConfig.h`:

| Tùy chọn cấu hình | Mô tả tóm tắt | 
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
 | `MICROBIT_DAL_VERSION` | Xác định thông tin phiên bản mặc định của bộ runtime. |

Ngoài ra còn có một số hằng số định nghĩa (kích thước) hình học của bộ nhớ micro:bit.

!!! warning "Cảnh báo" 
 Chỉ thay đổi những điều này nếu bạn thực sự biết mình đang làm gì!

| Tùy chọn cấu hình | Mô tả tóm tắt | 
| ------------- |-------------|
| `MICROBIT_SRAM_BASE` |  Địa chỉ bắt đầu của bộ nhớ RAM có thể sử dụng. |
| `MICROBIT_SRAM_END` |  Địa chỉ cuối của bộ nhớ RAM có thể sử dụng. |
| `MICROBIT_SD_LIMIT` |  Địa chỉ cuối của bộ nhớ RAM để dành cho Soft Device (Nordic's Bluetooth stack). |
| `MICROBIT_SD_GATT_TABLE_START` |  Địa chỉ bắt đầu của bảng Bluetooth GATT table trong RAM. |
| `CORTEX_M0_STACK_BASE` | Địa chỉ bộ nhớ ở trên cùng của stack hệ thống. |
| `MICROBIT_STACK_SIZE` | Lượng bộ nhớ để dành cho stack (tính theo byte). |
| `MICROBIT_HEAP_END` | Địa chỉ cuối cùng của không gian mbed heap. |

### Tùy chọn tại thời điểm biên dịch với Yotta

Thay vì chỉnh sửa file `MicroBitConfig.h` để thay đổi hành vi mặc định của bộ runtime, nếu bạn đang sử dụng
 `yotta`, bạn cũng có thể cung cấp một `config.json` trong dự án của bạn.

Dưới đây là một `config.json`, sử dụng tất cả các tùy chọn cấu hình có sẵn, phù hợp với các giá trị mặc định được quy định trong `MicroBitConfig.h`:

```json
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
```

Cần lưu ý rằng **tất cả** các tùy chọn ở trên là tùy chọn, và sẽ trở lại giá trị mặc định của chúng 
 nếu không được nhắc đến. Điều này có nghĩa rằng chúng ta cũng có thể cung cấp một tập hợp con của các tùy chọn này, để cấu hình
 các phần cụ thể của bộ runtime:

```json
{
    "microbit-dal":{
        "bluetooth":{
            "open": 1
        },
        "debug":1
    }
}
```

Ngoài ra, các tùy chọn được cung cấp qua `config.json` ánh xạ một cách tự nhiên lên `#defines`
listed in `MicroBitConfig.h`

Một ví dụ của `config.json` khi hoạt động có tại  kho GitHub [microbit-samples](https://github.com/lancaster-university/microbit-samples).