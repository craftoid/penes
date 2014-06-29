
static class DoubleAlleleSet extends GenericAlleleSet<Double> {
  
  DoubleAlleleSet(Set<Double> set) {
    super(set);
  } 

  // Builds a DoubleAlleleSet with random values within the range [lowerBound,upperBound]
  static DoubleAlleleSet createRandom(int size, double lowerBound, double upperBound) {
    HashSet<Double> values = new HashSet<Double>();
    Random rand = Random.getInstance();
    for ( int i = 0; i < size; ++i  ) {
      values.add(rand.nextDouble(lowerBound, upperBound+Double.MIN_VALUE));
    }
    return new DoubleAlleleSet(values);
  }

  // Build a new DoubleAlleleSet with uniformly distributed values within the range [lowerBound,upperBound]
  static DoubleAlleleSet createUniform(int size, double lowerBound, double upperBound) {

    HashSet<Double> values = new HashSet<Double>();
    double step = 1.0/upperBound - lowerBound;
    for ( double x = lowerBound; x <= upperBound; x += step ) {
      values.add(x);
    }
    return new DoubleAlleleSet(values);
  }
  
}

