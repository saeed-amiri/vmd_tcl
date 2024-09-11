proc delete_all_reps {} {
    set numreps [molinfo top get numreps]
    for {set i 0} {$i < $numreps} {incr i} {
        mol delrep 0 top
    }
}

proc visualize_residues {repIndex selection radius} {
    # Add a new representation with the specified selection
    mol addrep top
    mol modselect $repIndex top $selection
    mol modstyle $repIndex top "CPK $radius 0.0 30.0 12.0"
    mol modmaterial $repIndex top Glassy
}

proc reset_view_and_display {} {
    display resetview
    display projection Orthographic
    axes location Off
    display depthcue on
    color Display Background white

    light 1 on
    light 2 on
    light 3 off
    light 4 off
}

proc render_image {filename} {
    display resize 4800 4800
    render TachyonLOptiXInternal $filename
}

proc load_molecule {structure trajectory first last} {
    mol new $structure
    mol addfile $trajectory type trr first $first last $last waitfor all
}

# Load the trajectory
puts "__________________________"
puts "Structure:"
set structure [lindex $argv 0]
puts "Trajectory:"
set trajectory [lindex $argv 1]

# Define the frames to render
puts "List of the frames:"
set frames [list 0 100 200 300 400 500 600 700 800 900 1000]
puts "__________________________"

# Load the molecule once
load_molecule $structure $trajectory 0 1001
puts "__________________________"

# Add a new representation
mol addrep top
delete_all_reps

# Visualize the residues
visualize_residues 0 "name NH2" 4.0
mol modcolor 0 top "ColorID 3"
visualize_residues 1 "resname COR APT and sqrt((x-108)**2+(y-108)**2+(z-113)**2)<17.5" 2.0
mol modcolor 1 top "ColorID 2"

# Loop through the specified frames and render each one
foreach frame $frames {
    mol drawframes top 0 $frame
    mol drawframes top 1 $frame
    reset_view_and_display

    # Render the image
    set filename [format "overlay_np_%03d.png" $frame]
    render_image $filename
}

exit