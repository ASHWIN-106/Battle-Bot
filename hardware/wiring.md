# Wiring Documentation

## Controller and drive signal wiring

Controller: ESP32 DevKit (exact module to be confirmed)  
Motor drivers: 2 × IBT-2 / BTS7960

| ESP32 GPIO | Driver | Signal |
|---|---|---|
| GPIO 25 | Left driver | RPWM |
| GPIO 26 | Left driver | LPWM |
| GPIO 27 | Right driver | RPWM |
| GPIO 14 | Right driver | LPWM |

The firmware reverses the right-side signal mapping to account for motor orientation.

## Drive grouping — verify physically

The intended arrangement is one driver for the left drive group and one for the right drive group. Confirm whether two motors are connected to each driver, and whether they are wired in parallel. Check combined current against the driver's ratings.

## Connections not yet confirmed

Do not treat this document as a complete wiring diagram until these items have been inspected on the physical robot:

- Battery positive and negative to each driver
- Common ground between ESP32 and driver logic
- R_EN and L_EN wiring on both IBT-2 boards
- Motor output terminals and polarity
- Buck converter input and regulated output
- Fuse, main power switch, and emergency-stop arrangement
- Saw motor supply, control, and safety isolation

## Safe verification

1. Disconnect battery power before changing wiring.
2. Verify polarity and continuity before powering on.
3. Test the drive with wheels raised and the saw disabled.
4. Confirm forward, reverse, turns, and stop.
5. Test communication-loss behavior only in a controlled test setup.

The current firmware has no Bluetooth command timeout; add and verify a failsafe before driving normally.
