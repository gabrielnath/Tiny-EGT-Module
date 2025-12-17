import random

# ===============================
# Constants
# ===============================
BASE_TEMP        = 900
MAX_NORMAL_DELTA = 100
SPIKE_HIGH       = BASE_TEMP + 100
SPIKE_LOW        = BASE_TEMP - 100
SUDDEN_RANGE     = 10

HIGH_TEMP        = BASE_TEMP + 50
CRIT_TEMP        = HIGH_TEMP + 20

FUEL_SPIKE_HIGH  = 100
FUEL_SPIKE_LOW   = -100
FUEL_CTRL_HIGH   = -10
FUEL_CTRL_CRIT   = -20

NUM_ITERATIONS   = 10  # Simulation steps

# ===============================
# Control logic function
# ===============================
def control_logic(temp):
    if temp > CRIT_TEMP:
        return FUEL_CTRL_CRIT
    elif temp > HIGH_TEMP:
        return FUEL_CTRL_HIGH
    else:
        return 0

# ===============================
# Simulation
# ===============================
print("=== Tiny EGT Module Simulation ===")

random.seed(0)  # deterministic for simulation
temperatures = [0] * NUM_ITERATIONS
next_index = 0

for _ in range(NUM_ITERATIONS):
    # Random base temperature
    temperature = BASE_TEMP + int(random.random() * MAX_NORMAL_DELTA)

    # Sudden spike/cooling event
    sudden_temp = int(random.random() * SUDDEN_RANGE)
    if sudden_temp == 1:
        temperature = SPIKE_HIGH + int(random.random() * MAX_NORMAL_DELTA)
        fuel_trim = FUEL_SPIKE_LOW
    elif sudden_temp == 5:
        temperature = SPIKE_LOW + int(random.random() * MAX_NORMAL_DELTA)
        fuel_trim = FUEL_SPIKE_HIGH
    else:
        fuel_trim = control_logic(temperature)

    # Display temperature and fuel trim
    line = f"Temperature: {temperature} | Fuel Trim: {fuel_trim}"

    if temperature > CRIT_TEMP + 30:
        line += " | Sudden Spike!"
    elif temperature > CRIT_TEMP:
        line += " | CRITICAL!"
    elif temperature > HIGH_TEMP:
        line += " | WARNING: Overtemp!"
    elif temperature < HIGH_TEMP - 50:
        line += " | Sudden Cooling!"

    print(line)

    # Store temperature
    if next_index < NUM_ITERATIONS:
        temperatures[next_index] = temperature
        next_index += 1

# Compute max and sum
max_temp = max(temperatures)
sum_temp = sum(temperatures)

print("=== Simulation Complete ===")
print(f"Max Temp: {max_temp}")
print(f"Sum of Temps: {sum_temp}")