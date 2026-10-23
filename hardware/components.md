# Hardware Components

This is an initial inventory based on details reported by the team. Confirm exact models and ratings from labels or datasheets before final submission.

| Component | Reported quantity / detail | Verification needed |
|---|---|---|
| ESP32 DevKit | 1 | Exact board and module |
| IBT-2 / BTS7960 motor driver | 2 | Board model and current/thermal limits |
| DC geared motors | 4 | Voltage, RPM, stall current |
| Battery | 7 Ah reported | Nominal voltage, chemistry, discharge rating |
| DC-DC buck converter | At least 1 reported | Model, input range, output voltage/current |
| Wheels | 4 | Diameter and mounting |
| Chassis | Custom | Material and dimensions |
| Horizontal saw mechanism | 1 reported | Separate drive/control and guarding requirements |
| LED strips | Red | Supply voltage and current |

## Electrical checks

- Verify driver current against the combined motor current if two motors share a driver.
- Confirm converter output before connecting the ESP32.
- Add suitable fusing and a physical emergency stop.
- Do not power the motors from the ESP32 3.3 V pin.
