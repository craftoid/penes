
// This class implements the algorithm.
 
public class TSPGA extends GeneticAlgorithm<IntegerChromosome> {
    
    double[][] matrix;
    TSPFitness fitness;
    
    TSPGA(double[][] matrix, Population<IntegerChromosome> pop, int genlimit) {
        super(null, pop, genlimit);
        this.matrix = matrix;
        fitness = new TSPFitness();
        this.setFitness(fitness);
    }
    
    void randomizeIndividual(Individual<IntegerChromosome> individual) {
        Random rand = Random.getInstance();
        int len = individual.getChromosomeLength();
        for( int i = 0; i < 100; ++i ) {
            int j = rand.nextInt(len);
            int k = rand.nextInt(len);
            individual.getChromosome().swap(j, k);
        }
    }

    class TSPFitness extends Fitness<IntegerChromosome> {

        TSPFitness() {
            super(false);
        }

        void evaluate(Individual<IntegerChromosome> individual) {
            IntegerChromosome chrom = individual.getChromosome();
            double count = 0;
            int size = chrom.length();
            for (int i = 0; i < size - 1; i++) {
                int val1 = chrom.getValue(i);
                int val2 = chrom.getValue(i + 1);
                count += matrix[val1][val2];
            }
            count += matrix[size - 1][0];

            individual.setScore(count);
        }
    }
    
    
}
