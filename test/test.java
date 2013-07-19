 public class test {
 	public static void main(String[] args){
 		Runtime r = Runtime.getRuntime();
 		double mb = 1048576.0;
 		System.out.printf(
 			"This is a test.\n" +
 			"Available CPUs: %d\n" +
 			"Free memory: %.2f MB\n" +
 			"Total memory: %.2f MB\n" +
 			"Max memory: %.2f MB\n",
 			r.availableProcessors(),
 			r.freeMemory()/mb,
 			r.totalMemory()/mb,
 			r.maxMemory()/mb);}}
