
// This class implements a specific crossover aimed at preserving permutations.
// 
// Algorithm description:
//
//   parent1  5 2 1 4 6 3     parent2   1 3 2 4 6 5
//   child1   _ _ _ _ _ _     child2    _ _ _ _ _ _
//
// Step 1: a city is choosed randomly. We copy all the cities until the selected one from each parent to
// each child (parent1 in child1 and parent2 in child2)
//
//   parent1  5 2 1 4 6 3     parent2   1 3 2 4 6 5
//   child1   5 2 _ _ _ _     child2    1 3 2 _ _ _
//
// Step 2: we fill child1 getting missing elements from parent2; these ones will have the same parent2 order
//
//   parent1  5 2 1 4 6 3     parent2  1 3 2 4 6 5
//   child1   5 2 1 3 4 6     child2   1 3 2 5 4 6
//
//  We repeat these steps for child2


class TSPCityCenteredCrossover extends Crossover<IntegerChromosome>{
    
    TSPCityCenteredCrossover(double pCross) {
        super(pCross);
    }
    
    // Returns the number of chromosomes (i.e. 2) this operator entails.
    int spread() {
        return 2;
    }
    
    IntegerChromosome chrom_parent1 = null;
    IntegerChromosome chrom_parent2 = null;
    
    // This method implements the crossover operation.
    void cross(Individual<IntegerChromosome> offsprings[]) {
        
        IntegerChromosome chrom_child1 = offsprings[0].getChromosome();
        IntegerChromosome chrom_child2 = offsprings[1].getChromosome();
        
        if( chrom_parent1 == null ) {
            chrom_parent1 = chrom_child1.clone();
            chrom_parent2 = chrom_child2.clone();
        } else {
            chrom_parent1.setAs(chrom_child1);
            chrom_parent2.setAs(chrom_child2);
        }
        
        final int size = chrom_child1.length();
        if( chrom_child2.length() != size )
            throw new AlgorithmException("Error: the two chromosomes are required to have the same length.");
        
        
        //we choose a random city
        int city = Random.getInstance().nextInt(0, size);
        
        //i1, i2 are the positions of the city respectively in child1 and child2
        int i1 = findPositionOf(city, chrom_child1);
        int i2 = findPositionOf(city, chrom_child2);
        
        int j1 = 0;
        int j2 = 0;
        for( int i = 0; i < size; ++i ) {
            // get the city c1 in position i for parent1
            int c1 = chrom_parent1.getValue(i);
            // find the position of c1 in parent 2
            int p2 = findPositionOf(c1, chrom_parent2);
            // if the position is over the cross-point, it copies c1 in child2
            if( p2 > i2 ) {
                chrom_child2.setValue(i2 + (++j2), c1);
            }
            
            // similarly we process the other pair
            int c2 = chrom_parent2.getValue(i);
            int p1 = findPositionOf(c2, chrom_parent1);
            if( p1 > i1 ) {
                chrom_child1.setValue(i1 + (++j1), c2);
            }
        }
    }
    
    // Finds the position of one specific city in the chromosome.
    int findPositionOf(int city, IntegerChromosome chrom){
        final int size = chrom.length();
        for( int i = 0; i < size; ++i ) {
            if( chrom.getValue(i) == city )
                return i;
        }
        return -1;
    }
    
}
