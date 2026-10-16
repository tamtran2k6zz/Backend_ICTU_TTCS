# Quadratic equation solver library

This exercise contains two Maven projects:

- `quadratic-equation-lib`: reusable `com.codegym.math.QuadraticEquationSolver` and immutable `QuadraticSolution` classes.
- `quadratic-equation-app`: a console app that imports and runs the packaged library from `lib/quadratic-equation-lib.jar`.

The solver handles equations `ax² + bx + c = 0`, returns zero, one, or two real roots, and rejects non-quadratic equations (`a = 0`) and non-finite coefficients. Roots are returned in ascending order. The two-root case uses a numerically stable formula.

## Build and run with Maven

From this directory:

```powershell
Set-Location quadratic-equation-lib
mvn clean package
Set-Location ..\quadratic-equation-app
New-Item -ItemType Directory -Force lib | Out-Null
Copy-Item ..\quadratic-equation-lib\target\quadratic-equation-lib-1.0.jar lib\quadratic-equation-lib.jar -Force
mvn clean package
java -cp "target/classes;lib/quadratic-equation-lib.jar" com.codegym.app.Main
```

The example prints results for two distinct real roots, a repeated root, and no real roots. The packaged JAR is included under the app's `lib` directory.

## Build and run with a JDK

```powershell
javac --release 17 -d quadratic-equation-lib\target\classes quadratic-equation-lib\src\main\java\com\codegym\math\QuadraticSolution.java quadratic-equation-lib\src\main\java\com\codegym\math\QuadraticEquationSolver.java
jar --create --file quadratic-equation-lib\target\quadratic-equation-lib-1.0.jar -C quadratic-equation-lib\target\classes .
Copy-Item quadratic-equation-lib\target\quadratic-equation-lib-1.0.jar quadratic-equation-app\lib\quadratic-equation-lib.jar -Force
javac --release 17 -cp quadratic-equation-app\lib\quadratic-equation-lib.jar -d quadratic-equation-app\target\classes quadratic-equation-app\src\main\java\com\codegym\app\Main.java
java -cp "quadratic-equation-app\target\classes;quadratic-equation-app\lib\quadratic-equation-lib.jar" com.codegym.app.Main
```
