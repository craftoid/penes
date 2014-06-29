
// Tutorial showing how to set-up a minimization problem.
// The problem is to find a vector whose entroy, after normalization, is minimal.

// See >>> http://jenes.intelligentia.it/tutorials/tutorial4

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


int POPULATION_SIZE   = 100;
int CHROMOSOME_LENGTH = 5;
int GENERATION_LIMIT  = 100;

GeneticAlgorithm<DoubleChromosome> ga;

EntropyFitness MAX = new EntropyFitness(true);
EntropyFitness MIN = new EntropyFitness(false);


void setup() {

  Utils.printHeader();
  println();

  println("TUTORIAL 4:");
  println("Find the probability distribution that maximizes (or minimize) the Shannon's entropy.");
  println();

  Individual<DoubleChromosome> sample = new Individual<DoubleChromosome>(new DoubleChromosome(CHROMOSOME_LENGTH, 0, 1));
  Population<DoubleChromosome> pop = new Population<DoubleChromosome>(sample, POPULATION_SIZE);

  ga = new SimpleGA<DoubleChromosome>(null, pop, GENERATION_LIMIT);

  println("Solving Max!:");
  solve(  MAX );

  println("Solving Min!:");
  solve( MIN );
  
  exit();
  
}


void solve(EntropyFitness fitness) {

  ga.setFitness(fitness);
  ga.evolve();

  Population.Statistics stats = ga.getCurrentPopulation().getStatistics();
  GeneticAlgorithm.Statistics algostats = ga.getStatistics();

  Population.Statistics.Group legals = stats.getGroup(Population.LEGALS);       

  println(legals.get(0));
  System.out.format("found in %d ms.\n", algostats.getExecutionTime() );
  println();

  Utils.printStatistics(stats);
  
}


class EntropyFitness extends Fitness<DoubleChromosome> {

  public EntropyFitness(boolean maximize) {
    super(maximize);
  }

    public void evaluate(Individual<DoubleChromosome> individual) {
    DoubleChromosome chrom = individual.getChromosome();

    int length = chrom.length();

    double sum = 0.0;
    for (int i = 0; i < length; ++i) {
      sum += chrom.getValue(i);
    }

    double entropy = 0.0;
    
    for (int i = 0; i < length; ++i) {
      double pxi = chrom.getValue(i) / sum;
      chrom.setValue(i, pxi);
      entropy -= (pxi * Math.log(pxi) / Math.log(2));
    }

    individual.setScore(entropy);
  }
}


