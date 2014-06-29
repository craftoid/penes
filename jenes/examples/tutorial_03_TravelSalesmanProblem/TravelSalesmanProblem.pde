
// This class specifies the problem.

class TravelSalesmanProblem {

  TravelSalesmanProblem(double[][] matrix) {

    cities = matrix[0].length;
    map = matrix;

    IntegerChromosome chrom = new IntegerChromosome(cities, 0, cities-1);
    for ( int i = 0; i < cities; ++i ) {
      chrom.setValue(i, i < cities - 1 ? i+1 : 0);
    }
    Individual<IntegerChromosome> sample = new Individual<IntegerChromosome>(chrom);
    Population<IntegerChromosome> pop = new Population<IntegerChromosome>(sample, POPULATION_SIZE);

    algorithm = new TSPGA(matrix, pop, GENERATION_LIMIT);
    algorithm.setRandomization(true);

    AbstractStage<IntegerChromosome> selection = new TournamentSelector<IntegerChromosome>(1);
    AbstractStage<IntegerChromosome> crossover = new TSPCityCenteredCrossover(0.8);
    AbstractStage<IntegerChromosome> mutation = new TSPScrambleMutator(0.02);

    algorithm.addStage(selection);
    algorithm.addStage(crossover);
    algorithm.addStage(mutation);

    algorithm.setElitism(10);
  }

  void solve() {
    algorithm.evolve();

    Population.Statistics stats = algorithm.getCurrentPopulation().getStatistics();
    GeneticAlgorithm.Statistics algostats = algorithm.getStatistics();

    Population.Statistics.Group legals = stats.getGroup(Population.LEGALS);

    System.out.println(legals.get(0));
    System.out.format("found in %d ms and %d generations.\n", algostats.getExecutionTime(), algostats.getGenerations() );
    System.out.println();

    Utils.printStatistics(stats);
  }

  void solvePC() {

    Individual<PermutationChromosome> sample = new Individual<PermutationChromosome>(new PermutationChromosome(cities));
    Population<PermutationChromosome> pop = new Population<PermutationChromosome>(sample, POPULATION_SIZE);

    Fitness<PermutationChromosome> fitness = new Fitness<PermutationChromosome>(false) {

      @Override
        public void evaluate(Individual<PermutationChromosome> individual) {
        PermutationChromosome chrom = individual.getChromosome();
        double count = 0;
        int size = chrom.length();
        for (int i=0;i<size-1;i++) {
          int val1 = chrom.getElementAt(i);
          int val2 = chrom.getElementAt(i+1);
          count += map[val1][val2];
        }
        count += map[size-1][0];
        individual.setScore(count);
      }
    };

    SimpleGA<PermutationChromosome> sga = new SimpleGA<PermutationChromosome>(fitness, pop, GENERATION_LIMIT);

    sga.setElitism(10);
    sga.setMutationProbability(0.02);
    sga.evolve();

    Population.Statistics stats = sga.getCurrentPopulation().getStatistics();
    GeneticAlgorithm.Statistics algostats = sga.getStatistics();

    Population.Statistics.Group legals = stats.getGroup(Population.LEGALS);

    System.out.println(legals.get(0));
    System.out.format("found in %d ms and %d generations.\n", algostats.getExecutionTime(), algostats.getGenerations() );
    System.out.println();
  }
}

