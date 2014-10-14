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

module longer_pins() {
	pins_top_d = 3;
	pins_top_h = 3;
	pins_cone_d = 4;
	pins_cone_h = 24.2/2-5;
	pins_total_h = pins_cone_h + pins_top_h;
	offset = [14.215,14.215,pins_total_h/2];

	translate(offset) union() {
		translate([0,0,-pins_top_h/2])
		cylinder(h=pins_cone_h, r1=pins_cone_d/2, r2=pins_top_d/2, center=true, $fn=100);
		cylinder(h=pins_total_h, d=pins_top_d, center=true, $fn=100);
	}
}

module rest7mmbuttons_longerpins() {
	union() {
		rest7mmbuttons();
		translate([0,0,5]) {
			mirror([0,1,0]) {
				longer_pins();
				rotate([0,0,90]) longer_pins();
			}
			longer_pins();
			rotate([0,0,90]) longer_pins();
		}
	}
}

module rest7mmbuttons_stronger_walls() {
	border_h = 16.1;
	button_h = 3.5;
	button_holder_size = [6,6,button_h];
	button_holder_perimeter = [10,10,button_h];
	offset_from_bottom = 1;

	difference() {
		difference() {
			union() {
				rest7mmbuttons();
				translate([0,0,border_h/2]) difference() {
					cylinder(r=20,h=border_h, center=true, $fn=100);
					cylinder(r=18.215,h=border_h, center=true, $fn=100);
				}
				for(i=[0:90:270]) {
					rotate([0,0,i])
					translate([13,0,offset_from_bottom+button_h/2]) difference() {
						cube(button_holder_perimeter, center=true);
						cube(button_holder_size, center=true);
					}
				}
			}
	
			for(i=[0:90:270]) {
				rotate([0,0,i])
				translate([21,0,(button_h+1)/2])
				cube(button_holder_size+[4,0,1], center=true);
			}
		}
		translate([19+100/2,0,0]) cube([100,100,100], center=true);
	}
}

rest7mmbuttons_stronger_walls();