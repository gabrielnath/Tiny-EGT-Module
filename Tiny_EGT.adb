with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random;

procedure Tiny_EGT is
   -- Current Temperature
   Temperature : Integer := 900;
   -- Fuel Adjustment
   Fuel_Trim   : Integer := 0;

   package Random_Pkg is new Ada.Numerics.Float_Random;
   Gen : Random_Pkg.Generator;
   Rand : Float;
begin
   Put_Line("=== Tiny EGT Module Simulation ===");

   for I in 1 .. 10 loop
      -- Random temperature between 900 and 1000
      Rand := Random_Pkg.Random(Gen);
      Temperature := 900 + Integer(Rand * 100.0);

      -- Control logic
      if Temperature > 950 then
         Fuel_Trim := -10;
      else
         Fuel_Trim := 0;
      end if;

      -- Display output
      Put("Temperature: " & Integer'Image(Temperature)
          & " | Fuel Trim: " & Integer'Image(Fuel_Trim));

      if Temperature > 950 then
         Put_Line(" | WARNING: Overtemp!");
      else
         New_Line;
      end if;
   end loop;

   Put_Line("=== Simulation Complete ===");
end Tiny_EGT;