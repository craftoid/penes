
class KnapsackLoggedProblem {

  KnapsackGA algorithm;
  double[] utilities;
  double[] weights;
  StatisticsLogger csvlogger;
  StatisticsLogger xlslogge1;
  StatisticsLogger xlslogge2;
  XLSLogger xlslogge3;
  int exec;

  String FOLDER = "output" + File.separatorChar;


  KnapsackLoggedProblem(double[] utilities, double[] weights) throws IOException {
    
    algorithm = new KnapsackGA(POPSIZE, GENERATION_LIMIT, utilities, weights);
    this.weights = weights;
    this.utilities = utilities;

    csvlogger = new StatisticsLogger(
      new CSVLogger(new String[]{"LegalHighestScore", "LegalScoreAvg", "LegalScoreDev"}, sketchPath(FOLDER + "knapsackproblem.csv"))
    );

    xlslogge1 = new StatisticsLogger(
      new XLSLogger(new String[]{"LegalHighestScore", "LegalScoreAvg", "LegalScoreDev"}, sketchPath(FOLDER + "knapsack1.log.xls"))
    );

    xlslogge2 = new StatisticsLogger(
      new XLSLogger(new String[]{"LegalHighestScore", "LegalScoreAvg", "IllegalScoreAvg"}, sketchPath(FOLDER + "knapsack2.log.xls"), dataPath("knapsack.tpl.xls"))
    );

    xlslogge3 = new XLSLogger(new String[]{"LegalHighestScore", "LegalScoreAvg", "LegalScoreDev", "Legals individuals"}, sketchPath(FOLDER + "knapsack3.log.xls"));
        
  }

  void run() {
    this.algorithm.evolve();

    Population.Statistics stat = algorithm.getCurrentPopulation().getStatistics();
    Population.Statistics.Group allLegals = stat.getGroup(Population.LEGALS);
    Individual solution = allLegals.get(0);
    println(solution.getChromosome());
    System.out.format("W: %f U: %f\n", algorithm.getWeightOf(solution), algorithm.getUtilityOf(solution));
    
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


}

KnapsackLoggedProblem buildKnapsackLoggedProblem(int n) throws IOException {

  Random r = Random.getInstance();

  double[] utilities = new double[n];
  for (int i = 0; i < n; ++i) {
    utilities[i] = r.nextInt(10);
  }

  double[] weights = new double[n];
  for (int i = 0; i < n; ++i) {
    weights[i] = r.nextInt(10);
  }

  return new KnapsackLoggedProblem(utilities, weights);
  
}

