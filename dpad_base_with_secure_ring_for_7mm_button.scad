module ear(r, h, bottom, angle, offset) {
	translate([0,0,-1]) rotate([0,0,45]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) {
		translate (offset) union() {
			circle(r);
			polygon([[r*sin(angle), r*cos(angle)],[r*sin(angle), -r*cos(angle)],[-h, -bottom/2],[-h, bottom/2]]);
		}
	}
}

module difference_cross(width, length, offset_from_bottom) {
	height = 10;
	offset = [0,0,height/2-offset_from_bottom];
	cube_size = [width, length, height];
	difference() {
		union () {
			translate(offset) cube(size = cube_size, center=true);
			rotate([0,0,90]) translate(offset) cube(cube_size, center=true);
		}
		translate(offset) cylinder(h = height, d = (2*width-2), center = true);
	}
}

module rest7mmbuttons() 
{
	circle_r = 2.1;
	ear_h = 5.0;
	ear_bottom = 10.54;
	ear_angle = 25.0;
	ear_translate = [20,0,0];
translate ([0,0,2]) difference() {
	union() {
		translate([0,0,4.1]) {
			import("./STL-files/Complete_D-Pad/rest.stl", 10);
		}
		translate([0,0,-2]) cylinder(d = 34, h = 2, center = false, $fn=100);
		//ears
		ear(circle_r, ear_h, ear_bottom, ear_angle, ear_translate, $fn=100);
		mirror([1,0,0]) ear(circle_r, ear_h, ear_bottom, ear_angle, ear_translate, $fn=100);
		mirror([0,1,0]) {
			ear(circle_r, ear_h, ear_bottom, ear_angle, ear_translate, $fn=100);
			mirror([1,0,0]) ear(circle_r, ear_h, ear_bottom, ear_angle, ear_translate, $fn=100);
		}
	}
	difference_cross(7, 34, 1, $fn=100);
}
}

union () {
	translate([34,0,0]) rest7mmbuttons();
	translate([-15,0,6.95]) {
		rotate([180,0,0]) import("./STL-files/Complete_D-Pad/securingring.stl", 10);
	}
}
