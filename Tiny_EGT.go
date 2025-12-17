package main

import (
    "fmt"
    "math/rand"
    "time"
)

func main() {
    rand.Seed(time.Now().UnixNano())
    fmt.Println("=== Tiny EGT Module Simulation ===")

    for i := 0; i < 10; i++ {
        temperature := 900 + rand.Intn(101) // 900-1000
        fuelTrim := 0
        if temperature > 950 {
            fuelTrim = -10
        }

        line := fmt.Sprintf("Temperature: %d | Fuel Trim: %d", temperature, fuelTrim)
        if temperature > 950 {
            line += " | WARNING: Overtemp!"
        }
        fmt.Println(line)
    }

    fmt.Println("=== Simulation Complete ===")
}