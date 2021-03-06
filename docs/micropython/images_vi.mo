��    4      �  G   \      x  1  y     �     �     �     �     �  |   �  O  z  f  �  m   1  �  �  �   �  3  t     �  �  (  ;   �  %        8  /   S    �  �  �  �   -  H   �  �   �  '  ~  '   �  N   �       �   %     �  �   �  �   �  u   H  H   �  ;     >   C  <   �  3   �  7   �  ]   +  m   �  r   �  r   j  r   �  r   P  r   �  r   6   8   �      �   .   �   .   (!  {  W!  �  �"     f$     y$     �$     �$  $   �$  �   �$    p%  f  t'  �   �+  �  n,  u  +/  �  �0  �   �2  S  [3  G   �5  P   �5  ,   H6  @   u6  �  �6  (  �8  �   �:  d   ~;  �   �;  �  �<  L   V>  �   �>     %?  �   @?     4@  P  @@    �A    �B  |   �C  ;   2D  >   nD  <   �D  3   �D  7   E  ]   VE  m   �E  r   "F  r   �F  r   G  r   {G  r   �G  r   aH  8   �H     I      $I      EI                    +         !   0   4   (      %         $                  3          "   	          /                      *   2                  #         &      ,       
                  -                    '                1      .             )        Numbers don't need to be quoted since they represent a value (rather than a
    string of characters). It's the difference between `2` (the numeric value
    2) and `"2"` (the character/digit representing the number 2). Don't worry
    if this doesn't make sense right now. You'll soon get used to it. !!! note "Lưu ý" ![](images/happy.png) # Hình ảnh ## Animation ## DIY Images (When run, the device should display an old-fashioned "Blue Peter" sailing ship
with the masts dimmer than the boat's hull.) * I create six `boat` images in exactly the same way I described above.
* Then, I put them all into a list that I call `all_boats`.
* Finally, I ask `display.show` to animate the list with a delay of 200 milliseconds.
* Since I've not set `loop=True` the boat will only sink once (thus making my animation scientifically accurate). :-) * `Image.HEART`
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
* `Image.SNAKE` Armed with this information, it's possible to create a new image like this::
```python
from microbit import * As with a single image, we use `display.show` to show it on the
device's display. However, we tell MicroPython to use `Image.ALL_CLOCKS` and
it understands that it needs to show each image in the list, one after the
other. We also tell MicroPython to keep looping over the list of images (so
the animation lasts forever) by saying `loop=True`. Furthermore, we tell it
that we want the delay between each image to be only 100 milliseconds (a tenth
of a second) with the argument `delay=100`. Can you work out how to animate over the `Image.ALL_ARROWS` list? How do you
avoid looping forever (hint: the opposite of `True` is `False` although
the default value for `loop` is `False`)? Can you change the speed of the
animation? Each LED pixel on the physical display can be set to one of ten values. If a
pixel is set to `0` (zero) then it's off. It literally has zero brightness.
However, if it is set to `9` then it is at its brightest level. The values
`1` to `8` represent the brightness levels between off (`0`) and full on
(`9`). Finally, here's how to create your own animation. In my example I'm going to
make my boat sink into the bottom of the display:: Have you figured out how to draw a picture? Have you noticed that each line of
the physical display is represented by a line of numbers ending in `:` and
enclosed between `"` double quotes? Each number specifies a brightness.
There are five lines of five numbers so it's possible to specify the individual
brightness for each of the five pixels on each of the five lines on the
physical display. That's how to create a new image. Here is a shopping list::
```python
Eggs
Bacon
Tomatoes
``` Here's a list of the built-in images: Here's how the code works: Here's how you'd represent this list in Python: I suspect you can remember what the first line does. The second line uses the
`display` object to `show` a built-in image. The happy image we want to
display is a part of the `Image` object and called `HAPPY`. We tell
`show` to use it by putting it between the parenthesis (`(` and `)`). I've simply created a list called `shopping` and it contains three items.
Python knows it's a list because it's enclosed in square brackets (`[` and
`]`). Items in the list are separated by a comma (`,`) and in this instance
the items are three strings of characters: `"Eggs"`, `"Bacon"` and
`"Tomatoes"`. We know they are strings of characters because they're enclosed
in quotation marks `"`. In fact, you don't need to write this over several lines. If you think you can
keep track of each line, you can rewrite it like this:: It's even possible to store different sorts of things in the same list:: MicroPython comes with lots of built-in pictures to show on the display.
For example, to make the device appear happy you type:: MicroPython is about as good at art as you can be if the only thing you have is
a 5x5 grid of red LEDs (light emitting diodes - the things that light up on the
front of the device). MicroPython gives you quite a lot of control over the
display so you can create all sorts of interesting effects. Notice that last item? It was an image! Of course, you want to make your own image to display on the micro:bit, right? Simple! Static images are fun, but it's even more fun to make them move. This is also
amazingly simple to do with MicroPython ~ just use a list of images! That's easy. There's quite a lot! Why not modify the code that makes the micro:bit look
happy to see what some of the other built-in images look like? (Just replace
`Image.HAPPY` with one of the built-in images listed above.) We can tell MicroPython to animate a list of images. Luckily we have a
couple of lists of images already built in. They're called `Image.ALL_CLOCKS`
and `Image.ALL_ARROWS`:: What would you animate? Can you animate special effects? How would you make an
image fade out and then fade in again? You can store anything in a list with Python. Here's a list of numbers:: ```python
boat = Image("05050:05050:05050:99999:09990")
``` ```python
from microbit import *
display.show(Image.HAPPY)
``` ```python
mixed_up_list = ["hello!", 1.234, Image.HAPPY]
``` ```python
primes = [2, 3, 5, 7, 11, 13, 17, 19]
``` ```python
shopping = ["Eggs", "Bacon", "Tomatoes" ]
``` all_boats = [boat1, boat2, boat3, boat4, boat5, boat6]
display.show(all_boats, delay=200)
``` boat = Image("05050:"
             "05050:"
             "05050:"
             "99999:"
             "09990") boat1 = Image("05050:"
              "05050:"
              "05050:"
              "99999:"
              "09990") boat2 = Image("00000:"
              "05050:"
              "05050:"
              "05050:"
              "99999") boat3 = Image("00000:"
              "00000:"
              "05050:"
              "05050:"
              "05050") boat4 = Image("00000:"
              "00000:"
              "00000:"
              "05050:"
              "05050") boat5 = Image("00000:"
              "00000:"
              "00000:"
              "00000:"
              "05050") boat6 = Image("00000:"
              "00000:"
              "00000:"
              "00000:"
              "00000") display.show(Image.ALL_CLOCKS, loop=True, delay=100)
``` display.show(boat)
``` images.md:174```python
from microbit import * images.md:196```python
from microbit import * Project-Id-Version: help.microbit.vn
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2016-11-24 10:45+0200
PO-Revision-Date: 2017-01-11 16:44+0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 1.8.9
Last-Translator: Nguyễn Thị Trà My <muopgx000@gmail.com>
Language-Team: Rosetta.vn <minhdang@linux.com>
Language: vi
     Số không cần phải được đặt trong ngoặc vì chúng đại diện cho một giá trị (chứ không phải là
    một chuỗi các ký tự). Đó là sự khác biệt giữa `2` (giá trị số 2)
    và `"2"` (ký tự/chữ số đại diện cho số 2). Đừng lo lắng
    nếu điều này vô nghĩa ngay bây giờ. Bạn sẽ sớm làm quen với nó thôi. !!! note "Lưu ý" ![](images/happy.png) # Hình ảnh ## Animation (Ảnh động)  ## Hình ảnh DIY (Tự tay tạo)  (Khi chạy, thiết bị sẽ hiển thị một thuyền buồm "Blue Peter" kiểu cũ 
với các cột buồm mờ hơn thân tàu.) * Tôi tạo ra sáu hình ảnh `boat` (con thuyền) chính xác như cách tôi mô tả ở trên.
* Sau đó, tôi đặt tất cả chúng vào một danh sách mà tôi gọi là `all_boats`.
* Cuối cùng, tôi ra lệnh cho `display.show` làm danh sách chuyển động với độ trễ 200 mili giây.
* Bởi vì tôi không thiết lập `loop=TRUE` cho nên thuyền sẽ chỉ chìm một lần (như vậy, làm cho hình ảnh động của tôi chính xác về mặt khoa học). :-) * `Image.HEART`
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
* `Image.SNAKE` Được trang bị thông tin này, ta hoàn toàn có thể tạo ra một hình ảnh mới như thế này:
```python
from microbit import * Giống như với hình ảnh đơn, chúng ta sử dụng `display.show` để hiển thị nó trên màn hình
của thiết bị. Tuy nhiên, chúng ta ra lệnh cho MicroPython sử dụng `Image.ALL_CLOCKS` và
nó hiểu rằng nó cần hiển thị mỗi hình ảnh trong danh sách theo trật tự.
Chúng ta cũng ra lệnh cho MicroPython tiếp tục lặp trên danh sách các hình ảnh
(để ảnh động kéo dài mãi mãi) bằng cách khai báo `loop = TRUE`. Hơn nữa, chúng ta ra lệnh cho nó
rằng chúng ta muốn delay (độ trễ) giữa mỗi hình ảnh là 100 mili giây (một phần mười
của một giây) với tham số `delay = 100`. Bạn có thể tìm cách để làm chuyển động trên danh sách `Image.ALL_ARROWS` không?
 Làm thế nào để bạn tránh vòng lặp mãi mãi (gợi ý: ngược với `TRUE` (Đúng) là` FALSE` (Sai)
 mặc dù giá trị mặc định cho `loop` (vòng lặp) là` FALSE`)? Bạn có thể thay đổi tốc độ của
 chuyển động không? Mỗi pixel (điểm ảnh) LED trên màn hình hiển thị có thể được thiết lập một trong mười giá trị.
 Nếu một pixel được thiết lập là `0` (không) thì nó sẽ tắt. Nghĩa là nó có độ sáng bằng không.
 Tuy nhiên, nếu nó được thiết lập là `9` thì nó đang ở mức sáng nhất. Các giá trị
 từ `1` để `8` đại diện cho mức độ sáng giữa tắt (` 0`) và sáng nhất ( `9`). Cuối cùng, đây là cách để tạo ra hình ảnh động của riêng bạn. Trong ví dụ của tôi,
tôi sẽ làm cho con thuyền của mình chìm vào phía dưới của màn hình hiển thị: Bạn đã tìm ra cách để vẽ một bức tranh chưa? Bạn có nhận thấy rằng mỗi dòng
của màn hình hiển thị được diễn tả bởi một dòng các con số kết thúc với dấu `:` và 
 được đặt giữa dấu ngoặc kép `"`? Mỗi số quy định một độ sáng.
 Có năm dòng, mỗi dòng năm con số vì vậy nó có thể quy định độ sáng
 riêng lẻ cho từng pixel trong năm điểm ảnh trên từng dòng của năm dòng trên màn hình
 hiển thị. Đó là cách để tạo ra một hình ảnh mới. Đây là một danh sách mua sắm:
```python
Eggs
Bacon
Tomatoes
``` Dưới đây là một danh sách các hình ảnh được xây dựng sẵn: Đây là cách mã lệnh hoạt động: Đây là cách bạn thể hiện danh sách này trong Python: Tôi đoán bạn có thể nhớ dòng lệnh đầu tiên làm gì. Dòng thứ hai sử dụng đối tượng
`display` (hiển thị) để `show`(đưa ra) một hình ảnh được xây dựng sẵn. Hình ảnh hạnh phúc chúng ta muốn
hiển thị là một phần của đối tượng `Image` (Hình ảnh) và được gọi là `HAPPY` (Hạnh phúc). Chúng ta ra lệnh cho
`show` sử dụng nó bằng cách đặt nó giữa dấu ngoặc đơn (`(` và `)`). Tôi đơn giản tạo ra một danh sách gọi là `shopping` (mua sắm) và nó chứa ba mục.
Python biết đó là một danh sách bởi vì nó được đặt trong dấu ngoặc vuông (`[ `và 
`]`). Các mục trong danh sách được phân cách bằng dấu phẩy (`,`) và trong trường hợp này
các mục là ba chuỗi ký tự: `"Egg (Trứng)"`, `"Bacon (Thịt xông khói)"` và
`"Tomatoes (Cà chua)"`. Chúng ta biết chúng là các chuỗi ký tự, vì chúng được đặt trong
dấu ngoặc kép `"`. Thực tế, bạn không cần phải viết trên nhiều dòng. Nếu bạn nghĩ rằng bạn có thể
 theo dõi từng dòng, bạn có thể viết lại như thế này: Ta còn có thể lưu trữ các thứ thuộc các loại khác nhau trong cùng một danh sách: MicroPython đi kèm với rất nhiều hình ảnh được xây dựng sẵn để hiển thị trên màn hình.
Ví dụ, để làm cho thiết bị hiển thị trông hạnh phúc bạn gõ: MicroPython cũng giỏi về nghệ thuật bằng bạn nếu điều duy nhất bạn có là
một lưới đèn LEDs đỏ có kích thước 5x5 (điốt phát quang - những thứ phát sáng
trên mặt trước của thiết bị). MicroPython cung cấp cho bạn khá nhiều quyền kiểm soát
việc hiển thị để bạn có thể tạo ra tất cả các loại hiệu ứng thú vị. Bạn có để ý mục cuối cùng không? Đó là một hình ảnh! Tất nhiên, bạn muốn tạo ra hình ảnh của riêng bạn để hiển thị trên các micro:bit, phải vậy không? Đơn giản vậy thôi! Hình ảnh tĩnh thì thú vị, nhưng còn thú vị hơn khi làm cho chúng chuyển động. Điều này cũng
 thật đơn giản khi thực hiện với MicroPython ~ chỉ cần sử dụng một danh sách các hình ảnh! Dễ lắm. Có khá nhiều! Tại sao không điều chỉnh mã lệnh làm cho micro:bit trông
 hạnh phúc để xem một số hình ảnh khác được xây dựng sẵn trông như thế nào?
 (Chỉ cần thay thế `Image.HAPPY` bằng một trong số những hình ảnh được xây dựng sẵn
 đã liệt kê ở trên.) Chúng ta có thể ra lệnh cho MicroPython làm chuyển động một danh sách các hình ảnh. Chúng ta may mắn có một
 vài danh sách các hình ảnh đã được xây dựng sẵn. Chúng được gọi là `Image.ALL_CLOCKS` 
 và `Image.ALL_ARROWS`: Bạn sẽ làm cái gì chuyển động? Bạn có thể tạo ra hiệu ứng chuyển động đặc biệt không? Làm thế nào
 bạn có thể làm một hình ảnh mờ dần đến biến mất và rồi hiện lên rõ dần trở lại? Bạn có thể lưu trữ bất cứ điều gì trong một danh sách với Python. Đây là một danh sách các số: ```python
boat = Image("05050:05050:05050:99999:09990")
``` ```python
from microbit import *
display.show(Image.HAPPY)
``` ```python
mixed_up_list = ["hello!", 1.234, Image.HAPPY]
``` ```python
primes = [2, 3, 5, 7, 11, 13, 17, 19]
``` ```python
shopping = ["Eggs", "Bacon", "Tomatoes" ]
``` all_boats = [boat1, boat2, boat3, boat4, boat5, boat6]
display.show(all_boats, delay=200)
``` boat = Image("05050:"
             "05050:"
             "05050:"
             "99999:"
             "09990") boat1 = Image("05050:"
              "05050:"
              "05050:"
              "99999:"
              "09990") boat2 = Image("00000:"
              "05050:"
              "05050:"
              "05050:"
              "99999") boat3 = Image("00000:"
              "00000:"
              "05050:"
              "05050:"
              "05050") boat3 = Image("00000:"
              "00000:"
              "05050:"
              "05050:"
              "05050") boat5 = Image("00000:"
              "00000:"
              "00000:"
              "00000:"
              "05050") boat6 = Image("00000:"
              "00000:"
              "00000:"
              "00000:"
              "00000") display.show(Image.ALL_CLOCKS, loop=True, delay=100)
``` display.show(boat)
``` ```python
from microbit import * ```python
from microbit import * 