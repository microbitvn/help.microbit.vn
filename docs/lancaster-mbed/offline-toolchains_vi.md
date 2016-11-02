# Yotta

Phần mềm micro:bit DAL được xây dựng dựa trên [ARM mbed](http://mbed.com) nên sử dụng [yotta](http://yotta.mbed.com) làm hệ thống xây dựng chương trình offline.

Khi sử dụng `yotta` để xây dựng dự án cho micro:bit, hiện nay có hai bộ công cụ (toolchain) hỗ trợ:

* GCC
* ARMCC

## Cài đặt trên Windows

### Cài đặt yotta và các gói phụ thuộc

Bước đầu tiên là lấy `yotta` và các gói phụ thuộc về máy của bạn, để làm việc này bạn hãy làm theo hướng dẫn cài đặt [ở đây](http://docs/yottabuild.org/#installing).

Để dùng micro:bit làm thiết bị đích, bạn còn cần thêm công cụ `srecord`, có thể cài đặt được trên **Windows** từ [sourceforge](http://srecord.sourceforge.net/).

`srecord` được dùng để tạo ra chương trình cuối cùng chạy được cho micro:bit nên nó là một gói phụ thuộc cơ bản.

### Lấy về dự án mẫu

```bash
git clone https://github.com/lancaster-university/microbit-samples
cd microbit-samples
```

### Chọn thiết bị đích cho yotta

Một cái đích (target) cho `yotta` bao gồm thông tin mà `yotta` cần để xây dựng một dự án từ một bộ phần cứng cụ thể. Thông tin này cũng gồm loại trình biên dịch. Các dự án micro:bit có thể được biên dịch với cả `armcc` lẫn `gcc`, nhưng do `gcc` được cài đặt sẵn với chương trình cài đặt `yotta` nên chúng ta sẽ dùng `gcc` làm mặc định và chọn một cái đích cụ thể là micro:bit có các thông tin về phần cứng trên bo mạch.

Bạn có thể dùng hoặc `yotta` hoặc `yt`, để gõ dễ hơn!

```
yt target bbc-microbit-classic-gcc
```

!!! note "Lưu ý"
    Trong microbit-samples cái đích này (micro:bit) được chỉnh mặc định.

Bạn chỉ cần cài đặt thiết bị đích (target) một lần cho mỗi dự án. Tất cả các lệnh `yotta` sau đó sẽ sử dụng thông tin của đích này (ví dụ, khi tìm kiếm các gói phụ thuộc).

#### Biên dịch dự án

```
yt build
```

### Ghi lên bo micro:bit của bạn

Bước cuối cùng là kiểm tra xem chương trình hex của bạn có chạy không.

Lệnh `yt build` sẽ đặt các tập tin trong `/build/<TÊN_THIẾT_BỊ_ĐÍCH>/source`. Tập tin bạn cần để ghi vào bo mạch là `microbit-combined.hex`. Chỉ cần kéo và thả tập tin hex vào ổ đĩa USB MICROBIT.

Trong trường hợp ví dụ này, sử dụng `bbc-microbit-classic-gcc` chúng ta có thể ghi vào micro:bit (giả sử nó đã được gắn vào máy tính và là ổ đĩa `E:`) như sau:

```
copy build\bbc-microbit-classic-gcc\source\microbit-samples-combined.hex E:
```
Kết quả mong đợi là bo micro:bit sẽ chạy ngang dòng chữ `HELLO WORLD! :)` trên màn hình của nó.

____________________

## Cài đặt trên Mac OSX

### Cài đặt yotta và các gói phụ thuộc

Bước đầu tiên là lấy `yotta` và các gói phụ thuộc về máy của bạn, để làm việc này bạn hãy làm theo hướng dẫn cài đặt [ở đây](http://docs/yottabuild.org/#installing).

Để dùng micro:bit làm thiết bị đích, bạn còn cần thêm công cụ `srecord`, có thể cài đặt được trên ** Mac OSX ** sử dụng [brew](http://brew.sh/):

```
brew install srecord
```

Bạn cũng có thể cài đặt nó bằng tay từ [sourceforge](http://srecord.sourceforge.net/).

`srecord` được dùng để tạo ra chương trình cuối cùng chạy được cho micro:bit nên nó là một gói phụ thuộc cơ bản.

### Lấy về dự án mẫu

```bash
git clone https://github.com/lancaster-university/microbit-samples
cd microbit-samples
```

### Chọn thiết bị đích cho yotta

Một cái đích (target) cho `yotta` bao gồm thông tin mà `yotta` cần để xây dựng một dự án từ một bộ phần cứng cụ thể. Thông tin này cũng gồm loại trình biên dịch. Các dự án micro:bit có thể được biên dịch với cả `armcc` lẫn `gcc`, nhưng do `gcc` được cài đặt sẵn với chương trình cài đặt `yotta` nên chúng ta sẽ dùng `gcc` làm mặc định và chọn một cái đích cụ thể là micro:bit có các thông tin về phần cứng trên bo mạch.

Bạn có thể dùng hoặc `yotta` hoặc `yt`, để gõ dễ hơn!

```
yt target bbc-microbit-classic-gcc
```

!!! note "Lưu ý"
    Trong microbit-samples cái đích này (micro:bit) được chỉnh mặc định.

Bạn chỉ cần cài đặt thiết bị đích (target) một lần cho mỗi dự án. Tất cả các lệnh `yotta` sau đó sẽ sử dụng thông tin của đích này (ví dụ, khi tìm kiếm các gói phụ thuộc).

#### Biên dịch dự án

```
yt build
```

### Ghi lên bo micro:bit của bạn

Bước cuối cùng là kiểm tra xem chương trình hex của bạn có chạy không.

Lệnh `yt build` sẽ đặt các tập tin trong `/build/<TÊN_THIẾT_BỊ_ĐÍCH>/source`. Tập tin bạn cần để ghi vào bo mạch là `microbit-combined.hex`. Chỉ cần kéo và thả tập tin hex vào ổ đĩa USB MICROBIT.

Trong trường hợp ví dụ này, sử dụng `bbc-microbit-classic-gcc` chúng ta có thể ghi vào micro:bit (giả sử nó đã được gắn vào máy tính ở đường dẫn `/Volumes/"MICROBIT"`) như sau:

```
cp ./build/bbc-microbit-classic-gcc/source/microbit-samples-combined.hex /Volumes/"MICROBIT"
```

Kết quả mong đợi là bo micro:bit sẽ chạy ngang dòng chữ `HELLO WORLD! :)` trên màn hình của nó.

!!! note "Lưu ý"
    Lưu ý rằng nếu bạn muốn sao chép các tập tin từ dòng lệnh, bạn có thể sử dụng lệnh sau đây trong bất kỳ dự án 'yotta` nào, với điều kiện bạn cắm vào máy chỉ một bo micro:bit:

    ```
    cp build/$(yt --plain target | head -n 1 | cut -f 1 -d' ')/source/$(yt --plain ls | head -n 1 | cut -f 1 -d' ')-combined.hex  /Volumes/"MICROBIT"
    ```

____________________

## Cài đặt trên Linux

### Cài đặt yotta và các gói phụ thuộc

Bước đầu tiên là lấy `yotta` và các gói phụ thuộc về máy của bạn, để làm việc này bạn hãy làm theo hướng dẫn cài đặt [ở đây](http://docs/yottabuild.org/#installing).

Để dùng micro:bit làm thiết bị đích, bạn còn cần thêm công cụ `srecord`, có thể cài đặt được trên **Ubuntu** sử dụng:

```
sudo apt-get install srecord
```

Bạn cũng có thể cài đặt nó bằng tay từ [sourceforge](http://srecord.sourceforge.net/).

`srecord` được dùng để tạo ra chương trình cuối cùng chạy được cho micro:bit nên nó là một gói phụ thuộc cơ bản.

### Lấy về dự án mẫu

```bash
git clone https://github.com/lancaster-university/microbit-samples
cd microbit-samples
```

### Chọn thiết bị đích cho yotta

Một cái đích (target) cho `yotta` bao gồm thông tin mà `yotta` cần để xây dựng một dự án từ một bộ phần cứng cụ thể. Thông tin này cũng gồm loại trình biên dịch. Các dự án micro:bit có thể được biên dịch với cả `armcc` lẫn `gcc`, nhưng do `gcc` được cài đặt sẵn với chương trình cài đặt `yotta` nên chúng ta sẽ dùng `gcc` làm mặc định và chọn một cái đích cụ thể là micro:bit có các thông tin về phần cứng trên bo mạch.

Bạn có thể dùng hoặc `yotta` hoặc `yt`, để gõ dễ hơn!

```
yt target bbc-microbit-classic-gcc
```

!!! note "Lưu ý"
    Trong microbit-samples cái đích này (micro:bit) được chỉnh mặc định.

Bạn chỉ cần cài đặt thiết bị đích (target) một lần cho mỗi dự án. Tất cả các lệnh `yotta` sau đó sẽ sử dụng thông tin của đích này (ví dụ, khi tìm kiếm các gói phụ thuộc).

#### Biên dịch dự án

```
yt build
```

### Ghi lên bo micro:bit của bạn

Bước cuối cùng là kiểm tra xem chương trình hex của bạn có chạy không.

Lệnh `yt build` sẽ đặt các tập tin trong `/build/<TÊN_THIẾT_BỊ_ĐÍCH>/source`. Tập tin bạn cần để ghi vào bo mạch là `microbit-combined.hex`. Chỉ cần kéo và thả tập tin hex vào ổ đĩa USB MICROBIT.

Trong trường hợp ví dụ này, sử dụng `bbc-microbit-classic-gcc` chúng ta có thể ghi vào micro:bit (giả sử nó đã được gắn vào máy tính ở đường dẫn `/media/MICROBIT`) như sau:

```
cp ./build/bbc-microbit-classic-gcc/source/microbit-samples-combined.hex /media/MICROBIT
```
Kết quả mong đợi là bo micro:bit sẽ chạy ngang dòng chữ `HELLO WORLD! :)` trên màn hình của nó.

!!! note "Lưu ý"
    Lưu ý rằng nếu bạn muốn sao chép các tập tin từ dòng lệnh, bạn có thể sử dụng lệnh sau đây trong bất kỳ dự án 'yotta` nào, với điều kiện bạn cắm vào máy chỉ một bo micro:bit:

    ```
    cp build/$(yt --plain target | head -n 1 | cut -f 1 -d' ')/source/$(yt --plain ls | head -n 1 | cut -f 1 -d' ')-combined.hex /media/MICROBIT/
    ```