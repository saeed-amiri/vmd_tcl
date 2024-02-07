# Reading the input file and trying to load and anlysing the data without running
# the vmd interface

# Check if at least one argument is provided
if {$argc < 1} {
    puts "Usage: vmd -dispdev text -e script.tcl <filename>"
    exit
}

# Get the filename from the command line arguments
# set filename [lindex $argv 0]
set filename "/scratch/saeed/GÖHBP/PRE_DFG_4Mar2024/single_np/vmd_test/15Oda/npt.gro"

# Debug: Print the filename to load
puts "Attempting to load file: $filename"

# Assuming you're loading a GROMACS file
set mol [mol load gro $filename]

# Verify molecule was loaded
if {![info exists mol]} {
    puts "Failed to load molecule from $filename"
    exit
}

# If we get here, the molecule was loaded successfully
puts "Molecule loaded successfully: $mol"

# Now let's get and print the unique residue names
set sel [atomselect $mol "all"]
set residues [$sel get resname]
set uniqueResidues [lsort -unique $residues]

puts "Unique residue names in the molecule:"
foreach resname $uniqueResidues {
    puts $resname
}

# Cleanup
$sel delete
exit