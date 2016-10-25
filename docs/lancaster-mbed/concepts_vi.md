# Các khái niệm

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
Microsoft Block Editor, Microsoft Touch Develop, Code  Kingdom's JavaScript
và Micropython.

![micro:bit runtime](resources/examples/concepts/architecture.png)


## Một cách tiếp cận từ thành phần

"Mỗi khi một nhà khoa học máy tính đụng phải một bài toán lập trình lớn,
chúng ta thường dành chút thời gian để chia bài toán đó ra thành các phần
nhỏ và độc tập, để giúp bài toán dễ giải quyết hơn (chiến lược "chia để
trị"). Bộ micro:bit runtime cũng không phải ngoại lệ, và nó được ghép từ khá
nhiều thành phần nhỏ. Mỗi thành phần lo cho một tác vụ riêng biệt trên
micro:bit.

Xây dần phần mềm kiểu này giúp chúng ta viết code bằng một cách rất dễ để
bảo quản khi số dòng lệnh tăng lên nhiều. Ví dụ, một thành phần tên là
[MicroBitDisplay](ubit/display.md) điều khiển các đèn LED trên micro:bit, và
giúp lập trình viên hiển thị hình ảnh, ảnh động và các thông điệp. Thành
phần [MicroBitIO](ubit/io.md) điều khiển các ngõ vào và ngõ ra qua các chân
ở cạnh của thiết bị.

Bộ micro:bit runtime là hướng đối tượng, trong đó mỗi thành phần thường là
một lớp trong C++. Có trên 30 thành phần tạo nên bộ runtime, và chúng được
ghi vào tài liệu trong các trang này.

Để tạo ra bộ runtime dễ dùng hết mức, có một nhóm các thành phần thường dùng
nhất đặt trong một đối tượng gọi là [uBit](ubit.md) (Chữ 'u' là chữ cái Hy
Lạp mu, đọc là "muy", thường chỉ đến tiền tố trong các đơn vị đo khoa học).

Đối tượng uBit có thể được dùng để truy cập dễ dàng đến hầu hết các tính
năng của micro:bit. Bạn có thể tìm thấy các thành phần và hàm con truy cập
được qua cách này ở link `uBit` trong menu điều hướng.

Để cho thấy có thể bắt đầu dễ như thế nào, đoạn code dưới đây trình diễn
cách viết chương trình Hello World kinh điển.

Nó dùng đối tượng uBit để truy cập thành phần "màn hình", sau đó bảo màn
hình chạy một dòng chữ ngang qua các đèn LED. Hãy thử dùng link `uBit` ở
menu trang web để tìm phần tài liệu cho hàm scroll() này!

```cpp uBit.display.scroll("Hello micro:bit!"); ```

!!! note "Lưu ý"
    Bạn có biết là bạn có thể không cần dùng đối tượng uBit? Người dùng nâng cao có thể ưa thích tạo ra chỉ các thành phần mà họ cần, để tiết kiệm bộ nhớ trên thiết bị. Xem phần [nâng cao](advanced.md) để biết cách làm này.


# Sự kiện

Các chương trình máy tính chạy một cách tuần tự - từng dòng nối tiếp nhau,
theo một logic của chương trình mà bạn đã viết. Tuy nhiên thỉnh thoảng chúng
ta muốn có khả năng xác định *khi nào* một điều gì đó xảy ra, và viết vài
dòng lệnh để quyết định việc gì sẽ thực hiện trong trường hợp đó.

Ví dụ, bạn có thể muốn biết khi nào một nút nhấn được nhấn, khi nào mạch
micro:bit của bạn đang được rung lắc, hoặc khi nào có dữ liệu gửi đến thiết
bị của bạn qua sóng không dây. Cho các kiểu trường hợp này, chúng ta tạo ra
một [MicroBitEvent](data-types/event.md).


## Tạo ra sự kiện

Nhiều thành phần sẽ tạo ra các events khi có gì đáng quan tâm xảy ra. Ví dụ,
['MicroBitAccelerometer'](ubit/accelerometer.md) sẽ gây ra sự kiện để cho
biết là micro:bit vừa bị lắc, hoặc nó đang rơi tự do, và
['MicroBitButton'](ubit/button.md) sẽ gửi sự kiện trong phạm vi các hoạt
động ấn xuống, nhả lên, nhấn rồi nhả (click) và nhấn giữ (hold). Lập trình
viên có thể tự do gửi các sự kiện của họ khi họ thấy việc đó có thể hữu
ích. Các `MicroBitEvent` *rất* đơn giản, và bao gồm chỉ có 2 con số:

  - `source` (nguồn) - Một con số để xác định thành phần nào tạo ra sự kiện.
  - `value` (giá trị) - Một con số độc nhất đối với nguồn để xác định sự
    kiện.

Tài liệu của từng thành phần xác định nguồn sự kiện của nó, và tất cả các sự
kiện nó có thể tạo ra, cũng như cho biết tên ứng với các giá trị sự
kiện. Lấy ví dụ, hãy xem thử [tài liệu về nút nhấn](ubit/button.md) để thấy
là nguồn MICROBIT_ID_BUTTON_A có giá trị '1', và một sự kiện
MICROBIT_BUTTON_EVT_CLICK với giá trị '3' được tạo ra khi một nút nhấn được
bấm (click).

Tạo ra một sự kiện thật dễ dàng - chỉ cần tạo ra một MicroBitEvent với
`source` và `value` bạn cần, và bộ runtime sẽ lo việc còn lại:

```cpp MicroBitEvent(MICROBIT_ID_BUTTON_A, MICROBIT_BUTTON_EVT_CLICK); ```

Hãy tự nhiên tạo ra các sự kiện của riêng bạn kiểu thế này. Chỉ cần cố gắng
tránh dùng bất kỳ ID nguồn nào đã được sử dụng trong bộ runtime! :-) Xem
trang [messageBus](ubit/messageBus.md) để thấy bảng đầy đủ các ID nguồn được
dành trước.


## Dò đón các sự kiện

The micro:bit runtime has a component called the
[`MicroBitMessageBus`](ubit/messageBus.md), and its job is remember which
events your program is interested in, and to deliver `MicroBitEvent`s to
your program as they occur.

To find out when an event happens, you need to create a function in your
program, then tell the message bus which event you want to attach this
function to. This is known as writing an **event handler**.

Bạn viết một hàm xử lý sự kiện (event handler) qua hàm `MicroBitMessageBus`
[listen](ubit/messageBus.md).

```cpp
void onButtonA(MicroBitEvent e)
{
    uBit.display.print("A");
}

int main()
{
    uBit.messageBus.listen(MICROBIT_ID_BUTTON_A, MICROBIT_BUTTON_EVT_CLICK, onButtonA);
}
```

Bây giờ, mỗi khi sự kiện MICROBIT_BUTTON_EVT_CLICK được gây ra bởi
MICROBIT_ID_BUTTON_A, mã lệnh bạn để bên trong hàm 'onButtonA' sẽ được tự
động thực thi.

You can call listen as many times as you want to attached functions to each
of the events that are useful for your program. In fact, a block like the
following in the Microsoft Block language translates into code just like
that shown above when it is run on a micro:bit!

![on button a, equivalent in
blocks](resources/examples/concepts/example-listener.png)


## Sự kiện wildcard

Sometimes though, you want to capture all events generated by some
component. For example, you might want to know when any changes in a button
has happened.  In this case, there is a special event value called
'MICROBIT_EVT_ANY'. If you call listen with this value, then ALL events from
the given source component will be delivered to your function.

You can find out which ones by looking at the `MicroBitEvent` delivered to
your function - it contains the `source` and `value` variables that the
`MicroBitEvent` was created with.

Lấy ví dụ, bạn có thể viết một chương trình kiểu này:
```cpp
void onButtonA(MicroBitEvent e)
{
    if (e.value == MICROBIT_BUTTON_EVT_CLICK)
        uBit.display.scroll("CLICK");

    if (e.value == MICROBIT_BUTTON_EVT_DOWN)
        uBit.display.scroll("DOWN");
}

int main()
{
    uBit.messageBus.listen(MICROBIT_ID_BUTTON_A, MICROBIT_EVT_ANY, onButtonA);
}
```

Nếu bạn *THẬT SỰ* muốn nhiều sự kiện hơn nữa, có một nguồn MICROBIT_ID_ANY,
cho phép bạn gắn một hàm với một sự kiện sinh ra bởi bất kỳ thành phần nào.

Tuy nhiên, hãy sử dụng cái này một cách tiết kiệm, vì nó có thể làm ra nhiều
sự kiện!

Đoạn mã dưới đây sẽ gắn một hàm `onEvent` để nhận tất cả các sự kiện từ toàn bộ runtime:
```cpp
void onEvent(MicroBitEvent e)
{
    uBit.display.scroll("CO CHUYEN ROI!");
}

int main()
{
    uBit.messageBus.listen(MICROBIT_ID_ANY, MICROBIT_EVT_ANY, onEvent);
}
```

## Các sự kiện xếp hàng

When you write an event handler, your function will be called each time the
relevant event is raised. But what happens if your handler takes a long time
to execute?

The example above will scroll "SOMETHING HAPPENED" whenever any event is
raised... but scrolling that message will take several seconds to complete!

What if another event happens during this time? By default, the runtime will
queue any events for your event handler until it has finished what its
already doing.

As soon as your handler is finished processing an event, the next one will
be delivered (any other event handlers will be unaffected though - just
because one event handler is busy, doesn't mean that another one can't
receive its events!).

The runtime does allow you to change this behaviour if you want to
though. See the advanced documentation in
[MicroBitMessageBus](ubit/messageBus.md) for more details.

!!! note
    More advanced programmers might be interested to know that you can also attach event handler to member function of C++ objects. See the other forms of listen function in [MicroBitMessageBus](ubit/messageBus.md) for more details.


# Concurrency

It is not uncommon to want to write programs that can do more than one thing
at a time. For example, it takes quite a long time to scroll a message over
the LED matrix, so what if you want your program to do something else while
this is happening?

Programs that do more than one thing at a time are called **concurrent
programs**.

The runtime provides two ways you can achieve concurrency in your programs:

 -  Functions that may take a very long time to complete
    (e.g. display.scroll) often have "Async" versions
    (e.g. `display.scrollAsync`).

    These functions have the exact same behaviour as their counterparts, but don't wait for the effect to finish before allowing the user's program to continue.

    Instead, as soon as the function is called, the user's program carries on executing (and can go an do something else while the task is running in the background).



 - Users can also make use of the runtime fiber scheduler. This lets you run parts of your program in the background, and share the processor on your micro:bit between those parts
as they need it.

    In fact, whenever you write an event handler, the runtime will normally execute your handler in the background in this way, so that it reduces the impact on the rest of your program!

    The scheduler is a type of *non-preemptive scheduler*. This means that the runtime will never take control away from your program - it will wait for it to make a call to a runtime
function that is *blocking*.

    All the functions that are blocking are listed as such in their documentation.  You can create **fibers** at any time.
