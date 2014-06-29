
// Tutorial showing how to minimization and maximization sub-prolems can cohesists in
// the breeding structure of Jenes.

// See >>> http://jenes.intelligentia.it/tutorials/tutorial6

import jenes.*;
import jenes.chromosome.*;
import jenes.population.*;
import jenes.performance.*;
import jenes.stage.*;
import jenes.stage.operator.common.*;
import jenes.utils.*;
import jenes.tutorials.utils.*;

int POPSIZE = 100;
int GENERATION_LIMIT = 100;

double[] WEIGHTS = {1, 5, 3, 2, 8, 6, 4, 7, 9, 6};
double[] UTILITIES = {7, 2, 7, 1, 6, 4, 2, 8, 9, 2};

void setup() {
  
  Utils.printHeader();
  println();

  println("TUTORIAL 6:");
  println("The Knapsack Problem.");
  println();

  KnapsackProblem p1 = new KnapsackProblem(UTILITIES, WEIGHTS);

  println("Case 1: 10 elements, capacity 15");
  println("Utilities: " + p1.getUtilities());
  println("  Weights: " + p1.getWeights());
  p1.setCapacity(15);
  p1.run();
  println();

  println("Case 2: 10 elements, capacity 30");
  println("Utilities: " + p1.getUtilities() );
  println("  Weights: " + p1.getWeights() );
  p1.setCapacity(30);
  p1.run();
  println();

  KnapsackProblem p2 = buildKnapsackProblem(20);

  println("Case 3: 20 random elements, capacity 50");
  println("Utilities: " + p2.getUtilities());
  println("  Weights: " + p2.getWeights());
  p2.setCapacity(50);
  p2.run();
  println();
  
}


