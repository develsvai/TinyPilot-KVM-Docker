#!/bin/bash

# USB Gadget 설정 디렉토리
GADGET_DIR="/sys/kernel/config/usb_gadget/g1"
sudo modprobe libcomposite

# 기존 설정 제거
if [ -d "$GADGET_DIR" ]; then
  echo "Removing existing gadget configuration..."

  # UDC 설정 해제
  echo "" | sudo tee $GADGET_DIR/UDC || true
  sleep 1

  # 기존 설정 삭제
  sudo rm -rf $GADGET_DIR
fi

echo "Creating USB Gadget configuration..."

# USB Gadget 기본 설정
sudo mkdir -p $GADGET_DIR
cd $GADGET_DIR

echo 0x1d6b | sudo tee idVendor       # Linux Foundation Vendor ID
echo 0x0104 | sudo tee idProduct      # Multifunction Composite Gadget Product ID
echo 0x0100 | sudo tee bcdDevice      # Device release number
echo 0x0200 | sudo tee bcdUSB         # USB 2.0

sudo mkdir -p strings/0x409
echo "1234567890" | sudo tee strings/0x409/serialnumber
echo "My Manufacturer" | sudo tee strings/0x409/manufacturer
echo "My Composite HID Device" | sudo tee strings/0x409/product

# 🔹 첫 번째 HID 기능 설정 (키보드)
sudo mkdir -p functions/hid.usb0
echo 1 | sudo tee functions/hid.usb0/protocol
echo 1 | sudo tee functions/hid.usb0/subclass
echo 8 | sudo tee functions/hid.usb0/report_length

# 🔹 첫 번째 HID Report Descriptor 설정 (키보드) - printf 방식 적용
sudo bash -c 'printf "\x05\x01\x09\x06\xA1\x01\x05\x07\x19\xE0\x29\xE7\x15\x00\x25\x01\x95\x08\x75\x01\x81\x02\x95\x01\x75\x08\x81\x03\x95\x05\x75\x01\x05\x08\x19\x01\x29\x05\x91\x02\x95\x01\x75\x03\x91\x03\x95\x06\x75\x08\x15\x00\x25\x65\x05\x07\x19\x00\x29\x65\x81\x00\xC0" > functions/hid.usb0/report_desc'

# 🔹 두 번째 HID 기능 설정 (마우스)
MOUSE_FUNCTIONS_DIR="functions/hid.mouse"
sudo mkdir -p "$MOUSE_FUNCTIONS_DIR"
echo 0 | sudo tee "${MOUSE_FUNCTIONS_DIR}/protocol"
echo 0 | sudo tee "${MOUSE_FUNCTIONS_DIR}/subclass"
echo 5 | sudo tee "${MOUSE_FUNCTIONS_DIR}/report_length"

# 🔹 마우스 HID Report Descriptor 작성 - printf 방식 적용
sudo bash -c 'printf "\x05\x01\x09\x02\xA1\x01\x05\x09\x19\x01\x29\x08\x15\x00\x25\x01\x95\x08\x75\x01\x81\x02\x05\x01\x09\x30\x09\x31\x16\x00\x00\x26\xFF\x7F\x75\x10\x95\x02\x81\x02\x09\x38\x15\x81\x25\x7F\x75\x08\x95\x01\x81\x06\x05\x0C\x0A\x38\x02\x15\x81\x25\x7F\x75\x08\x95\x01\x81\x06\xC0" > functions/hid.mouse/report_desc'

# 🔹 USB 구성 연결
sudo mkdir -p configs/c.1/strings/0x409
echo "Configuration 1" | sudo tee configs/c.1/strings/0x409/configuration
echo 250 | sudo tee configs/c.1/MaxPower

# 🔹 HID 장치 링크 (키보드 & 마우스)
sudo ln -s functions/hid.usb0 configs/c.1/
sudo ln -s functions/hid.mouse configs/c.1/

# 🔹 UDC 활성화
UDC_DEVICE=$(ls /sys/class/udc | head -n 1)
if [ -z "$UDC_DEVICE" ]; then
  echo "❌ Error: No UDC device found! Check if your kernel supports USB gadget mode."
  exit 1
fi
echo $UDC_DEVICE | sudo tee UDC

echo "✅ Multiple USB HID Gadgets 설정이 완료되었습니다."
