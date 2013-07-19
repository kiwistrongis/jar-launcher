test/test.jar: test/test.class
	cd test && \
	jar cfe test.jar test test.class

test/test.class: test/test.java
	javac test/test.java -d test