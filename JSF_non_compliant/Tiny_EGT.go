package main

import (
    "fmt"
    "math/rand"
    "time"
)

func main() {
    rand.Seed(time.Now().UnixNano())
    fmt.Println("=== Tiny EGT Module Simulation ===")

    HighTemp := 950
    CritTemp := HighTemp + 20

    temperatures := []int{}

    for i := 0; i < 10; i++ {
        baseTemp := 900 + rand.Intn(101)
        suddenEvent := rand.Intn(10) + 1

        temperature := baseTemp
        fuelTrim := 0

        if suddenEvent == 1 {
            temperature = 1000 + rand.Intn(101)
            fuelTrim = -100
        } else if suddenEvent == 5 {
            temperature = 800 + rand.Intn(101)
            fuelTrim = 100
        } else {
            if temperature > CritTemp {
                fuelTrim = -20
            } else if temperature > HighTemp {
                fuelTrim = -10
            } else {
                fuelTrim = 0
            }
        }

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
        temperatures = append(temperatures, temperature)
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