
/**
 *
 * This class implements the algorithm by extending <code>GeneticAlgorithm</code>.
 *
 */

class PatternGA extends GeneticAlgorithm<IntegerChromosome> {

  PatternFitness fitness = new PatternFitness();

  PatternGA(Population<IntegerChromosome> pop, int numGen) {
    super(pop, numGen);
    this.setFitness(fitness);
  }

  boolean end() {
    jenes.population.Population.Statistics stat = this.getCurrentPopulation().getStatistics();
    return stat.getGroup(Population.LEGALS).getMin()[0] <= this.fitness.precision;
  }

  class PatternFitness extends Fitness<IntegerChromosome> {

    int[] target = null;
    int precision = 0;

    PatternFitness() {
      super(false);
    }


    void evaluate(Individual<IntegerChromosome> individual) {
      IntegerChromosome chrom = individual.getChromosome();
      int diff = 0;
      int length = chrom.length();
      for (int i = 0; i < length; i++) {
        diff += Math.abs(chrom.getValue(i) - target[i]);
      }
      individual.setScore(diff);
    }

    void setTarget(int[] target) {
      this.target = target;
    }

    void setPrecision(int precision) {
      this.precision = precision;
    }
  }
}

