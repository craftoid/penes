
// Tutorial showing how to implement problem specific operators.
// The problem faced in this example is the well known Tavel Salesman Problem (TSP)

// See >>> http://jenes.intelligentia.it/tutorials/tutorial5

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

int POPULATION_SIZE = 1000;
int GENERATION_LIMIT = 2000;
int MAX_DISTANCE = 10;

TSPGA algorithm;
int cities;
double[][] map;

void setup() {

  Utils.printHeader();
  println();

  println("TUTORIAL 3:");
  println("The Travel Salesman Problem, a classics.");
  println();

  Random.getInstance().setStandardSeed();

  println("Case 1: 10 cities in circle");
  double[][] m1 = simpleMap(10);
  TravelSalesmanProblem tsp1 = new TravelSalesmanProblem(m1);
  tsp1.solve();

  println("Case 2: 30 cities in circle");
  double[][] m2 = simpleMap(30);
  TravelSalesmanProblem tsp2 = new TravelSalesmanProblem(m2);
  tsp2.solve();

  println("Case 3: 30 cities at random");
  double[][] m3 = randomMap(30);
  TravelSalesmanProblem tsp3 = new TravelSalesmanProblem(m3);
  tsp3.solve();

  println("Case 4: An application of PermutationChromosome");
  tsp2.solvePC();
  
  exit();
  
}


double[][] simpleMap( int cities ) {
  double[][] matrix = new double[cities][cities];

  matrix[0][0] = 0;
  for ( int i = 1; i <= cities/2; ++i) {
    matrix[0][i] = i;
    matrix[0][cities-i] = i;
  }

  for ( int i = 1; i < cities; ++i ) {
    for ( int j = 0; j < cities; ++j ) {
      matrix[i][(i+j)%cities] = matrix[0][j];
    }
  }
  return matrix;
}

double[][] randomMap( int cities ) {
  double[][] matrix = new double[cities][cities];
  for ( int i = 0; i < cities; ++i ) {
    for ( int j = 0; j < cities; ++j ) {
      matrix[i][j] = i!=j ? Random.getInstance().nextDouble(MAX_DISTANCE) : 0;
    }
  }
  return matrix;
}

