Giới thiệu

Bộ lệnh micro:bit runtime cung cấp một môi trường dễ sử dụng để lập trình
cho BBC micro:bit bằng ngôn ngữ C/C++, viết bởi trường đại học Lancaster. Nó
bao gồm các thư viện drivers cho tất cả các chức năng phần cứng của
micro:bit, và cũng là một bộ các cơ chế thực thi (runtime) để giúp việc lập
trình micro:bit được dễ hơn và uyển chuyển hơn. Chúng bao gồm từ việc đều
khiển một màn hình LED ma trận đến truyền tín hiệu radio ngang cấp
(peer-to-peer) và các dịch vụ Bluetooth năng lượng thấp (BLE) có bảo mật. Bộ
lệnh micro:bit runtime tự hào được xây dựng trên các nền tảng [ARM
mbed](https://www.mbed.com)  và [Nordic nrf51](http://www.nordicsemi.com).

Ngoài việc hỗ trợ phát triển bằng C/C++, bộ lệnh này cũng được thiết kế đặc
biệt để hỗ trợ các ngôn ngữ lập trình cấp cao do các đối tác của chúng tôi
phát triển cho micro:bit. Nó đang được dùng như một thư viện hỗ trợ cho tất
cả các ngôn ngữ lập trình trên trang web BBC
[www.microbit.co.uk](http://www.microbit.co.uk), bao gồm các ngôn ngữ
Microsoft Block Editor, Microsoft Touch Develop, Code Kingdom's JavaScript
và Micropython.

Trên các trang này, bạn sẽ tìm thấy hướng dẫn làm thế nào để bắt đầu sử dụng
bộ lệnh runtime trong C/C++, tóm tắt của tất cả các thành phần cấu tạo nên
hệ thống, và một bộ tài liệu đầy đủ về các API (các hàm mà bạn có thể dùng
để điều khiển micro:bit).

Để thử thấy việc bắt tay vào dễ như thế nào, hãy xem một <a
href="#next-steps">chương trình mẫu</a>.

#Bắt đầu tìm hiểu

Viết chương trình với micro:bit runtime thật đơn giản, sau đây là những cách
khác nhau để tạo ra các chương trình cho thiết bị của bạn.

<div class="col-sm-6">
    <center>
        <h3 id="online-environments">Viết chương trình online</h3>
    </center>
    <p>
        Một bản hướng dẫn cơ bản để xây dựng một dự án
        trong môi trường lập trình online.
    </p>
    <p>
        <center>
            <a href="online-toolchains" class="btn btn-lg btn-outline">
                Các công cụ phát triển online
            </a>
        </center>
    </p>
</div>
<div class="col-sm-6">
    <center>
        <h3 id="offline-environments">Viết chương trình offline</h3>
    </center>
    <p>
        Một bản hướng dẫn đầy đủ để cài đặt các công cụ phát triển chương trình trên máy tính, và một tutorial để
        xây dựng một dự án làm ví dụ.
    </p>
    <p>
        <center>
            <a href="offline-toolchains" class="btn btn-lg btn-outline">
                Các công cụ phát triển offline
            </a>
        </center>
    </p>
</div>

## Các bước kế tiếp

Sau khi bạn đã chọn môi trường phát triển chương trình, bước kế tiếp phải
là: **LẬP TRÌNH**!

Đây là vài đoạn code mẫu để bạn bắt đầu:

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

### uBit là gì?

uBit là một bản hiện thực hóa lớp [MicroBit](ubit.md) để cung cấp một cách
thật sự đơn giản nhằm tương tác với các thành phần khác nhau trên mạch
micro:bit.

Sự đơn giản có thể thấy qua một dòng lệnh này:

```cpp uBit.display.scroll("HELLO WORLD!"); ```

Dòng lệnh này chạy chữ `HELLO WORLD!` ngang màn hình của micro:bit.

#### Khởi tạo

Trong ví dụ trên, có một dòng lệnh dùng để khởi tạo một đối tượng uBit:

```cpp uBit.init(); ```

Trong lệnh gọi đến trình xếp lịch (scheduler) này, chương trình cấp phát bộ
nhớ và ngăn xếp Bluetooth được khởi tạo.

!!!note "Lưu ý"
    Dòng này được xóa đi trong tất cả các ví dụ bạn sẽ thấy trên trang web này, chỉ để tránh
    lặp lại!


### "fiber" là gì và tại sao chúng ta giải phóng nó?

"Fiber" là các luồng hạng nhẹ, được dùng bởi bộ runtime để thực hiện các tác
vụ không đồng bộ.

Một hàm gọi `release_fiber();` được khuyên dùng khi kết thúc chương trình
chính để giải phóng cái fiber chính, và nhảy vào chương trình xếp lịch vô
thời hạn như bạn có thể thấy các fiber khác chạy ở đâu đó trong chương
trình. Nó cũng có nghĩa là bộ xử lý sẽ nhảy vào một chế độ ngủ để tiết kiệm
năng lượng, khi không có tiến trình nào đang chạy.

Nếu dòng này bị bỏ đi, chương trình của bạn sẽ ngừng thực  hiện mọi tác vụ.
