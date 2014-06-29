
// Tutorial illustrating the use of object-oriented chromosomes, whose
// allele set can be defined by the user for each gene.

// In this example the chromosomes are combinations of colors. We aim at finding
// the vector of colors closest to a given sequence.

// See >>> http://jenes.intelligentia.it/tutorials/tutorial5

import jenes.*;
import jenes.chromosome.*;
import jenes.population.*;
import jenes.performance.*;
import jenes.stage.*;
import jenes.stage.operator.common.*;
import jenes.utils.*;
import jenes.tutorials.utils.*;

import java.util.HashSet;
import java.util.Set;

int POPULATION_SIZE = 100;
int GENERATION_LIMIT = 100;

ObjectChromosome template = new ObjectChromosome( 
  IntegerAlleleSet.createUniform(10, 0, 9), 
  IntegerAlleleSet.createUniform(21, 10, 30), 
  DoubleAlleleSet.createRandom(10, 0, 1), 
  new GenericAlleleSet<Boolean>(true, false), 
  new GenericAlleleSet<Color>(Color.values()) 
);




Fitness<ObjectChromosome> fitness = new Fitness<ObjectChromosome>(true) {

  public void evaluate(Individual<ObjectChromosome> individual) {
    ObjectChromosome template = individual.getChromosome();

    int i1 = (Integer)template.getValue(0);
    int i2 = (Integer)template.getValue(1);
    double d = (Double)template.getValue(2);
    boolean b = (Boolean)template.getValue(3);

    Color c = (Color)template.getValue(4);

    double acc = b ? (3*i1 + 4*i2 + d) : i1;

    switch( c ) {
      case BLACK : acc += 10; break;
      case RED   : acc += 10; break;
      case WHITE : acc += 10; break;
    }

    individual.setScore(acc);
  }
};


GeneticAlgorithm<ObjectChromosome> ga = new GeneticAlgorithm<ObjectChromosome>( fitness, new Population<ObjectChromosome>(new Individual<ObjectChromosome>(template), POPULATION_SIZE), GENERATION_LIMIT);

void setup() {

  Utils.printHeader();
  println();

  println("TUTORIAL 5:");
  println("Find the sequence of colors nearest to the target.");
  println();

  Random.getInstance().setStandardSeed();

  ga.addStage(new TournamentSelector<ObjectChromosome>(3));
  ga.addStage(new OnePointCrossover<ObjectChromosome>(0.8));
  ga.addStage(new SimpleMutator<ObjectChromosome>(0.02));

  ga.evolve();

  Population.Statistics stats = ga.getCurrentPopulation().getStatistics();
  GeneticAlgorithm.Statistics algostats = ga.getStatistics();

  Population.Statistics.Group legals = stats.getGroup(Population.LEGALS);

  println("Solution: ");
  println(legals.get(0));
  System.out.format("found in %d ms.\n", algostats.getExecutionTime() );
  println();

  Utils.printStatistics(stats);

  exit();
  
}


