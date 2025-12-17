with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Float_Random;

procedure Tiny_EGT is

   -- ===============================
   -- Constants (No magic numbers)
   -- ===============================
   Base_Temp       : constant Integer := 900;       -- Minimum normal temperature
   Max_Normal_Delta: constant Integer := 100;       -- Normal variation
   Spike_High      : constant Integer := Base_Temp + 100;  -- Sudden high spike
   Spike_Low       : constant Integer := Base_Temp - 100;  -- Sudden low spike
   Sudden_Range    : constant Integer := 10;        -- Random range for sudden events
   High_Temp       : constant Integer := Base_Temp + 50;    -- Warning threshold
   Crit_Temp       : constant Integer := High_Temp + 20;    -- Critical threshold
   Fuel_Spike_High : constant Integer := 100;       -- Fuel trim for low spike
   Fuel_Spike_Low  : constant Integer := -100;      -- Fuel trim for high spike
   Fuel_Ctrl_High  : constant Integer := -10;       -- Fuel trim for high temp warning
   Fuel_Ctrl_Crit  : constant Integer := -20;       -- Fuel trim for critical temp

   -- ===============================
   -- Variables
   -- ===============================
   Temperature      : Integer := Base_Temp;
   Fuel_Trim        : Integer := 0;
   type Int_Array   is array (1 .. 10) of Integer;
   Cumulative_Temp  : Int_Array := (others => 0); -- Stores last 10 temperatures
   Next_Index       : Integer := 1;

   -- Random number generator
   package Random_Pkg is new Ada.Numerics.Float_Random;
   Gen  : Random_Pkg.Generator;
   Rand : Float;

   -- ===============================
   -- Control logic function
   -- ===============================
   function Control_Logic(Current_Temp: Integer) return Integer is
   begin
      if Current_Temp > Crit_Temp then
         return Fuel_Ctrl_Crit;
      elsif Current_Temp > High_Temp then
         return Fuel_Ctrl_High;
      else
         return 0;
      end if;
   end Control_Logic;

begin
   Put_Line("=== Tiny EGT Module Simulation ===");

   -- Initialize random generator
   Gen := Random_Pkg.Generator;
   Random_Pkg.Reset(Gen);

   for I in 1 .. Cumulative_Temp'Length loop
      -- Random base temperature
      Rand := Random_Pkg.Random(Gen);
      Temperature := Base_Temp + Integer(Rand * Float(Max_Normal_Delta));

      -- Check for sudden spike/cooling
      Rand := Random_Pkg.Random(Gen);
      declare
         Sudden_Temp : Integer := Integer(Rand * Float(Sudden_Range));
      begin
         if Sudden_Temp = 1 then
            Temperature := Spike_High + Integer(Random_Pkg.Random(Gen) * Float(Max_Normal_Delta));
            Fuel_Trim := Fuel_Spike_Low;
         elsif Sudden_Temp = 5 then
            Temperature := Spike_Low + Integer(Random_Pkg.Random(Gen) * Float(Max_Normal_Delta));
            Fuel_Trim := Fuel_Spike_High;
         else
            Fuel_Trim := Control_Logic(Temperature);
         end if;
      end;

      -- Display temperature and fuel trim
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

      -- Store temperature in cumulative array
      if Next_Index <= Cumulative_Temp'Length then
         Cumulative_Temp(Next_Index) := Temperature;
         Next_Index := Next_Index + 1;
      end if;
   end loop;

   -- Compute max and sum of temperatures
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
