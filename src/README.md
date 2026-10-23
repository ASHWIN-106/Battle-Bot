# ESP32 Bluetooth Drive Firmware

This folder contains the submitted Arduino sketch for drive control.

## Device and commands

- Bluetooth Classic device name: `MY_CAR`
- `F`: forward
- `B`: backward
- `L`: left
- `R`: right
- `S`: stop
- `1` through `6`: set PWM duty value

## GPIO assignments

| ESP32 GPIO | Driver input |
|---|---|
| 25 | Left IBT-2 RPWM |
| 26 | Left IBT-2 LPWM |
| 27 | Right IBT-2 RPWM |
| 14 | Right IBT-2 LPWM |

PWM configuration: 20 kHz, 8-bit resolution.

## Important

The sketch is preserved as provided by the team. It has no Bluetooth-loss timeout and does not control the horizontal saw. Confirm the ESP32 Arduino core version because the code uses `ledcAttach(pin, frequency, resolution)`.
