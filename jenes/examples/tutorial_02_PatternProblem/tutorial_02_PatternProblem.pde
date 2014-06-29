
// Tutorial showing how to extend <code>GeneticAlgorithm</code> and how to use
// the flexible and configurable breeding structure in Jenes.
// The problem consists in searching a pattern of integers with a given precision.
// Solutions flow through two different crossovers in parallel. Some are processed by
// a single point crossover, the other by a double point crossover.
// After solutions are mutated.

// See >>> http://jenes.intelligentia.it/tutorials/tutorial2
 
 
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

int POPULATION_SIZE = 100;
int CHROMOSOME_LENGTH = 10;
int GENERATION_LIMIT = 1000;
int MAX_INT = 49;
PatternGA algorithm = null;

void setup() {

  Utils.printHeader();

  println();
  println("TUTORIAL 2:");
  println("This algorithm aims to autonomously find a vector of integers that best matches with a target vector.");
  println();

  Random.getInstance().setStandardSeed();

  PatternProblem problem = new PatternProblem();
  int[] target = new int[CHROMOSOME_LENGTH];

  randomize(target);
  problem.run(target, 2);

  randomize(target);
  problem.run(target, 0);
  
  exit();
  
}


void randomize(int[] sample) {
  for (int i=0; i<sample.length; i++) {
    sample[i] = Random.getInstance().nextInt(0, MAX_INT+1);
  }
}

