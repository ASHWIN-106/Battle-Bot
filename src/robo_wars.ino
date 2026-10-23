#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

// ================= MOTOR PINS =================

// LEFT IBT-2
#define LEFT_RPWM   25
#define LEFT_LPWM   26

// RIGHT IBT-2
#define RIGHT_RPWM  27
#define RIGHT_LPWM  14

// ================= PWM SETTINGS =================

#define PWM_FREQ 20000
#define PWM_RES 8

int maxSpeed = 100;

// ================= SETUP =================

void setup() {
  Serial.begin(115200);

  // Bluetooth name
  SerialBT.begin("MY_CAR");

  // Left IBT-2 PWM
  ledcAttach(LEFT_RPWM, PWM_FREQ, PWM_RES);
  ledcAttach(LEFT_LPWM, PWM_FREQ, PWM_RES);

  // Right IBT-2 PWM
  ledcAttach(RIGHT_RPWM, PWM_FREQ, PWM_RES);
  ledcAttach(RIGHT_LPWM, PWM_FREQ, PWM_RES);

  // Start with motors stopped
  stopCar();

  Serial.println("MY_CAR READY");
  Serial.println("Bluetooth: MY_CAR");
}

// ================= LEFT MOTOR =================

void leftForward(int speed) {
  ledcWrite(LEFT_RPWM, speed);
  ledcWrite(LEFT_LPWM, 0);
}

void leftBackward(int speed) {
  ledcWrite(LEFT_RPWM, 0);
  ledcWrite(LEFT_LPWM, speed);
}

// ================= RIGHT MOTOR =================
// Right side is reversed

void rightForward(int speed) {
  ledcWrite(RIGHT_RPWM, 0);
  ledcWrite(RIGHT_LPWM, speed);
}

void rightBackward(int speed) {
  ledcWrite(RIGHT_RPWM, speed);
  ledcWrite(RIGHT_LPWM, 0);
}

// ================= STOP =================

void stopCar() {
  ledcWrite(LEFT_RPWM, 0);
  ledcWrite(LEFT_LPWM, 0);
  ledcWrite(RIGHT_RPWM, 0);
  ledcWrite(RIGHT_LPWM, 0);
}

// ================= MOVEMENT =================

void moveForward() {
  leftForward(maxSpeed);
  rightForward(maxSpeed);
  Serial.println("FORWARD");
}

void moveBackward() {
  leftBackward(maxSpeed);
  rightBackward(maxSpeed);
  Serial.println("BACKWARD");
}

void turnLeft() {
  leftBackward(maxSpeed);
  rightForward(maxSpeed);
  Serial.println("LEFT");
}

void turnRight() {
  leftForward(maxSpeed);
  rightBackward(maxSpeed);
  Serial.println("RIGHT");
}

// ================= COMMAND PROCESSING =================

void processCommand(char command) {
  Serial.print("Command: ");
  Serial.println(command);

  switch (command) {
    case 'F':
    case 'f':
      moveForward();
      break;

    case 'B':
    case 'b':
      moveBackward();
      break;

    case 'L':
    case 'l':
      turnLeft();
      break;

    case 'R':
    case 'r':
      turnRight();
      break;

    case 'S':
    case 's':
      stopCar();
      Serial.println("STOP");
      break;

    case '1':
      maxSpeed = 50;
      Serial.println("Speed = 50");
      break;

    case '2':
      maxSpeed = 75;
      Serial.println("Speed = 75");
      break;

    case '3':
      maxSpeed = 100;
      Serial.println("Speed = 100");
      break;

    case '4':
      maxSpeed = 125;
      Serial.println("Speed = 125");
      break;

    case '5':
      maxSpeed = 175;
      Serial.println("Speed = 175");
      break;

    case '6':
      maxSpeed = 255;
      Serial.println("Speed = 255");
      break;

    default:
      Serial.println("Unknown command");
      break;
  }
}

// ================= MAIN LOOP =================

void loop() {
  while (SerialBT.available()) {
    char command = SerialBT.read();

    // Ignore spaces and new lines
    if (command != '\n' && command != '\r' && command != ' ') {
      processCommand(command);
    }
  }

  // Original sketch has no Bluetooth command timeout.
  // Add and test a failsafe before normal driving.
}
