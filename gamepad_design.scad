offset_from_center=[0,0,0];

module buttonHole(offset, button_D, border_width) {
	translate(offset) cylinder(h = 200, d = button_D+1, center = true, $fn=200);
}

module button(switch_H, offset, button_D, border_width) {
	translate(offset + [0,0,switch_H/2]) cylinder(h = switch_H-1, d = (button_D+2*border_width), center = true, $fn=200);
}

module modifiedPiboy(cross_offset, buttons_offset, plate_XY) {
	eraser_width = 100;
	button_eraser = plate_XY + [0,0,eraser_width];
	top_width = 2;
	
	union() {
		difference() {
			import("./STL-files/piboy-top.stl", 10);
			translate(cross_offset) cylinder(h=100, d=35, center=true, $fn=200);
			translate(buttons_offset) cube(button_eraser, center=true);
		}
	}
}

module modifiedBezel(offset) {
	translate(offset) {
		difference() {
			translate([0,0,11.1]) rotate([180,0,0]) import("./STL-files/Complete_D-Pad/bezel.stl", 10);
			difference() {
				cylinder(h=40,d=48,center=true, $fn=200);
				cylinder(h=40,d=36,center=true, $fn=200);
			}
		}
	}
}

module newButtonHoles(plate_offset, plate_XY, buttons_offset) {
	top_width = 2;
	big_buttons = [
					[-9.05,30.5,0], //C
					[-15.05,17.5,0], //B
					[-16.05,4.5,0] //A
				    ];
	smaller_buttons = [
							[4, 30.45,0], //Z
							[-2, 17.5,0], //Y
							[-3, 4.5,0], //X
                     ];
	big_button_D = 10;
	smaller_button_D = 8;
	switch_H = 7;
	border_width = 2;

	difference() {
		union() {
			translate(plate_offset + [0,0,top_width/2]) cube(plate_XY + [0,0,top_width], center=true);
			for(i = [0:1:2]) {
				button(switch_H, big_buttons[i]+buttons_offset, big_button_D, border_width);
				button(switch_H, smaller_buttons[i]+buttons_offset, smaller_button_D, border_width);
			}
		}
		for(i = [0:1:2]) {
			buttonHole(big_buttons[i]+buttons_offset, big_button_D, border_width);
			buttonHole(smaller_buttons[i]+buttons_offset, smaller_button_D, border_width);
		}
	}
}

cross_offset=[-15,-23.5,0];
buttons_plate_offset=[-17,20,0];
buttons_plate_size_XY = [35,44,0];
buttons_offset = [-7,0,0];

translate(offset_from_center) {
	union() {
		modifiedPiboy(cross_offset,buttons_plate_offset,buttons_plate_size_XY);
		modifiedBezel(cross_offset);
		newButtonHoles(buttons_plate_offset,buttons_plate_size_XY, buttons_offset);
	}
}

