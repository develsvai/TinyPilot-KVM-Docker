#!/bin/bash

# ===================================================================
# [최종 해결안] TinyPilot 호환 하이브리드 절대좌표 마우스 설정
# - 키보드: 표준 장치 (/dev/hidg0)
# - 마우스: 7바이트를 받지만 휠 데이터는 무시하는 장치 (/dev/hidg1)
# ===================================================================

# USB Gadget 설정 디렉토리
GADGET_DIR="/sys/kernel/config/usb_gadget/g1"

echo "Loading composite module..."
sudo modprobe libcomposite

# --- 0. 이미 /dev/hidg* 존재 시 바로 종료 ---
if [ -e /dev/hidg0 ] && [ -e /dev/hidg1 ]; then
  echo "✅ HID gadget devices already exist (/dev/hidg0, /dev/hidg1). Skipping setup."
  exit 0
fi

# --- 1. 기존 설정 정리 ---
if [ -d "$GADGET_DIR" ]; then
  echo "Removing existing gadget configuration..."
  echo "" | sudo tee "$GADGET_DIR/UDC" > /dev/null 2>&1 || true
  sleep 1
  if [ -d "$GADGET_DIR/configs/c.1" ]; then
    sudo find "$GADGET_DIR/configs/c.1" -type l -exec rm {} \;
  fi
  sudo rm -rf "$GADGET_DIR"
fi

# --- 2. 가젯 기본 설정 ---
echo "Creating new USB Gadget configuration..."
sudo mkdir -p "$GADGET_DIR"
cd "$GADGET_DIR" || { echo "Failed to cd to $GADGET_DIR"; exit 1; }

echo 0x1d6b | sudo tee idVendor
echo 0x0104 | sudo tee idProduct
echo 0x0100 | sudo tee bcdDevice
echo 0x0200 | sudo tee bcdUSB

sudo mkdir -p strings/0x409
echo "tinypilot-hid-final" | sudo tee strings/0x409/serialnumber
echo "TinyPilot" | sudo tee strings/0x409/manufacturer
echo "Hybrid HID (Kbd+AbsMouse)" | sudo tee strings/0x409/product

# --- 3. HID 함수 설정 ---

# 🔹 키보드 (hid.usb0) - 변경 없음
echo "Setting up Keyboard (hid.usb0)..."
sudo mkdir -p functions/hid.usb0
echo 1 | sudo tee functions/hid.usb0/protocol
echo 1 | sudo tee functions/hid.usb0/subclass
echo 8 | sudo tee functions/hid.usb0/report_length
sudo bash -c 'printf "\x05\x01\x09\x06\xa1\x01\x05\x07\x19\xe0\x29\xe7\x15\x00\x25\x01\x95\x08\x75\x01\x81\x02\x95\x01\x75\x08\x81\x03\x95\x05\x75\x01\x05\x08\x19\x01\x29\x05\x91\x02\x95\x01\x75\x03\x91\x03\x95\x06\x75\x08\x15\x00\x25\x65\x05\x07\x19\x00\x29\x65\x81\x00\xc0" > functions/hid.usb0/report_desc'

# 🔹 하이브리드 절대좌표 마우스 (hid.usb1)
echo "Setting up HYBRID Absolute Mouse (hid.usb1)..."
sudo mkdir -p functions/hid.usb1
echo 0 | sudo tee functions/hid.usb1/protocol
echo 0 | sudo tee functions/hid.usb1/subclass
# 보고서 길이를 7바이트로 설정하여 TinyPilot과 맞춤
echo 7 | sudo tee functions/hid.usb1/report_length
# Report Descriptor: 버튼, X/Y좌표는 해석하고 나머지 2바이트는 무시(패딩 처리)
sudo bash -c 'printf "\x05\x01\x09\x02\xa1\x01\x09\x01\xa1\x00\x05\x09\x19\x01\x29\x03\x15\x00\x25\x01\x95\x03\x75\x01\x81\x02\x95\x01\x75\x05\x81\x03\x05\x01\x09\x30\x09\x31\x16\x00\x00\x26\xff\x7f\x75\x10\x95\x02\x81\x02\x95\x02\x75\x08\x81\x01\xc0\xc0" > functions/hid.usb1/report_desc'

# --- 4. USB 구성 및 장치 연결 ---
echo "Linking functions to configuration..."
sudo mkdir -p configs/c.1/strings/0x409
echo "Default Configuration" | sudo tee configs/c.1/strings/0x409/configuration
echo 250 | sudo tee configs/c.1/MaxPower

sudo ln -s functions/hid.usb0 configs/c.1/
sudo ln -s functions/hid.usb1 configs/c.1/

# --- 5. UDC 활성화 및 권한 설정 ---
echo "Activating UDC..."
UDC_DEVICE=$(ls /sys/class/udc | head -n 1)
if [ -z "$UDC_DEVICE" ]; then
  echo "❌ Error: No UDC device found!"
  exit 1
fi
echo "$UDC_DEVICE" | sudo tee UDC

sleep 1
echo "Setting permissions for /dev/hidg*..."
sudo chmod 666 /dev/hidg0 2>/dev/null
sudo chmod 666 /dev/hidg1 2>/dev/null

echo "✅ Final Hybrid HID Gadget setup complete. Please check the TinyPilot web interface."
