
// A tutorial showing how to log statistics on different media

// See >>> http://jenes.intelligentia.it/tutorials/tutorial7

import jenes.*;
import jenes.algorithms.*;
import jenes.chromosome.*;
import jenes.population.*;
import jenes.stage.*;
import jenes.stage.operator.*;
import jenes.stage.operator.common.*;
import jenes.statistics.*;
import jenes.tutorials.utils.*;
import jenes.utils.*;

int POPSIZE = 20;
int GENERATION_LIMIT = 100;
  
double[] WEIGHTS = { 1, 5, 3, 2, 8, 6, 4, 7, 9, 6 };
double[] UTILITIES = { 7, 2, 7, 1, 6, 4, 2, 8, 9, 2 };
  
void setup() {

    Utils.printHeader();
    println();

    println("TUTORIAL 7:");
    println("Logging the Knapsack Problem.");
    println();

    try {
    final KnapsackLoggedProblem prb = buildKnapsackLoggedProblem(20);

    println("Utilities: " + str(prb.getUtilities()));
    println("  Weights: " + str(prb.getWeights()));
    println();

    GenerationEventListener<BooleanChromosome> logger1 = new GenerationEventListener<BooleanChromosome>() {

      public void onGeneration(GeneticAlgorithm ga, long time) {
        
        Population.Statistics stats = ga.getCurrentPopulation().getStatistics();

        prb.csvlogger.record(stats);
        prb.xlslogge1.record(stats);
        prb.xlslogge2.record(stats);
        
      }
    };

    prb.algorithm.addGenerationEventListener(logger1);


    println("50 random elements, capacity 50");
    prb.setCapacity(50);
    prb.run();
    println();

    println("Saving the logs ...");
    prb.csvlogger.close();
    prb.xlslogge1.close();
    prb.xlslogge2.close();
    println("Done.");

    prb.algorithm.removeGenerationEventListener(logger1);

    GenerationEventListener<BooleanChromosome> logger2 = new GenerationEventListener<BooleanChromosome>() {

      public void onGeneration(GeneticAlgorithm ga, long time) {
        Population.Statistics stats = ga.getCurrentPopulation().getStatistics();

        Population.Statistics.Group legals = stats.getGroup(Population.LEGALS);

        prb.xlslogge3.put("LegalHighestScore", legals.getMax());
        prb.xlslogge3.put("LegalScoreAvg", legals.getMin());
        prb.xlslogge3.put("LegalScoreDev", prb.exec);
        prb.xlslogge3.put("Legals individuals", legals);

        prb.xlslogge3.log();
      }
    };

    prb.algorithm.addGenerationEventListener(logger2);

    println();
    println("Repeating 10 times: 20 random elements, capacity 50");

    for (prb.exec = 0; prb.exec < 10; ++prb.exec) {
      println((prb.exec + 1) + " of 10");
      prb.run();
    }
    prb.xlslogge3.close();
    println("Done.");
    } catch(Exception e) {
      e.printStackTrace(); 
    }
  
}

String str(double[] values) {
  String s = "[";
  for (int i = 0; i < values.length; ++i) {
    s += values[i] + (i < values.length - 1 ? " " : "]");
  }
  return s;
}

