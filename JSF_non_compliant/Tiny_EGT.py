import random

print("=== Tiny EGT Module Simulation ===")

High_Temp = 950
Crit_Temp = High_Temp + 20

temperatures = []

for _ in range(10):
    base_temp = random.randint(900, 1000)
    sudden_event = random.randint(1, 10)

    if sudden_event == 1:
        temperature = random.randint(1000, 1100)
        fuel_trim = -100
    elif sudden_event == 5:
        temperature = random.randint(800, 900)
        fuel_trim = 100
    else:
        temperature = base_temp
        if temperature > Crit_Temp:
            fuel_trim = -20
        elif temperature > High_Temp:
            fuel_trim = -10
        else:
            fuel_trim = 0

    line = f"Temperature: {temperature} | Fuel Trim: {fuel_trim}"

    if temperature > Crit_Temp + 30:
        line += " | Sudden Spike!"
    elif temperature > Crit_Temp:
        line += " | CRITICAL!"
    elif temperature > High_Temp:
        line += " | WARNING: Overtemp!"
    elif temperature < High_Temp - 50:
        line += " | Sudden Cooling!"

    print(line)
    temperatures.append(temperature)

print("=== Simulation Complete ===")
print(f"Max Temp: {max(temperatures)}")
print(f"Sum of Temps: {sum(temperatures)}")