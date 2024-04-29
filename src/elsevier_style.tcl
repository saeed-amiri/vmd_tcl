namespace eval sizes {
    variable dpi 300
    variable width_in_points 255
    # Convert points to inches (1 point = 1/72 inches)
    variable width_in_inches [expr {$width_in_points / 72.0}]
    # Convert inches to pixels
    variable width_in_pixels [expr {int($width_in_inches * $dpi)}]
    # Use the same value for height if you want a square window
    variable height_in_pixels $width_in_pixels
    puts "width_in_pixels: $width_in_pixels, height_in_pixels: $height_in_pixels"
}