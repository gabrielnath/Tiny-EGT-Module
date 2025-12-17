# Tiny EGT Module Simulation

This is just my little fun project while learning Ada and exploring some aerospace engineering. A simple simulation of an aircraft Engine Exhaust Temperature (EGT) controller, showing very, very basic control logic in multiple languages (Ada, Python, Go).

## Project Features
- Randomized temperature readings (900–1000°C)
- Fuel trim adjustment if temperature exceeds 950°C
- Console warnings for over-temperature conditions
- Multi-language demo — for my stubborn brain 🧠

## How to Run

### Ada
```bash
gnatmake Tiny_EGT.adb
./Tiny_EGT    # Windows: Tiny_EGT.exe
```

### Python
```bash
python Tiny_EGT.py
```

### GO
```bash
go run tiny_egt.go
```

## Notes
- Purely educational — no real aircraft involved ✈️
- Shows clean, tiny control logic for fun