# Java library packaging exercise

This exercise contains two independent Maven projects:

- `math-lib`: a reusable `com.codegym.Calculator` JAR with integer sum, subtraction, multiplication, and checked division.
- `calculator-app`: a console app that consumes `math-lib` from `lib/math-lib.jar` through a local Maven `system` dependency.

## Build the library and prepare the app

From this directory, build `math-lib` and copy the artifact into the app's local library folder:

```powershell
Set-Location math-lib
mvn clean package
Set-Location ..\calculator-app
New-Item -ItemType Directory -Force lib | Out-Null
Copy-Item ..\math-lib\target\math-lib-1.0.jar lib\math-lib.jar -Force
mvn clean package
java -cp "target/classes;lib/math-lib.jar" com.codegym.Main
```

The app prints the arithmetic results and the expected checked exception for division by zero. The JAR is included in `calculator-app/lib` so the app project is ready to build after checkout.

## Build the console app without Maven

If a JDK is installed, compile the app source with the supplied JAR on the classpath:

```powershell
javac -cp lib\math-lib.jar -d target\classes src\main\java\com\codegym\Main.java
java -cp "target\classes;lib\math-lib.jar" com.codegym.Main
```
