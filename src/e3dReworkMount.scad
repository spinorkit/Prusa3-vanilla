// J-Head (E3D) mount
// copyright (c) 2013 - Jarek Szczepanski <imrahil@imrahil.com>
// oryginal design derived from http://www.thingiverse.com/thing:26355

length = 25;


mount_spacing = 50;
carriage_mount_dia = 4.5;

// dimensions for E3D hotned
extruder_dia = 16;
extruder_dia2 = 12;
extruder_cyl1_height = 2.8;//-0.2;
extruder_cyl2_height = 6;//5.6;//+0.2;
height = extruder_cyl1_height+extruder_cyl2_height;

hingeDia = 7.6;
hingeLen = 6.8;
m3ScrewDia = 3.4;
mount_screws_dia = 3.5;

m4ScrewDia = 4.4;
m4NutDia = 7.9;
m4NutThick = 3;

carMountScrewSep = 23;
filamentToCarMount = 16; //E3Dv5
carMountSide = 34;
carMountThick = 7;
carMountBlend = 8;

module CarMount(len)
{
difference()
{
union()
{
translate([0,0,12-12])
difference()
	{
	hull()
		{
		translate([carMountThick+filamentToCarMount,0,carMountSide/2/*+height*/]) rotate([0,90,180])
			{
			translate([-len/2,-len/2,0])
				cube([len,len,carMountThick]);
			}
		translate([filamentToCarMount,-mount_spacing/2,0])
			cube([carMountThick,mount_spacing,height]);
		}
//	translate([carMountThick+filamentToCarMount,0,carMountSide/2+height]) rotate([0,90,180])
//		MountHoles();
	}
hull()
	{
	translate([length/2-2,-(mount_spacing+carMountBlend)/2,0])
		cube([0.1,mount_spacing+carMountBlend,height]);
	translate([carMountThick+filamentToCarMount,-(mount_spacing)/2,0])
		cube([0.01,mount_spacing,height]);
	}
}

translate([0, carMountScrewSep/2, height/2])
	{
	rotate([0, 90, 0]) cylinder(d=m4ScrewDia, h=2*length + 1, center=true, $fn=32); // hole for car mount screw
//	translate([carMountThick+filamentToCarMount - 4, 0, 0])
//	   rotate([-90, 0, -90]) cylinder(r=mount_screws_dia, h=5, $fn=6); 
	}
translate([0, -carMountScrewSep/2, height/2])
	{
	rotate([0, 90, 0]) cylinder(d=m4ScrewDia, h=2*length + 1, center=true, $fn=32); // hole for car mount screw
//	translate([carMountThick+filamentToCarMount - 4, 0, 0])
//	   rotate([-90, 0, -90]) cylinder(r=mount_screws_dia, h=5, $fn=6); 
	}

translate([filamentToCarMount, carMountScrewSep/2, height/2+carMountScrewSep])
	rotate([0, 90, 0]) 
		{
		cylinder(d=m4ScrewDia, h=2*length + 1, center=true, $fn=32); // hole for car mount screw
		cylinder(d=m4NutDia, h=2*m4NutThick, center=true, $fn=6); // hole for car mount screw
		}

translate([filamentToCarMount, -carMountScrewSep/2, height/2+carMountScrewSep])
	rotate([0, 90, 0]) 
		{
		cylinder(d=m4ScrewDia, h=2*length + 1, center=true, $fn=32); // hole for car mount screw
		cylinder(d=m4NutDia, h=2*m4NutThick, center=true, $fn=6); // hole for car mount screw
		}

}

}
//module CarMount(len)
//{
//
//difference()
//	{
//	translate([-len/2,-len/2,0])
//		cube([len,len,carMountThick]);
//	MountHoles();
//	
//	}
//}

module MountHoles(holeSep = 23)
{
translate([-holeSep/2,holeSep/2,0]) CaptiveNutHole();
//translate([holeSep/2,holeSep/2,0]) CaptiveNutHole();
translate([-holeSep/2,-holeSep/2,0]) CaptiveNutHole();
//translate([holeSep/2,-holeSep/2,0]) CaptiveNutHole();
}

module CaptiveNutHole(screwDia = m4ScrewDia, nutDia = m4NutDia, nutThick=3.5, thick = 8)
{
translate([0,0,thick])
mirror([0,0,1])
	{
	cylinder(d = screwDia,h=thick+1, $fn = 32);
	cylinder(d = nutDia,h=nutThick+0.1, $fn = 6);
	}
}

CarMount(carMountSide);

// main module
translate([0,0,height/2])
	main();

module main() {
  translate([-20, 0, 0]){
    intersection() {
      mount();
      separator();
    }
	translate([-length/2-7/2,0,-(height-hingeDia)/2])
		{
		difference()
			{
			union()
				{
	      	cube([7,hingeLen,hingeDia],true);
				translate([-7/2,0,0])rotate([90,0,0])
					cylinder(d=hingeDia,h=hingeLen,center=true,$fn = 12);
				}	
			translate([-7/2,0,0])rotate([90,0,0])
				cylinder(d=m3ScrewDia,h=hingeLen,center=true,$fn = 12);					
			}
		}
  }

  difference() {
    mount();
    separator();
  }
}

module mount() {
  difference() {
    plate();
    extruder();
    mount_screws();
  }
}

module plate() {
  difference() {
    union() {
      cube([length, mount_spacing, height],center=true);			// center
      translate([0,mount_spacing/2,0]){
        cylinder(r=length/2, h=height, center=true, $fn=48); 	// round corner
      }

      translate([0, -mount_spacing/2,0]){
        cylinder(r=length/2, h=height, center=true, $fn=32); 	// round corner
      }
    }

    translate([0, -mount_spacing/2,0]){
      cylinder(r=carriage_mount_dia/2, h=height + 1, center=true, $fn=32);	// carriage mount hole
    }

    translate([0, mount_spacing/2,0]){
      cylinder(r=carriage_mount_dia/2, h=height + 1, center=true, $fn=32); // carriage mount hole
    }
  }
}

module extruder() {
  pos1 = height/2 - extruder_cyl1_height/2;// + 0.5;
  pos2 = height/2 - extruder_cyl1_height - extruder_cyl2_height/2;

  union() {
    translate([0, 0, pos1]){
      cylinder(r=extruder_dia/2, h=extruder_cyl1_height/* + 1*/, center=true, $fn=32); 
    }

    translate([0, 0, pos2]){
      cylinder(r=extruder_dia2/2, h=extruder_cyl2_height, center=true, $fn=32); 
    }	
  }
}

module mount_screws() {
  union() {
    translate([0, carMountScrewSep/2, 0]){
      rotate([0, 90, 0]) cylinder(d=m4ScrewDia, h=length + 1, center=true, $fn=32); // hole for screw
//      translate([length/2 - 3, 0, 0]){
//        rotate([-90, 0, -90]) cylinder(r=mount_screws_dia, h=4, $fn=6); 
//      }
      translate([-length/2 - 0.1, 0, 0]){
        rotate([0, 90, 0]) rotate([0,0,0]) cylinder(d=m4NutDia, h=3.5, $fn=6); // hole for screw's head
      }
    }

    translate([0, -carMountScrewSep/2, 0]){
      rotate([0, 90, 0]) cylinder(d=m4ScrewDia, h=length + 1, center=true, $fn=32);  
//      translate([length/2 - 3, 0, 0]){
//        rotate([-90, 0, -90]) cylinder(r=mount_screws_dia, h=4, $fn=6); 
//      }
      translate([-length/2 - 0.1, 0, 0]){
        rotate([0, 90, 0]) rotate([0,0,0]) cylinder(d=m4NutDia, h=3.5, $fn=6); // hole for screw's head 
      }
    }
  }
}

module separator() {
  translate([-20, 0, 0]){
    cylinder(r=43/2, h=height + 1, center=true, $fn=64); 
  }
}
