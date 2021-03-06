��          �      L      �  5  �     �  �    �   �  K  �     �          "  �  2  r  �    I  2   Y     �  k   �     
  -   *  $   X  D   }  {  �  �  >  -   �  �  �  0  �  �  !     �     �       �    &  �  �  �  e   m      �   �   �   %   �!  .   �!  $   �!  D   "                                                   	                                             
        If MicroPython complains about a ``SyntaxError`` you've simply typed code
    in a way that MicroPython can't understand. Check you're not missing any
    special characters like ``"`` or ``:``. It's like putting. a full stop in
    the middle of a sentence. It's hard to understand exactly what you mean.     It may not work. :-)     Python expects you to type **EXACTLY** the right thing. So, for instance,
    ``Microbit``, ``microbit`` and ``microBit`` are all different things to
    Python. If MicroPython complains about a ``NameError`` it's probably
    because you've typed something inaccurately. It's like the difference
    between referring to "Nicholas" and "Nicolas". They're two different people
    but their names look very similar.     This is where things get fun and MicroPython tries to be helpful. If
    it encounters an error it will scroll a helpful message on the micro:bit's
    display. If it can, it will tell you the line number for where the error
    can be found.     Your microbit may stop responding: you cannot flash new code to it or
    enter commands into the REPL. If this happens, try power cycling it. That
    is, unplug the USB cable (and battery cable if it's connected), then plug
    the cable back in again. You may also need to quit and re-start your code
    editor application. !!! warning  ![](images/scroll-hello1.gif) # Hello, World! ...tells MicroPython to get all the stuff it needs to work with the BBC
micro:bit. All this stuff is in a module called `microbit` (a module
is a library of pre-existing code). When you `import` something you're telling
MicroPython that you want to use it, and `*` is Python's way to say
*everything*. So, `from microbit import *` means, in English, "I want to be
able to use everything from the microbit code library". ...tells MicroPython to use the display to scroll the string of characters
"Hello, World!". The `display` part of that line is an *object* from the
`microbit` module that represents the device's physical display (we say
"object" instead of "thingy", "whatsit" or "doodah"). We can tell the display
to do things with a full-stop `.` followed by what looks like a command (in
fact it's something we call a *method*). In this case we're using the
`scroll` method. Since `scroll` needs to know what characters to scroll
across the physical display we specify them between double quotes (`"`)
within parenthesis (`(` and `)`). These are called the *arguments*. So,
`display.scroll("Hello, World!")` means, in English, "I want you to use the
display to scroll the text 'Hello, World!'". If a method doesn't need any
arguments we make this clear by using empty parenthesis like this: `()`. Copy the "Hello, World!" code into your editor and flash it onto the device.
Can you work out how to change the message? Can you make it say hello to you?
For example, I might make it say "Hello, Nicholas!". Here's a clue, you need to
change the scroll method's argument. Each line does something special. The first line:: The second line:: The traditional way to start programming in a new language is to get your
computer to say, "Hello, World!". This is easy with MicroPython:: ```python
display.scroll("Hello, World!")
``` ```python
from microbit import *
``` ```python
from microbit import *
display.scroll("Hello, World!")
``` Project-Id-Version: help.microbit.vn
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2016-11-24 10:45+0200
PO-Revision-Date: 2016-12-13 17:20+0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 1.8.9
Last-Translator: Nguyễn Thị Trà My <muopgx000@gmail.com>
Language-Team: Rosetta.vn <minhdang@linux.com>
Language: vi
     Nếu MicroPython than phiền ``SyntaxError`` đơn giản là bạn đã gõ mã
    theo cách mà MicroPython không thể hiểu. Hãy kiểm tra bạn không thiếu bất kỳ 
    ký tự đặc biệt nào như ``"`` hoặc ``:``. Điều đó giống như đặt dấu chấm. vào
    giữa câu vậy. Thật khó để hiểu ý bạn muốn nói chính xác là gì.     Nó có thể không hoạt động. :-)     Python kỳ vọng bạn gõ ** CHÍNH XÁC** cái mình muốn. Ví dụ,
    ``Microbit``,``microbit`` và ``microBit`` tất cả đều khác nhau đối với
    Python. Nếu MicroPython than phiền ``NameError`` (Sai tên) có thể 
    bởi vì bạn đã gõ cái gì đó không chính xác. Giống như sự khác biệt
    giữa việc đề cập đến "Nicholas " và "Nicolas" vậy. Họ là hai người khác nhau
    nhưng tên của họ rất giống nhau.     Đây là nơi mọi thứ trở nên thú vị và MicroPython cố gắng để hữu dụng. Nếu
    gặp lỗi nó sẽ đưa ra một tin báo hữu ích trên màn hình hiển thị
    của micro:bit. Nếu có thể, nó sẽ cho bạn biết dòng số mấy xuất hiện lỗi.     Microbit có thể ngừng đáp ứng: bạn không thể flash mã mới vào hoặc
    nhập lệnh vào REPL. Nếu điều này xảy ra, hãy thử cấp nguồn điện lại cho nó. Bằng
    cách, tháo cáp USB (và cáp pin nếu nó được kết nối), sau đó cắm
    cáp lại. Bạn có thể cũng cần phải thoát và khởi động lại chương trình
    soạn thảo lệnh. !!! warning "Cảnh báo"  ![](images/scroll-hello1.gif) # Hello, World! ... ra lệnh cho MicroPython lấy tất cả những thứ cần thiết để làm việc với BBC 
micro:bit. Tất cả các thứ này nằm trong một mô-đun gọi là `microbit` (một mô-đun 
 là một thư viện của mã có trước đó). Khi bạn `import` (nhập) một cái gì đó tức là bạn đang cho
 MicroPython biết rằng bạn muốn sử dụng nó, và ký hiệu `*` là cách Python nói
 *mọi thứ*. Vì vậy, `from microbit import *` trong tiếng Việt có nghĩa là, "Tôi muốn có thể 
 sử dụng mọi thứ từ thư viện mã lệnh của microbit". ...ra lệnh cho MicroPython hãy sử dụng màn hình để di chuyển chuỗi các ký tự
"Hello, World!". Phần `display` của dòng lệnh đó là một *object* từ mô-đun
`microbit` đại diện hiển thị vật lý của thiết bị (chúng ta khai báo là
"object"thay vì " thingy", "whatsit" hoặc "doodah"). Chúng ta có thể ra lệnh cho màn hình 
 làm một vài điều với một dấu chấm `.` theo sau bởi những gì trông giống như một lệnh (thực tế
chúng ta gọi là một *method*). Trong trường hợp này, chúng tôi đang sử dụng phương pháp
`scroll` (`cuộn`). Vì `scroll` cần phải biết những kí tự gì để di chuyển 
đi ngang qua màn hình hiển thị nên chúng ta khai báo chúng giữa dấu nháy kép (`"`)
bên trong dấu ngoặc đơn (`(` và `)`). Chúng được gọi là các *argument* (đối số). Vì vậy,
`display.scroll("Hello, World!") `trong tiếng Việt có nghĩa là, "Tôi muốn bạn sử dụng
màn hình để di chuyển dòng chữ "Hello, World!'". Nếu một method (phương pháp) không cần bất kỳ
đối số nào chúng ta cần khai báo rõ ràng bằng cách sử dụng dấu ngoặc đơn trống như thế này: `()`. Sao chép file lệnh "Hello, World! " vào chương trình soạn thảo của bạn và ghi (flash) nó vào thiết bị.
Bạn có thể tìm ra cách thay đổi tin báo không? Bạn có thể ra lệnh cho nó nói xin chào bạn không?
Ví dụ, tôi có thể làm cho nó nói "Hello, Nicholas! ". Dưới đây là một manh mối, bạn cần phải 
thay đổi đối số của phương pháp cuộn. Mỗi dòng lệnh thực thi một điều đặc biệt nào đó. Dòng lệnh đầu tiên: Dòng lệnh thứ hai: Cách thông thường để bắt đầu lập trình bằng một ngôn ngữ mới là ra lệnh cho
máy tính của bạn hiển thị, "Hello, World! ".  Thật dễ dàng với MicroPython: ```python
display.scroll ("Hello, World!")
``` ```python
from microbit import *
``` ```python
from microbit import *
display.scroll("Hello, World!")
``` 