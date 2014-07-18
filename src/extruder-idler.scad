
// PRUSA iteration3
// NEMA 17 extruder idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include<extruderConfig.scad>


extraThickness = 5;
filaSlotWidth = 3.3;
ballBearingDia = 22; //608zz
bearingRodDia = 8;   //M8 grub screw (25mm)
filaSlotLen = 4.5;
standVerticalAdj = 1;  //thin the bottom so it stands vertical when clamping the filament
bearingRodCenterToInnerSurface = 4.1+3-2;
guideLen = ballBearingDia/2-bearingRodCenterToInnerSurface+filaSlotLen;//14;
echo(guideLen);
blockMaxThickness = bearingRodDia+3+extraThickness;

module extruder_idler_base(){
 translate([0.25,0,0])
	{ 
	cube([24,42+extraHeight,blockMaxThickness]);
	translate([(24-9)/2-0.25,42+extraHeight-9.5,blockMaxThickness])
		{
		difference()
			{
			cube([9,9.5,guideLen]);
			translate([(9-filaSlotWidth)/2,0,guideLen-filaSlotLen])
				{
				cube([filaSlotWidth,10,filaSlotLen]);
				translate([filaSlotWidth/2,10,0])
					rotate([90,0,0])
					cylinder(d = filaSlotWidth,h=10,$fn = 16);
				}	
			}
		}
	}

}

module extruder_idler_holes(){
 translate([12,21,extraThickness]){
  // Main cutout
  cube([11-2,23,25], center= true);
  // Idler shaft
  translate([-12,0,4.1+2])rotate([0,90,0])cylinder(r=4.1, h=24);
  // Screw holes
  //translate([7,-16,-1])cylinder(r=2.2, h=24);
  //translate([-7,-16,-1])cylinder(r=2.2, h=24);
translate([0,0,-extraThickness])
	{
  	translate([7,16,-1])cylinder(r=2.2, h=24+extraThickness, $fn=20);
  	translate([-7,16,-1])cylinder(r=2.2, h=24+extraThickness, $fn=20);

	translate([7,15,-1])cylinder(r=2.2, h=24+extraThickness, $fn=20);
   translate([-7,15,-1])cylinder(r=2.2, h=24+extraThickness, $fn=20);
	}
 }

//top cutout
translate([-0.5,29,-0.01])
	{
	hull()
		{
		cube([25,20,0.1]);	
		translate([0,3.5,extraThickness+screwTrapAdj-3.5])
	   	cube([25,20,0.1]);
		}	
	}


//bottom cutout
translate([-0.5,-extraHeight,-0.01])
	{
	hull()
		{
		cube([25,9+extraHeight,0.1]);	
		translate([0,-3.5,extraThickness+standVerticalAdj])
	   	cube([25,9,0.1]);
		}	
	}
}



// Idler final part
module idler(){
 difference(){
  extruder_idler_base();
	translate([0,extraHeight,0])
     extruder_idler_holes();
 }
}

rotate([0,-90,0])
	idler();