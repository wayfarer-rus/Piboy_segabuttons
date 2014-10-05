module dpad()
{
	//cube([60,60,1]);
	translate([-25,-25,0]) union() {
	translate([43,0,4]) {
		rotate ([180,0,0]) import("./STL-files/Complete_D-Pad/wheel.stl", 10);
	}

	translate([0,0,6.95]) {
		rotate([180,0,0]) import("./STL-files/Complete_D-Pad/securingring.stl", 10);
	}

	translate([0,45,4.1]) {
		import("./STL-files/Complete_D-Pad/rest.stl", 10);
	}

	translate([0,0,-4]) {
		import("./STL-files/Complete_D-Pad/buttons.stl", 10);
	}

	translate([50,45,-3.5]) {
		import("./STL-files/Complete_D-Pad/unioncross.stl", 10);
	}

	translate([50,45,11.1]) {
		rotate([180,0,0]) import("./STL-files/Complete_D-Pad/bezel.stl", 10);
	}
	}
}

dpad();

