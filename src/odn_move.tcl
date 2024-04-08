# Load the pbctools plugin
package require pbctools
set env(VMDOPTIXWRITEALPHA) 1

mol delete all

# Define a procedure to load a molecule
proc load_molecule {grofile trrfile} {
    # Delete all molecules
    mol delete all
    # Load the molecule
    set mol [mol load gro $grofile]
    mol addfile $trrfile type trr first 0 last 10 step 1 waitfor all
}

# Define a procedure to delete all representations
proc delete_all_reps {} {
    # Get the number of representations
    set numreps [molinfo top get numreps]

    # Delete all representations
    for {set i 0} {$i < $numreps} {incr i} {
        mol delrep 0 top
    }
}

# reset the view and display
proc reset_view_and_display {} {
    display resetview
    display projection Orthographic
    axes location Off
    display depthcue on

    light 1 on
    light 2 on
    light 3 off
    light 4 off
}

# Define a procedure with parameters
proc visualize_residues {repIndex selection radius} {
    # Add a new representation with the specified selection
    mol addrep top
    mol modselect $repIndex top $selection
    mol modstyle $repIndex top "CPK $radius 0.0 30.0 12.0"
    mol modmaterial $repIndex top Glassy
}
proc render_image {filename} {
    display resize 4800 4800
    render TachyonLOptiXInternal $filename

}
# Load the trajectory
set grofile npt.gro
set trrfile npt.trr

load_molecule $grofile $trrfile
delete_all_reps

# Visualize the residues
visualize_residues 0 "resname ODN" 2.0 

# Get the number of frames
set numframes [molinfo top get numframes]

# Loop over each frame
for {set i 0} {$i < $numframes} {incr i} {
    # Draw the current frame
    mol drawframes top 0 $i

    reset_view_and_display
    rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
    translate by 0 -0.3 0

    # Save the frame as an image
    set filename [format "frame_%04d.png" $i]
    render TachyonLOptiXInternal $filename
}

exit
