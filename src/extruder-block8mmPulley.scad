// PRUSA iteration3
// NEMA 17 extruder body
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz>, Kliment Yanev and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include<extruderConfig.scad>


nozzleHoleSep = 50;
frontNozzleY = 25;

m5NutDia = 9;
m5NutThick = 5;

hobbedPulleyDia = 8;//12.7;
hobbingDia = 6.15;//10.8;
hobbedPullyGrubDia = 2*6.7;
hobbedPullyGrubFromBase = 4.5;


hobbedPulleyCutDia = hobbedPulleyDia+0.5;

slotAngle = 0;//80;//36;
m3Dia = 3.6;

m3BoltHeadDia = 6.3;

motor_lenght = 23+m5NutThick;//28//34;
motorPlateThick = 6;
//29.74 is the sum of the pitch radius values for the original 8 and 24 tooth pulleys
//37.2 is the sum for 8 and 32 tooth pulleys
shaftSpacing = 36.5;//36.5-1;//37.2; //40.3 measured for Einstein rework 10 and 43
							//Measured to be 36.5 with teeth pushed as close as possible.

shaftSpacingYInitial = 29.1;
motorRaise = 0;
//motorRaise = sqrt(pow(shaftSpacing,2)-pow(shaftSpacingYInitial,2));
motorYExtra = sqrt(pow(shaftSpacing,2)-pow(motorRaise-extraHeight,2))-shaftSpacingYInitial;


// Calculated values

	// Total height of the part is motor lenght plus front plate
	total_height = motor_lenght + motorPlateThick;


module nozzlemount()
{
	// Filament hole	
	rotate([0,90,0]) cylinder(r=2, h=70, $fn=30);

	//oval hole above hobbed bolt
	translate([17+10+hobbedPulleyDia+extraHeight,-1,0]) rotate([0,90,0]) cylinder(r=2, h=20, $fn=30);


	// Tapered filament intake after the drive gear
	translate([17+extraHeight,0,0]) rotate([0,90,0]) 
		cylinder(r2=2.5,r1=2, h=10, $fn=30);

	//J-Head cutout
	translate([1.0,0,0]) rotate([0,90,0]) 
		{
		cylinder(d=16+0.5, h=3.4, $fn=36);
		cylinder(d=16+0.1, h=3.8, $fn=36);
		}

	// Front nozzle mount hole
	translate([0,frontNozzleY,0]) rotate([0,90,0]) cylinder(r=2, h=70);

	// Front nozzle mount hole NUT TRAP
	translate([10-5,frontNozzleY,0]) rotate([0,90,0]) rotate([0,0,30]) cylinder(r=3.3, h=70,$fn=6);

	// Back nozzle mount hole
	translate([0,frontNozzleY-nozzleHoleSep,0]) 
		rotate([0,90,0]) cylinder(r=2, h=70);

	// Back nozzle mount hole NUT TRAP
	translate([10-5,frontNozzleY-nozzleHoleSep,0]) 
		rotate([0,90,0]) rotate([0,0,30])cylinder(r=3.3, h=70,$fn=6);
}






difference()
	{
	union()
		{
		// Base where drive gear is placed
		translate([0,-1,0])cube([42+extraHeight,19,total_height]);
	
		// Front plate (where motor mount is cutout)
		translate([0,-42-2-motorYExtra,0]) cube([42+motorRaise+1,42+3+2+motorYExtra,motorPlateThick]);
	
		// Base plate (nozzle is secured to it)
		translate([-8.99,-42-5,0]) cube([9,80+5+5+5,total_height]);
	
		// IDLER retainer
		translate([-1,30,0]) cube([6, 8+2, total_height]);
	
			// Top bridge holding idler retainer form springing
			translate([-1,15,total_height-1]) cube([6, 20, 1]);
	
			// Bottom bridge holding idler retainer form springing
			translate([-1,15,total_height-30-motorPlateThick+5]) cube([6, 20, 2+motorPlateThick-5]);

//Uncomment to see mount holes outside block
translate([-5-10,13+9,0])
	{
//	translate([0,12,-1])rotate([0,0,0])cylinder(d=m3BoltHeadDia, h=total_height-10+1-10, $fn=15);
//	translate([0,12,total_height-22])rotate([0,0,0])cylinder(r=3.3/2, h=70, $fn=15);
//	translate([0,0-38,-1])rotate([0,0,0])cylinder(d=m3BoltHeadDia, h=total_height-10+1-10, $fn=15);
//	translate([0,0-38,total_height-22])rotate([0,0,0])cylinder(r=3.3/2, h=70, $fn=15);
//	translate([0,0-18,-1])rotate([0,0,0])cylinder(d=m3BoltHeadDia, h=total_height-10+1-8, $fn=15);
//	translate([0,0-18,total_height-22])rotate([0,0,0])cylinder(r=3.3/2, h=70, $fn=15);
	}
		}

//Pretty corners

	// Cutaway corner base plate (motor side)
	translate([-3-18,-70-motorYExtra,-1])rotate([0,0,53-20])cube([70,70,120],true);
	// Cutaway corner base plate (idler side)
	translate([-32,13.5+13,-1])rotate([0,0,40])cube([40,40,60]);

	// Cutaway corner base block (idler side)
	translate([46+extraHeight,12,-1])rotate([0,0,45])cube([40,40,60]);

	// Cutaway corner idler retainer
	translate([6,33+1,-1])rotate([0,0,45])cube([40,40,60]);

// Pretty cutouts
	// Idler retainer pretty cuts
	//translate([-10,23,-0+(total_height-54)]) rotate([-30,0,0]) cube([20,12,60]);
	//translate([0,27,7+(total_height-52)]) rotate([0,23,0]) cube([20,12,50]);

	// Base plate pretty cut
	//translate([-10,-66,-2]) rotate([-23,0,0]) cube([12,20,90]);

	// Motor mount
	translate([motorRaise,-1-motorYExtra,0.5]){

	// Motor axis circle cut
	translate([21,-21,-1]) cylinder(r=13, h=motorPlateThick+1, $fn=90);

	// Material saving ellipse cut
//	translate([-9,-17,-1])
//		rotate([0,0,-30])
//		scale([1.24,.9,1]) 
//		cylinder(r=9, h=motorPlateThick+1, $fn=90);


	// Material and warp saving cut
	translate([15,-45,-1]) cube([30,30,motorPlateThick+1]);

	// Motor screw holes
	translate([21+16,-21+15,-1]) boltSlot(slotAngle,m3Dia,motorPlateThick+1);//cylinder(r=2, h=motorPlateThick+1);
	translate([21-15,-21+15.5,-1]) boltSlot(slotAngle,m3Dia,motorPlateThick+1); //cylinder(r=2, h=motorPlateThick+1);
	translate([21-15,-21-15.9,-1]) boltSlot(slotAngle,m3Dia,motorPlateThick+1); //cylinder(r=2, h=motorPlateThick+1);

//translate([21+15.5,-21+15.5,-1]) cylinder(r=2, h=5);
//translate([21+15.5,-21-15.5,-1]) cylinder(r=2, h=5);
//translate([21-15.5,-21+15.5,-1]) cylinder(r=2, h=5);
//translate([21-15.5,-21-15.5,-1]) cylinder(r=2, h=5);
	}

	// Motor cables hole
	//translate([-5,-35,40.6]) cube([15,18,13]);



// Shaft cutouts
translate([extraHeight,0,0])
	{
	// Main shaft cylinder cut
	translate([21,8.1,7.5]) cylinder(d=hobbedPulleyCutDia, h=total_height-9-1.5, $fn=50);
	// Main shaft box cut
	translate([-hobbedPulleyCutDia/2+21,8,1+6+0.5]) 
		cube([hobbedPulleyCutDia,hobbedPulleyCutDia+10,total_height-12]);

	// Entry main shaft cylinder cut
	translate([21,8.1,-1]) cylinder(r=6, h=3, $fn=50);
	// Entry main shaft box cut
	translate([-6+21,8,-50+7]) cube([12,12,50]);

	// Front axis bearing cylinder cut
	translate([21,8.1,1]) cylinder(r=8.1, h=6, $fn=50);
	// Front axis bearing box cut
	translate([13,8,1]) cube([16.2,20,6]);

	// Back axis bearing cylinder cut
	//translate([21,8.1,-5+total_height-4]) cylinder(r=8.1, h=7.5, $fn=50);
	translate([21,8.1,-5+total_height-4]) cylinder(r=8.1, h=6, $fn=50);
	// Back axis bearing box cut
	translate([13,8,total_height-9-0]) cube([16.2,20,7.5-1.5]);
	}



// X-carriage mounting holes
translate([-5+0.2,13+8.5-4,0]){
	translate([0,12,-1])rotate([0,0,0])cylinder(d=m3BoltHeadDia, h=total_height-10+1-10, $fn=32);
	translate([0,12,total_height-22])rotate([0,0,0])cylinder(r=3.3/2, h=70, $fn=15);
	translate([0,0-38,-1])rotate([0,0,0])cylinder(d=m3BoltHeadDia, h=total_height-10+1-10, $fn=32);
	translate([0,0-38,total_height-22])rotate([0,0,0])cylinder(r=3.3/2, h=70, $fn=15);
	//translate([0,0-18,-1])rotate([0,0,0])cylinder(d=m3BoltHeadDia, h=total_height-10+1-8, $fn=32);
	//translate([0,0-18,total_height-22])rotate([0,0,0])cylinder(r=3.3/2, h=70, $fn=15);
}

// Idler nuts, filament channel and 608 idler bearing cut
translate([extraHeight,0,-(52-total_height)-2])
	{
	// Nozzle mounting holes
	translate([-10-extraHeight,8.1+hobbingDia/2+1.4,52-12]) nozzlemount();
	// Front idler screw nut trap
	translate([32.5,7,52-12-7-3]) cube([15,3,5.7]);
	// Back idler screw nut trap
	translate([32.5,7,52-12-7-3+14]) cube([15,3,5.7]);

	// Back top idler screw hole
	translate([5+32,-1,52-12+7]) rotate([0,90,90]) rotate([0,0,30]) cylinder(r=2, h=40, $fn=6);
	// Back bottom idler screw hole
	translate([5+32,-1,52-12-7]) rotate([0,90,90]) rotate([0,0,30]) cylinder(r=2, h=40, $fn=6);
	// Front top idler screw hole
	translate([5+31,-1,52-12+7]) rotate([0,90,90]) rotate([0,0,30]) cylinder(r=2, h=40, $fn=6);
	// Front bottom idler screw hole
	translate([5+31,-1,52-12-7]) rotate([0,90,90]) rotate([0,0,30]) cylinder(r=2, h=40, $fn=6);

	// Idler 608 bearing cutout
	//translate([21,24+2,35]) cylinder(r=12, h=17.5-1.5, $fn=90);
	translate([21,8.1+hobbingDia/2+0.6+12,35]) cylinder(r=12, h=17.5-1.5, $fn=90);



	}

translate([21+extraHeight,8.1,-1])
	{ 
	translate([0,0,1+6+1+m5NutThick])
		cylinder(d=hobbedPullyGrubDia+0.1, h=hobbedPullyGrubFromBase, $fn=50);

	translate([0,0,1+6])
		{
   	cylinder(d=m5NutDia+0.1, h=m5NutThick, $fn=50);
		translate([0,5,m5NutThick/2])
	   	cube([m5NutDia+0.1,10,m5NutThick],true);
		}
	}

}

module boltSlot(angle = 45,dia = 3.5, height= 8,len = 3)
{
rotate([0,0,angle])
translate([0,0,height/2]) 
union()
	{
	translate([0,-len/2,0])
		cylinder(d=dia,h=height,center=true,$fn=12);
	translate([0,len/2,0])
		cylinder(d=dia,h=height,center=true,$fn=12);
	cube([dia,len,height],true);
	}
}