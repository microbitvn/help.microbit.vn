# Về bo mạch micro:bit

![microbit nhìn từ mặt trước và mặt sau](resources/microbit_front_back.png)

Bộ xử lý trung tâm (CPU) của micro:bit là chip [Nordic nRF51822](https://www.nordicsemi.com/eng/Products/Bluetooth-Smart-Bluetooth-low-energy/nRF51822)
và nó điều khiển tất cả các chức năng được cung cấp bởi micro:bit.

Trên bo micro:bit đã có sẵn:

- một [màn hình](ubit/display.md) LED matrận 5 x 5.
- 2 [nút bấm](ubit/button.md) lập trình được.
- một [cảm biến gia tốc](ubit/accelerometer.md) 3 trục.
- một [e-compass](ubit/compass.md).
- [Bluetooth](ubit/blemanager.md).
- 20 [chân IO](ubit/io.md) người dùng điều khiển được, với chế độ tương tự (Analog) hoặc số (Digital).
- khả năng giao tiếp [nối tiếp](ubit/serial.md) qua ngõ USB hoặc chân cắm ở cạnh.

##Datasheets

<div class="col-sm-4">
    <h3>Nordic nRF51822</h3>
    <p>
        Bộ xử lý trung tâm của micro:bit, chip nRF51822, điều khiển và thực hiện tất cả các chức năng trên
        bo micro:bit.
    </p>
    <p>
        <a target="_blank" href="../resources/datasheets/nRF51822.pdf" class="btn btn-lg btn-outline">
            Datasheet
        </a>
    </p>
</div>
<div class="col-sm-4">
    <h3>NXP MAG3110</h3>
    <p>
        Cảm biến lực từ MAG3110 được dùng kết hợp với cảm biến gia tốc 3 trục
        (MMA8653) để tạo thành một cái e-compass.
    </p>
    <p>
        <a target="_blank" href="../resources/datasheets/MAG3110.pdf" class="btn btn-lg btn-outline">
            Datasheet
        </a>
    </p>
</div>
<div class="col-sm-4">
    <h3>NXP MMA8653</h3>
    <p>
        Cảm biến gia tốc MMA8653 cung cấp thông tin về hướng và gia tốc
        của bo micro:bit.
    </p>
    <p>
        <a target="_blank" href="../resources/datasheets/MMA8653.pdf" class="btn btn-lg btn-outline">
            Datasheet
        </a>
    </p>
</div>