
PrusaReworkMountHoles();

module PrusaReworkMountHoles(holeSep = 23)
{
translate([-holeSep/2,holeSep/2,0]) CaptiveNutHole();
translate([holeSep/2,holeSep/2,0]) CaptiveNutHole();
translate([-holeSep/2,-holeSep/2,0]) CaptiveNutHole();
translate([holeSep/2,-holeSep/2,0]) CaptiveNutHole();
}

module CaptiveNutHole(screwDia = 4.3,nutDia = 8, nutThick=3.5, thick = 8)
{
translate([0,0,thick])
mirror([0,0,1])
	{
	cylinder(d = screwDia,h=thick, $fn = 32);
	cylinder(d = nutDia,h=nutThick, $fn = 6);
	}
}