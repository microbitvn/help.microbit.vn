��            )         �     �  )   �  l   �     d  -   r     �     �     �     �  r  �  X   X  p   �  X   "  ,   {  ?   �  �  �  I   �
  Q   �
  \   ,     �  �   �  0  |  O  �  I   �  3   G     {  /   �     �     �  �   �  -  �     �  )   �  �        �  >   �               *     D  �  T  y   N  �   �  �   u  ;   �  h   2    �  a   �  �     ~   �     $  W  3  �  �  1  P!  O   �$  ?   �$     %  /   /%     _%     w%  �   �%                                               	                                                      
                                       release_fiber();
}
```
     uBit.display.scroll("HELLO WORLD!");
 !!!note
    This line is omitted in all examples you will find on this site simply to avoid
    repetition!
 ## Next Steps ### What is a fiber and why do we release it? ### What is uBit? #### Initialisation #Getting Started #Introduction <div class="col-sm-6">
    <center>
        <h3 id="online-environments">Online development</h3>
    </center>
    <p>
        A basic quick start guide to getting an example project building in an
        online programming environment.
    </p>
    <p>
        <center>
            <a href="online-toolchains" class="btn btn-lg btn-outline">
                Online development tools
            </a>
        </center>
    </p>
</div>
<div class="col-sm-6">
    <center>
        <h3 id="offline-environments">Offline development</h3>
    </center>
    <p>
        A full guide to installing offline development tools, and a tutorial on getting
        an example project building.
    </p>
    <p>
        <center>
            <a href="offline-toolchains" class="btn btn-lg btn-outline">
                Offline development tools
            </a>
        </center>
    </p>
</div>
 After you've chosen your development environment, the next step is obvious: **PROGRAM**! Developing with the micro:bit runtime is simple, and there are multiple ways to create programs for your device. Fibers are lightweight threads used by the runtime to perform operations asynchronously. Here is some sample code to get you started: If this line is omitted, your program will cease all execution. In addition to supporting development in C/C++, the runtime is also designed specifically to support higher level languages provided by our partners that target the micro:bit. It is currently used as a support library for all the languages on the BBC [www.microbit.co.uk](http://www.microbit.co.uk) website, including the Microsoft Block Editor, Microsoft Touch Develop, Code Kingdom's JavaScript and Micropython languages. In the above example, there is a line used to initialise the uBit object: In this call the scheduler, memory allocator and Bluetooth stack are initialised. Just to show how easy it is to get started, view a <a href="#next-steps">sample program</a>. MicroBit uBit; On these pages you will find guidance on how to start using the runtime in C/C++, summaries of all the components that make up the system and a full set of API documentation (the functions you can use to control the micro:bit). The function call `release_fiber();` is recommended at the end of main to release the main fiber, and enter the scheduler indefinitely as you may have other fibers running elsewhere in the code.  It also means that the processor will enter a power efficient sleep if there are no other processes running. The micro:bit runtime provides an easy to use environment for programming the BBC micro:bit in the C/C++ language, written by Lancaster University. It contains device drivers for all the hardware capabilities of the micro:bit, and also a suite of runtime mechanisms to make programming the micro:bit easier and more flexible. These range from control of the LED matrix display to peer-to-peer radio communication and secure Bluetooth Low Energy services. The micro:bit runtime is proudly built on the [ARM mbed](https://www.mbed.com)  and [Nordic nrf51](http://www.nordicsemi.com) platforms. This line scrolls the text `HELLO WORLD!` across the micro:bit's display. This simplicity can be seen with this line of code: ```cpp #include "MicroBit.h" ```cpp uBit.display.scroll("HELLO WORLD!"); ``` ```cpp uBit.init(); ``` int main()
{
    uBit.init();
 uBit is an instance of the [MicroBit](ubit.md) class which provides a really simple way to interact with the various components on the micro:bit itself. Project-Id-Version: 
POT-Creation-Date: 2016-10-24 14:47+0200
PO-Revision-Date: 2016-10-31 12:54+0100
Language-Team: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 1.8.9
Last-Translator: 
Plural-Forms: nplurals=1; plural=0;
Language: vi
     release_fiber();
}
```
     uBit.display.scroll("HELLO WORLD!");
 !!!note "Lưu ý"
    Dòng này được xóa đi trong tất cả các ví dụ bạn sẽ thấy trên trang web này, chỉ để tránh
    lặp lại!
 ## Các bước kế tiếp ### "fiber" là gì và tại sao chúng ta giải phóng nó? ### uBit là gì? #### Khởi tạo #Bắt đầu tìm hiểu #Giới thiệu <div class="col-sm-6">
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
 Sau khi bạn đã chọn môi trường phát triển chương trình, bước kế tiếp phải là: **LẬP TRÌNH**! Viết chương trình với micro:bit runtime thật đơn giản, sau đây là những cách khác nhau để tạo ra các chương trình cho thiết bị của bạn. "Fiber" là các luồng hạng nhẹ, được dùng bởi bộ runtime để thực hiện các tác vụ không đồng bộ. Đây là vài đoạn code mẫu để bạn bắt đầu: Nếu dòng này bị bỏ đi, chương trình của bạn sẽ ngừng thực  hiện mọi tác vụ. Ngoài việc hỗ trợ phát triển bằng C/C++, bộ lệnh này cũng được thiết kế đặc biệt để hỗ trợ các ngôn ngữ lập trình cấp cao do các đối tác của chúng tôi phát triển cho micro:bit. Nó đang được dùng như một thư viện hỗ trợ cho tất cả các ngôn ngữ lập trình trên trang web BBC [www.microbit.co.uk](http://www.microbit.co.uk), bao gồm các ngôn ngữ Microsoft Block Editor, Microsoft Touch Develop, Code Kingdom's JavaScript và Micropython. Trong ví dụ trên, có một dòng lệnh dùng để khởi tạo một đối tượng uBit: Trong lệnh gọi đến trình xếp lịch (scheduler) này, chương trình cấp phát bộ nhớ và ngăn xếp Bluetooth được khởi tạo. Để thử thấy việc bắt tay vào dễ như thế nào, hãy xem một <a href="#next-steps">chương trình mẫu</a>. MicroBit uBit; Trên các trang này, bạn sẽ tìm thấy hướng dẫn làm thế nào để bắt đầu sử dụng bộ lệnh runtime trong C/C++, tóm tắt của tất cả các thành phần cấu tạo nên hệ thống, và một bộ tài liệu đầy đủ về các API (các hàm mà bạn có thể dùng để điều khiển micro:bit). Một hàm gọi `release_fiber();` được khuyên dùng khi kết thúc chương trình chính để giải phóng cái fiber chính, và nhảy vào chương trình xếp lịch vô thời hạn như bạn có thể thấy các fiber khác chạy ở đâu đó trong chương trình. Nó cũng có nghĩa là bộ xử lý sẽ nhảy vào một chế độ ngủ để tiết kiệm năng lượng, khi không có tiến trình nào đang chạy. Bộ lệnh micro:bit runtime cung cấp một môi trường dễ sử dụng để lập trình cho BBC micro:bit bằng ngôn ngữ C/C++, viết bởi trường đại học Lancaster. Nó bao gồm các thư viện drivers cho tất cả các chức năng phần cứng của micro:bit, và cũng là một bộ các cơ chế thực thi (runtime) để giúp việc lập trình micro:bit được dễ hơn và uyển chuyển hơn. Chúng bao gồm từ việc đều khiển một màn hình LED ma trận đến truyền tín hiệu radio ngang cấp (peer-to-peer) và các dịch vụ Bluetooth năng lượng thấp (BLE) có bảo mật. Bộ lệnh micro:bit runtime tự hào được xây dựng trên các nền tảng [ARM mbed](https://www.mbed.com)  và [Nordic nrf51](http://www.nordicsemi.com). Dòng lệnh này chạy chữ `HELLO WORLD!` ngang màn hình của micro:bit. Sự đơn giản có thể thấy qua một dòng lệnh này: ```cpp
#include "MicroBit.h" ```cpp
uBit.display.scroll("HELLO WORLD!");
``` ```cpp
uBit.init();
``` int main()
{
    uBit.init();
 uBit là một bản hiện thực hóa lớp [MicroBit](ubit.md) để cung cấp một cách thật sự đơn giản nhằm tương tác với các thành phần khác nhau trên mạch micro:bit. 