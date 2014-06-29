
static class IntegerAlleleSet extends GenericAlleleSet<Integer> {

  IntegerAlleleSet(Set<Integer> set) {
    super(set);
  }

  // Builds a IntegerAlleleSet with random values within the range [lowerBound,upperBound]
  static IntegerAlleleSet createRandom(int size, int lowerBound, int upperBound) {

    HashSet<Integer> values = new HashSet<Integer>();
    int s0 = upperBound - lowerBound + 1;
    if ( size > s0 ) { 
      size = s0;
    }

    Random rand = Random.getInstance();

    for ( int i = 0; i < s0; ++i  ) {

      int chosen = values.size();
      double coin = ((double)size-chosen)/(s0-i);
      boolean justEnough = s0-i == size-chosen;

      if ( justEnough || rand.nextBoolean(coin) ) {
        values.add(lowerBound + i);
      }
    }

    return new IntegerAlleleSet(values);
  }

  // Builds a IntegerAlleleSet with uniformly distributed values  within the range [lowerBound,upperBound]
  static IntegerAlleleSet createUniform(int size, int lowerBound, int upperBound) {

    HashSet<Integer> values = new HashSet<Integer>();
    int s0 = upperBound - lowerBound + 1;
    if ( size > s0 ) size = s0;

    double step = 1.0/(upperBound - lowerBound);
    for ( double x = lowerBound; x <= upperBound; x += step ) {
      int i = (int) Math.round(x);
      values.add(i);
    }

    return new IntegerAlleleSet(values);
  }
  
}

