import random

print("=== Tiny EGT Module Simulation ===")

for _ in range(10):
    temperature = random.randint(900, 1000)
    fuel_trim = -10 if temperature > 950 else 0
    line = f"Temperature: {temperature} | Fuel Trim: {fuel_trim}"
    if temperature > 950:
        line += " | WARNING: Overtemp!"
    print(line)

print("=== Simulation Complete ===")