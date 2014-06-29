
// This class implements a genetic algorithm for solving the Knapsack problem.

class KnapsackGA extends GeneticAlgorithm<BooleanChromosome>{
    
    class KnapsackFitness extends Fitness<BooleanChromosome> {
                
        KnapsackFitness(boolean maximize) {
            super( maximize );
        }
        
        void evaluate(Individual<BooleanChromosome> individual) {
            double utility = getUtilityOf(individual);
            double weight = getWeightOf(individual);
            individual.setScore(utility);
            individual.setLegal(weight <= KnapsackGA.this.capacity);
        }
        
    }
    
    double capacity;
    double[] weights;
    double[] utilities;
    
    KnapsackFitness maximize = new KnapsackFitness(true);
    KnapsackFitness minimize = new KnapsackFitness(false);

    KnapsackGA( int popsize, int generations, double[] utilities, double[] weights) {
        super( new Population<BooleanChromosome>(new Individual<BooleanChromosome>(new BooleanChromosome(utilities.length)), popsize), generations);
        
        this.utilities = utilities;
        this.weights = weights;
        
        Parallel<BooleanChromosome> parallel = new Parallel<BooleanChromosome>(new ExclusiveDispenser<BooleanChromosome>(2){
            
            int distribute(Individual<BooleanChromosome> ind) {
                return ind.isLegal() ? 0 :1;
            }
            
        });
        
        this.setFitness(this.maximize);
        
        Sequence<BooleanChromosome> seq_legal = new Sequence<BooleanChromosome>();
        seq_legal.appendStage(new TournamentSelector<BooleanChromosome>(2));
        seq_legal.appendStage(new OnePointCrossover<BooleanChromosome>(0.8));
        seq_legal.appendStage(new SimpleMutator<BooleanChromosome>(0.02));
        
        Sequence<BooleanChromosome> seq_illegal = new Sequence<BooleanChromosome>();
        seq_illegal.appendStage(new TournamentSelector<BooleanChromosome>(2));
        seq_illegal.appendStage(new OnePointCrossover<BooleanChromosome>(0.8));
        seq_illegal.appendStage(new SimpleMutator<BooleanChromosome>(0.2));
        
        parallel.add(seq_legal);
        parallel.add(seq_illegal);
        
        this.addStage(parallel);
        
        seq_legal.setFitness(this.maximize);
        seq_illegal.setFitness(this.minimize);
    }
    
    double getCapacity() {
        return this.capacity;
    }
    
    void setCapacity(double capacity) {
        this.capacity = capacity;
    }
    
    double getUtilityOf(Individual<BooleanChromosome> individual) {
        BooleanChromosome chrom = individual.getChromosome();
        double utility = 0.0;
        int size = chrom.length();
        for(int i = 0; i < size; ++i){
            utility += chrom.getValue(i) ? this.utilities[i] : 0.0;
        }
        return utility;
    }
    
    double getWeightOf(Individual<BooleanChromosome> individual) {
        BooleanChromosome chrom = individual.getChromosome();
        double weight=0.0;
        int size = chrom.length();
        for(int i = 0; i < size; ++i){
            weight += chrom.getValue(i) ? this.weights[i] : 0.0;
        }
        return weight;
    }    
    
}

