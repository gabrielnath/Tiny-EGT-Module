# Tiny EGT Module Simulation

This is just my little fun project while I'm diving into Ada and exploring some basic aerospace engineering concepts. It’s a super simple simulation of an aircraft Engine Exhaust Temperature (EGT) controller with very, very basic control logic. The project is written in Ada, Python, and Go (because, why not?).

I’ve organized the project into two folders to show the difference between JSF-style compliant code (the serious, structured stuff) and more “scratch” versions (the naive, learning-on-the-fly stuff):

```
JSF_compliant/
    Tiny_EGT.adb
    Tiny_EGT.py
    Tiny_EGT.go

JSF_non_compliant/
    Tiny_EGT.adb
    Tiny_EGT.py
    Tiny_EGT.go
```

## What is JSF?
JSF stands for Joint Strike Fighter — it's a set of military aircraft software standards (think F-35) that emphasize things like safety, reliability, and determinism. These standards are inspired by Ada (which is another thing I’m currently obsessing over). Here are the key principles of JSF:

- No magic numbers — all constants should be clearly named (I’m not talking about the kind of magic that happens in my brain when I don’t know what I'm doing)
- Encapsulation — functions to keep control logic tidy and organized (no spaghetti code)
- Strong typing and modular design — to prevent that unpredictable, random behavior (and no, I’m not talking about the random things I do in life)
- Deterministic behavior — to make sure that the software does exactly the same thing every time it’s run (unlike my mind contemplating on what to eat today)

For this project, I’ve tried to follow JSF-inspired principles to write cleaner, more structured code with a focus on reliability and readability. I'm still learning, though. So if you see something questionable — well, that’s probably my "learning phase" showing.

## Project Features
- Randomized temperature readings (900–1000°C) with occasional spikes and sudden cooling
- Fuel trim adjustments based on temperature thresholds
- Console warnings for high and critical temperatures
- Cumulative temperature storage with max and sum calculations
- Multi-language demo — for my stubborn brain 🧠
- Educational purpose — helps me practice applying JSF-style principles in different programming languages

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
go run Tiny_EGT.go
```

## Notes
- Purely educational — this is just a simulation, not something that will ever see an actual aircraft ✈️
- Shows how clean JSF-style modules compare to quick prototypes
- Great for exploring control logic in multiple languages (and for my own stubborn, curious brain)