
/**
 * Tutorial implementing a basic genetic algorithm.
 * The problem consists in finding a vector full of zeros or ones.
 * 
 * @author Luigi Troiano
 * @version 2.0
 * @since 1.0
 */

import jenes.*;
import jenes.population.*;
import jenes.stage.*;
import jenes.performance.*;
import jenes.statistics.*;
import jenes.utils.*;
import jenes.chromosome.codings.*;
import jenes.stage.operator.*;
import jenes.stage.operator.common.*;
import jenes.chromosome.*;
import jenes.utils.multitasking.*;
import jenes.algorithms.*;


int POPULATION_SIZE=50;
int CHROMOSOME_LENGTH=100;
int GENERATION_LIMIT=1000;


void setup() {

  Utils.printHeader();

  println("TUTORIAL 1:");
  println("This algorithm aims to find a vector of booleans that is entirely true or false.");

  // Random.getInstance().setStandardSeed();

  Individual<BooleanChromosome> sample = new Individual<BooleanChromosome>(new BooleanChromosome(CHROMOSOME_LENGTH));
  Population<BooleanChromosome> pop = new Population<BooleanChromosome>(sample, POPULATION_SIZE);

  // dynamically create a fitness class
  Fitness<BooleanChromosome> fit = new Fitness<BooleanChromosome>(false) {

    public void evaluate(Individual<BooleanChromosome> individual) {
      BooleanChromosome chrom = individual.getChromosome();
      int count = 0;
      for (int i = 0; i < chrom.length (); i++) {
        if (chrom.getValue(i)) {
          count++;
        }
      }
      individual.setScore(count);
    }
  };

  GeneticAlgorithm<BooleanChromosome> ga = new GeneticAlgorithm<BooleanChromosome> (fit, pop, GENERATION_LIMIT);
  
  AbstractStage<BooleanChromosome> selection = new TournamentSelector<BooleanChromosome>(3);
  AbstractStage<BooleanChromosome> crossover = new OnePointCrossover<BooleanChromosome>(0.8);
  AbstractStage<BooleanChromosome> mutation = new SimpleMutator<BooleanChromosome>(0.02);
  
  ga.addStage(selection);
  ga.addStage(crossover);
  ga.addStage(mutation);

  ga.setElitism(1);

  ga.evolve();

  Population.Statistics stats = ga.getCurrentPopulation().getStatistics();
  GeneticAlgorithm.Statistics algostats = ga.getStatistics();

  println("Objective: " + (fit.getBiggerIsBetter()[0] ? "Max! (All true)" : "Min! (None true)"));


  Population.Statistics.Group legals = stats.getGroup(Population.LEGALS);

  Individual solution = legals.get(0);

  println("Solution: ");
  println( solution );
  println("found in " + algostats.getExecutionTime() + " ms" );

  Utils.printStatistics(stats);
}

