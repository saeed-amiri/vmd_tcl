# Loading data and doing some analysis on it
set filename "/scratch/saeed/GÖHBP/PRE_DFG_4Mar2024/single_np/vmd_test/15Oda/npt.gro"
puts "Attempting to load file: $filename"

# Load the molecule
set mol [mol load gro $filename]

# Wait for molecule to fully load
molinfo $mol wait

# Select residues named APT or COR
set sel [atomselect $mol "resname APT or resname COR"]

# Get list of unique residue IDs for APT and COR
set resids [$sel get residue]
set uniqueResids [lsort -unique $resids]

# Iterate over each unique residue ID and calculate the COM with uniform mass
foreach resid $uniqueResids {
    # Select all atoms in the current residue
    set resSel [atomselect $mol "resid $resid and (resname APT or resname COR)"]
    
    # Ensure the selection is not empty
    if {[$resSel num] > 0} {
        # Proceed with the calculation assuming mass = 1
        # Your calculation logic here...
    } else {
        puts "No atoms found for residue ID $resid with names APT or COR."
    }
    
    # Cleanup
    $resSel delete
}

# Iterate over each unique residue ID and calculate the COM assuming mass = 1 for all atoms
foreach resid $uniqueResids {
    # Select all atoms in the current residue
    set resSel [atomselect $mol "resid $resid and (resname APT or resname COR)"]
    
    # Get coordinates of all atoms in the selection
    set coords [$resSel get {x y z}]
    
    # Initialize variables to compute the average
    set totalX 0
    set totalY 0
    set totalZ 0
    set count 0
    
    # Iterate over each coordinate to sum them
    foreach coord $coords {
        set totalX [expr {$totalX + [lindex $coord 0]}]
        set totalY [expr {$totalY + [lindex $coord 1]}]
        set totalZ [expr {$totalZ + [lindex $coord 2]}]
        incr count
    }
    
    # Calculate the average for each coordinate
    set centerX [expr {$totalX / double($count)}]
    set centerY [expr {$totalY / double($count)}]
    set centerZ [expr {$totalZ / double($count)}]
    
    # Get the residue name for output (assuming all atoms in a residue have the same name)
    set resname [$resSel get resname]
    set resname [lindex $resname 0]
    
    puts "Center of mass for residue $resname $resid: ($centerX, $centerY, $centerZ)"
    
    # Clean up the selection
    $resSel delete
}

# Cleanup the main selection
$sel delete

# Exit VMD
exit