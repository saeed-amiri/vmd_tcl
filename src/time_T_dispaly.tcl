proc enabletrace {} {
  global vmd_frame;
  trace variable vmd_frame([molinfo top]) w drawcounter
}

proc disabletrace {} {
  global vmd_frame;
  trace vdelete vmd_frame([molinfo top]) w drawcounter
}

proc drawcounter { name element op } {
    global vmd_frame;

    draw delete all
    puts "callback!"
    draw color black
    set psperframe 10
    set psoffset 1
    set timeValue [expr {($vmd_frame([molinfo top]) * $psperframe) / 100.0}]
    set time [format "%.1f ns" $timeValue]
    draw text {90 -130 125 } "$time" size 1.5 thickness 5

    # Calculate the temperature as half of the time
    set temperature [format "%.2f K" [expr {$timeValue * 0.5 + 298.15}]]
    # Draw the temperature slightly below the time
    draw text {90 -130 155 } "$temperature" size 1.5 thickness 5
}