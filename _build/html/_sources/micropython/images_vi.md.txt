# Hình ảnh

MicroPython cũng giỏi về nghệ thuật bằng bạn nếu điều duy nhất bạn có là
một lưới đèn LEDs đỏ có kích thước 5x5 (điốt phát quang - những thứ phát sáng
trên mặt trước của thiết bị). MicroPython cung cấp cho bạn khá nhiều quyền kiểm soát
việc hiển thị để bạn có thể tạo ra tất cả các loại hiệu ứng thú vị.

MicroPython đi kèm với rất nhiều hình ảnh được xây dựng sẵn để hiển thị trên màn hình.
Ví dụ, để làm cho thiết bị hiển thị trông hạnh phúc bạn gõ:

```python
from microbit import *
display.show(Image.HAPPY)
```

Tôi đoán bạn có thể nhớ dòng lệnh đầu tiên làm gì. Dòng thứ hai sử dụng đối tượng
`display` (hiển thị) để `show`(đưa ra) một hình ảnh được xây dựng sẵn. Hình ảnh hạnh phúc chúng ta muốn
hiển thị là một phần của đối tượng `Image` (Hình ảnh) và được gọi là `HAPPY` (Hạnh phúc). Chúng ta ra lệnh cho
`show` sử dụng nó bằng cách đặt nó giữa dấu ngoặc đơn (`(` và `)`).

![](images/happy.png)

Dưới đây là một danh sách các hình ảnh được xây dựng sẵn:

* `Image.HEART`
* `Image.HEART_SMALL`
* `Image.HAPPY`
* `Image.SMILE`
* `Image.SAD`
* `Image.CONFUSED`
* `Image.ANGRY`
* `Image.ASLEEP`
* `Image.SURPRISED`
* `Image.SILLY`
* `Image.FABULOUS`
* `Image.MEH`
* `Image.YES`
* `Image.NO`
* `Image.CLOCK12`, `Image.CLOCK11`, `Image.CLOCK10`, `Image.CLOCK9`,
  `Image.CLOCK8`, `Image.CLOCK7`, `Image.CLOCK6`, `Image.CLOCK5`,
  `Image.CLOCK4`, `Image.CLOCK3`, `Image.CLOCK2`, `Image.CLOCK1`
* `Image.ARROW_N`, `Image.ARROW_NE`, `Image.ARROW_E`,
  `Image.ARROW_SE`, `Image.ARROW_S`, `Image.ARROW_SW`,
  `Image.ARROW_W`, `Image.ARROW_NW`
* `Image.TRIANGLE`
* `Image.TRIANGLE_LEFT`
* `Image.CHESSBOARD`
* `Image.DIAMOND`
* `Image.DIAMOND_SMALL`
* `Image.SQUARE`
* `Image.SQUARE_SMALL`
* `Image.RABBIT`
* `Image.COW`
* `Image.MUSIC_CROTCHET`
* `Image.MUSIC_QUAVER`
* `Image.MUSIC_QUAVERS`
* `Image.PITCHFORK`
* `Image.XMAS`
* `Image.PACMAN`
* `Image.TARGET`
* `Image.TSHIRT`
* `Image.ROLLERSKATE`
* `Image.DUCK`
* `Image.HOUSE`
* `Image.TORTOISE`
* `Image.BUTTERFLY`
* `Image.STICKFIGURE`
* `Image.GHOST`
* `Image.SWORD`
* `Image.GIRAFFE`
* `Image.SKULL`
* `Image.UMBRELLA`
* `Image.SNAKE`

Có khá nhiều! Tại sao không điều chỉnh mã lệnh làm cho micro:bit trông
 hạnh phúc để xem một số hình ảnh khác được xây dựng sẵn trông như thế nào?
 (Chỉ cần thay thế `Image.HAPPY` bằng một trong số những hình ảnh được xây dựng sẵn
 đã liệt kê ở trên.)

## Hình ảnh DIY (Tự tay tạo) 

Tất nhiên, bạn muốn tạo ra hình ảnh của riêng bạn để hiển thị trên các micro:bit, phải vậy không?

Dễ lắm.

Mỗi pixel (điểm ảnh) LED trên màn hình hiển thị có thể được thiết lập một trong mười giá trị.
 Nếu một pixel được thiết lập là `0` (không) thì nó sẽ tắt. Nghĩa là nó có độ sáng bằng không.
 Tuy nhiên, nếu nó được thiết lập là `9` thì nó đang ở mức sáng nhất. Các giá trị
 từ `1` để `8` đại diện cho mức độ sáng giữa tắt (` 0`) và sáng nhất ( `9`).

Được trang bị thông tin này, ta hoàn toàn có thể tạo ra một hình ảnh mới như thế này:
```python
from microbit import *

boat = Image("05050:"
             "05050:"
             "05050:"
             "99999:"
             "09990")

display.show(boat)
```

(Khi chạy, thiết bị sẽ hiển thị một thuyền buồm "Blue Peter" kiểu cũ 
với các cột buồm mờ hơn thân tàu.)

Bạn đã tìm ra cách để vẽ một bức tranh chưa? Bạn có nhận thấy rằng mỗi dòng
của màn hình hiển thị được diễn tả bởi một dòng các con số kết thúc với dấu `:` và 
 được đặt giữa dấu ngoặc kép `"`? Mỗi số quy định một độ sáng.
 Có năm dòng, mỗi dòng năm con số vì vậy nó có thể quy định độ sáng
 riêng lẻ cho từng pixel trong năm điểm ảnh trên từng dòng của năm dòng trên màn hình
 hiển thị. Đó là cách để tạo ra một hình ảnh mới.

Đơn giản vậy thôi!

Thực tế, bạn không cần phải viết trên nhiều dòng. Nếu bạn nghĩ rằng bạn có thể
 theo dõi từng dòng, bạn có thể viết lại như thế này:

```python
boat = Image("05050:05050:05050:99999:09990")
```

## Animation (Ảnh động) 

Hình ảnh tĩnh thì thú vị, nhưng còn thú vị hơn khi làm cho chúng chuyển động. Điều này cũng
 thật đơn giản khi thực hiện với MicroPython ~ chỉ cần sử dụng một danh sách các hình ảnh!

Đây là một danh sách mua sắm:
```python
Eggs
Bacon
Tomatoes
```

Đây là cách bạn thể hiện danh sách này trong Python:

```python
shopping = ["Eggs", "Bacon", "Tomatoes" ]
```

Tôi đơn giản tạo ra một danh sách gọi là `shopping` (mua sắm) và nó chứa ba mục.
Python biết đó là một danh sách bởi vì nó được đặt trong dấu ngoặc vuông (`[ `và 
`]`). Các mục trong danh sách được phân cách bằng dấu phẩy (`,`) và trong trường hợp này
các mục là ba chuỗi ký tự: `"Egg (Trứng)"`, `"Bacon (Thịt xông khói)"` và
`"Tomatoes (Cà chua)"`. Chúng ta biết chúng là các chuỗi ký tự, vì chúng được đặt trong
dấu ngoặc kép `"`.

Bạn có thể lưu trữ bất cứ điều gì trong một danh sách với Python. Đây là một danh sách các số:

```python
primes = [2, 3, 5, 7, 11, 13, 17, 19]
```

!!! note "Lưu ý"

    Số không cần phải được đặt trong ngoặc vì chúng đại diện cho một giá trị (chứ không phải là
    một chuỗi các ký tự). Đó là sự khác biệt giữa `2` (giá trị số 2)
    và `"2"` (ký tự/chữ số đại diện cho số 2). Đừng lo lắng
    nếu điều này vô nghĩa ngay bây giờ. Bạn sẽ sớm làm quen với nó thôi.

Ta còn có thể lưu trữ các thứ thuộc các loại khác nhau trong cùng một danh sách:

```python
mixed_up_list = ["hello!", 1.234, Image.HAPPY]
```

Bạn có để ý mục cuối cùng không? Đó là một hình ảnh!

Chúng ta có thể ra lệnh cho MicroPython làm chuyển động một danh sách các hình ảnh. Chúng ta may mắn có một
 vài danh sách các hình ảnh đã được xây dựng sẵn. Chúng được gọi là `Image.ALL_CLOCKS` 
 và `Image.ALL_ARROWS`:

```python
from microbit import *

display.show(Image.ALL_CLOCKS, loop=True, delay=100)
```

Giống như với hình ảnh đơn, chúng ta sử dụng `display.show` để hiển thị nó trên màn hình
của thiết bị. Tuy nhiên, chúng ta ra lệnh cho MicroPython sử dụng `Image.ALL_CLOCKS` và
nó hiểu rằng nó cần hiển thị mỗi hình ảnh trong danh sách theo trật tự.
Chúng ta cũng ra lệnh cho MicroPython tiếp tục lặp trên danh sách các hình ảnh
(để ảnh động kéo dài mãi mãi) bằng cách khai báo `loop = TRUE`. Hơn nữa, chúng ta ra lệnh cho nó
rằng chúng ta muốn delay (độ trễ) giữa mỗi hình ảnh là 100 mili giây (một phần mười
của một giây) với tham số `delay = 100`.

Bạn có thể tìm cách để làm chuyển động trên danh sách `Image.ALL_ARROWS` không?
 Làm thế nào để bạn tránh vòng lặp mãi mãi (gợi ý: ngược với `TRUE` (Đúng) là` FALSE` (Sai)
 mặc dù giá trị mặc định cho `loop` (vòng lặp) là` FALSE`)? Bạn có thể thay đổi tốc độ của
 chuyển động không?

Cuối cùng, đây là cách để tạo ra hình ảnh động của riêng bạn. Trong ví dụ của tôi,
tôi sẽ làm cho con thuyền của mình chìm vào phía dưới của màn hình hiển thị:

```python
from microbit import *

boat1 = Image("05050:"
              "05050:"
              "05050:"
              "99999:"
              "09990")

boat2 = Image("00000:"
              "05050:"
              "05050:"
              "05050:"
              "99999")

boat3 = Image("00000:"
              "00000:"
              "05050:"
              "05050:"
              "05050")

boat3 = Image("00000:"
              "00000:"
              "05050:"
              "05050:"
              "05050")

boat5 = Image("00000:"
              "00000:"
              "00000:"
              "00000:"
              "05050")

boat6 = Image("00000:"
              "00000:"
              "00000:"
              "00000:"
              "00000")

all_boats = [boat1, boat2, boat3, boat4, boat5, boat6]
display.show(all_boats, delay=200)
```

Đây là cách mã lệnh hoạt động:

* Tôi tạo ra sáu hình ảnh `boat` (con thuyền) chính xác như cách tôi mô tả ở trên.
* Sau đó, tôi đặt tất cả chúng vào một danh sách mà tôi gọi là `all_boats`.
* Cuối cùng, tôi ra lệnh cho `display.show` làm danh sách chuyển động với độ trễ 200 mili giây.
* Bởi vì tôi không thiết lập `loop=TRUE` cho nên thuyền sẽ chỉ chìm một lần (như vậy, làm cho hình ảnh động của tôi chính xác về mặt khoa học). :-)

Bạn sẽ làm cái gì chuyển động? Bạn có thể tạo ra hiệu ứng chuyển động đặc biệt không? Làm thế nào
 bạn có thể làm một hình ảnh mờ dần đến biến mất và rồi hiện lên rõ dần trở lại?