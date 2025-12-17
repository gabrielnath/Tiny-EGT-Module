with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random;

procedure Tiny_EGT is
   -- Current Temperature
   Temperature : Integer := 900;
   Sudden_Temp : Integer := 0;
   High_Temp : Integer := 950;
   Crit_Temp : Integer := High_Temp + 20;
   -- Fuel Adjustment
   Fuel_Trim   : Integer := 0;

   type Int_Array is array (1 .. 10) of Integer;
   Cumulative_Temp : Int_Array := (others => 0); -- Initialize
   Next_Index      : Integer := 1;               -- Track next position

   package Random_Pkg is new Ada.Numerics.Float_Random;
   Gen : Random_Pkg.Generator;
   Rand : Float;

-- Control logic
function Control_Logic return Integer is
begin
   if Temperature > Crit_Temp then
         return -20;
      elsif Temperature > High_Temp then
         return -10;
      else
         return 0;
      end if;
end Control_Logic;

begin
   Put_Line("=== Tiny EGT Module Simulation ===");

   -- Initialize random generator
   Gen := Random_Pkg.Generator;
   Random_Pkg.Reset(Gen);

   for I in 1 .. 10 loop
      -- Random temperature between 900 and 1000
      Rand := Random_Pkg.Random(Gen);
      Temperature := 900 + Integer(Rand * 100.0);
      Sudden_Temp := Integer(Rand * 10);

      if Sudden_Temp = 1 then
         Temperature := 1000 + Integer(Rand * 100.0);
         Fuel_Trim := -100;
      elsif Sudden_Temp = 5 then
         Temperature := 800 + Integer(Rand * 100.0);
         Fuel_Trim := 100;
      else
         Fuel_Trim := Control_Logic;
      end if;

      -- Display output
      Put("Temperature: " & Integer'Image(Temperature)
          & " | Fuel Trim: " & Integer'Image(Fuel_Trim));

      if Temperature > (Crit_Temp + 30) then
         Put_Line(" | Sudden Spike!");
      elsif Temperature > Crit_Temp then
         Put_Line(" | CRITICAL!");
      elsif Temperature > High_Temp then
         Put_Line(" | WARNING: Overtemp!");
      elsif Temperature < (High_Temp - 50) then
         Put_Line(" | Sudden Cooling!");
      else
         New_Line;
      end if;

      -- Store current temperature in the array
      if Next_Index <= Cumulative_Temp'Length then
         Cumulative_Temp(Next_Index) := Temperature;
         Next_Index := Next_Index + 1;
      else
         Put_Line("Array full, cannot store more temperatures.");
      end if;
   end loop;

   -- Max and sum
   declare
      Max_Temp : Integer := Cumulative_Temp(1);
      Sum_Temp : Integer := 0;
   begin
      for I in Cumulative_Temp'Range loop
         if Cumulative_Temp(I) > Max_Temp then
            Max_Temp := Cumulative_Temp(I);
         end if;
         Sum_Temp := Sum_Temp + Cumulative_Temp(I);
      end loop;
      Put_Line("=== Simulation Complete ===");
      Put_Line("Max Temp: " & Integer'Image(Max_Temp));
      Put_Line("Sum of Temps: " & Integer'Image(Sum_Temp));
   end;
end Tiny_EGT;