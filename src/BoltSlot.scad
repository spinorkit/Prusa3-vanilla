
boltSlot();

module boltSlot(angle = 45,dia = 3.8, height= 8,len = 7)
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