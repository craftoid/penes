
/**
 *
 * This class implements the strategy for dispensing solutions in the two branches.
 * Odd solutions goes to the first, even to the second.
 *
 */

class SimpleDispenser<T extends Chromosome> extends ExclusiveDispenser<T> {

  int count;

  SimpleDispenser(int span) {
    super(span);
  }

  void preDistribute(Population<T> population) {
    count = 0;
  }

  int distribute(Individual<T> ind) {
    return count++ % span;
  }
}

