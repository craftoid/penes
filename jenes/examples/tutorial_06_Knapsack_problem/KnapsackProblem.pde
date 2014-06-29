
// This class defines the problem to solve.

class KnapsackProblem {

  KnapsackGA algorithm;
  double[] utilities;
  double[] weights;

  KnapsackProblem(double[] utilities, double[] weights) {
    algorithm = new KnapsackGA(POPSIZE, GENERATION_LIMIT, utilities, weights);
    this.weights = weights;
    this.utilities = utilities;
  }

  void run() {
    this.algorithm.evolve();
    Population.Statistics stat = algorithm.getCurrentPopulation().getStatistics();
    Population.Statistics.Group legals = stat.getGroup(Population.LEGALS);
    Individual solution= legals.get(0);
    System.out.println(solution.getChromosome());
    System.out.format("W: %f U: %f\n", algorithm.getWeightOf(solution), algorithm.getUtilityOf(solution) );
  }

  double getCapacity() {
    return this.algorithm.getCapacity();
  }

  void setCapacity(double c) {
    this.algorithm.setCapacity(c);
  }

  double[] getUtilities() {
    return utilities;
  }

  double[] getWeights() {
    return weights;
  }

  String toString(double[] values) {
    String s = "[";
    for (int i = 0; i < values.length; ++i ) {
      s += values[i]+ (i < values.length-1 ? " " : "]");
    }
    return s;
  }
  
}


// builder for Knapsack Problems with n utilities and weights

KnapsackProblem buildKnapsackProblem(int n) {

  Random r = Random.getInstance();

  double[] utilities = new double[n];
  for ( int i = 0; i < n; ++i ) {
    utilities[i] = r.nextInt(10);
  }

  double[] weights = new double[n];
  for ( int i = 0; i < n; ++i ) {
    weights[i] = r.nextInt(10);
  }

  return new KnapsackProblem(utilities, weights);
  
}





