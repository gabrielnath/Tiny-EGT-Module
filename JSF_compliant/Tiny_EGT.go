package main

import (
	"fmt"
	"math/rand"
)

// ===============================
// Constants
// ===============================
const (
	BaseTemp       = 900
	MaxNormalDelta = 100
	SpikeHigh      = BaseTemp + 100
	SpikeLow       = BaseTemp - 100
	SuddenRange    = 10

	HighTemp = BaseTemp + 50
	CritTemp = HighTemp + 20

	FuelSpikeHigh = 100
	FuelSpikeLow  = -100
	FuelCtrlHigh  = -10
	FuelCtrlCrit  = -20

	NumIterations = 10
)

// Control logic function
func controlLogic(temp int) int {
	if temp > CritTemp {
		return FuelCtrlCrit
	} else if temp > HighTemp {
		return FuelCtrlHigh
	} else {
		return 0
	}
}

func main() {
	rand.Seed(0) // deterministic for JSF-like simulation
	fmt.Println("=== Tiny EGT Module Simulation ===")

	temperatures := make([]int, NumIterations)
	nextIndex := 0

	for i := 0; i < NumIterations; i++ {
		// Random base temperature
		temperature := BaseTemp + rand.Intn(MaxNormalDelta+1)

		// Sudden spike/cooling event
		suddenTemp := rand.Intn(SuddenRange)
		var fuelTrim int
		if suddenTemp == 1 {
			temperature = SpikeHigh + rand.Intn(MaxNormalDelta+1)
			fuelTrim = FuelSpikeLow
		} else if suddenTemp == 5 {
			temperature = SpikeLow + rand.Intn(MaxNormalDelta+1)
			fuelTrim = FuelSpikeHigh
		} else {
			fuelTrim = controlLogic(temperature)
		}

		// Display temperature and fuel trim
		line := fmt.Sprintf("Temperature: %d | Fuel Trim: %d", temperature, fuelTrim)
		if temperature > CritTemp+30 {
			line += " | Sudden Spike!"
		} else if temperature > CritTemp {
			line += " | CRITICAL!"
		} else if temperature > HighTemp {
			line += " | WARNING: Overtemp!"
		} else if temperature < HighTemp-50 {
			line += " | Sudden Cooling!"
		}
		fmt.Println(line)

		// Store temperature
		if nextIndex < NumIterations {
			temperatures[nextIndex] = temperature
			nextIndex++
		}
	}

	// Compute max and sum
	maxTemp := temperatures[0]
	sumTemp := 0
	for _, t := range temperatures {
		if t > maxTemp {
			maxTemp = t
		}
		sumTemp += t
	}

	fmt.Println("=== Simulation Complete ===")
	fmt.Printf("Max Temp: %d\n", maxTemp)
	fmt.Printf("Sum of Temps: %d\n", sumTemp)
}