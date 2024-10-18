# Load the gro and trr and with optinal number of frames
set mol [mol new "/scratch/saeed/GÖHBP/PRE_DFG_4Mar2024/single_np/vmd_test/50Oda/center_mol_unwrap.gro" type gro waitfor all]
puts "Attempting to load file: $mol"
set distance 5

mol addfile "/scratch/saeed/GÖHBP/PRE_DFG_4Mar2024/single_np/vmd_test/50Oda/center_mol_unwrap.trr" type trr first 0 last 1 step 1 waitfor all molid $mol

set nf [molinfo top get numframes]
puts " The numbers of frames are $nf"
for {set i 0} {$i < $nf} {incr i} {
    animate goto $i
    set inRadiusResidues [atomselect top "resname APT COR"]
    set resIDs [$inRadiusResidues get residue]
    if {[llength $resIDs] > 0} {
        set uniqueResIDs [lsort -unique $resIDs]
        set completeInRadiusResidues [atomselect top "residue $uniqueResIDs"]
        $completeInRadiusResidues writepdb "COR_${i}.pdb"
        $completeInRadiusResidues delete
    } else {
        puts "No residues within $distance Å of APT or COR in frame $i"
    }
    $inRadiusResidues delete
}

exit
