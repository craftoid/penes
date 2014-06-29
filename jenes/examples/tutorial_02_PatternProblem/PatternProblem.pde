
/**
 *
 * This is the main class that specifies the problem.
 *
 */
 
class PatternProblem implements GenerationEventListener<IntegerChromosome> {
    
    
    PatternProblem() {
        
        IntegerChromosome chrom = new IntegerChromosome(CHROMOSOME_LENGTH,0,MAX_INT);
        Individual<IntegerChromosome> ind = new Individual<IntegerChromosome>(chrom);
        Population<IntegerChromosome> pop = new Population<IntegerChromosome>(ind, POPULATION_SIZE);
        
        algorithm = new PatternGA(pop, GENERATION_LIMIT);
        algorithm.setElitism(5);
        
        AbstractStage<IntegerChromosome> selection = new TournamentSelector<IntegerChromosome>(2);
        
        Parallel<IntegerChromosome> parallel = new Parallel<IntegerChromosome>(new SimpleDispenser<IntegerChromosome>(2));
        
        AbstractStage<IntegerChromosome> crossover1p = new OnePointCrossover<IntegerChromosome>(0.8);
        parallel.add(crossover1p);
        
        AbstractStage<IntegerChromosome> crossover2p = new TwoPointsCrossover<IntegerChromosome>(0.5);
        parallel.add(crossover2p);
        
        AbstractStage<IntegerChromosome> mutation = new SimpleMutator<IntegerChromosome>(0.02);
        
        algorithm.addStage(selection);
        algorithm.addStage(parallel);
        algorithm.addStage(mutation);
        algorithm.addGenerationEventListener(this);
    }
    
    void run(int[] target, int precision) {
        ((PatternGA.PatternFitness) algorithm.getFitness()).setTarget(target);
        ((PatternGA.PatternFitness) algorithm.getFitness()).setPrecision(precision);
        algorithm.evolve();
        
        Population.Statistics stats = algorithm.getCurrentPopulation().getStatistics();
        GeneticAlgorithm.Statistics algostats = algorithm.getStatistics();
        
        println();
        print("Target:[");
        for( int i = 0; i < target.length; ++i ) {
            print(target[i]+ ( i < target.length - 1 ? " " : ""));
        }
        println("]");
        println();
        
        println("Solution: ");
        println(stats.getGroup(Population.LEGALS).get(0));
        System.out.format("found in %d ms and %d generations.\n", algostats.getExecutionTime(), algostats.getGenerations() );
        println();
        
        Utils.printStatistics(stats);
    }
    
    
    void onGeneration(GeneticAlgorithm ga, long time) {
        Population.Statistics stat = ga.getCurrentPopulation().getStatistics();
        Population.Statistics.Group legals =  stat.getGroup(Population.LEGALS);
        println("Current generation: " + ga.getGeneration());
        println("\tBest score: " + legals.getMin()[0]);
        println("\tAvg score : " + legals.getMean()[0]);
    }

}
