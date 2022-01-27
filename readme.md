# C program Lab 1

# **Objective**

This mainstream GPA system was only adopted by PolyU since 2020/21 sem 1. There was an older GPA
system adopted for 2019/20 sem 3 or before, which was very special in the presence of plus-grades and
the absence of minus-grades. Let us call them Current System and Past System respectively as follows:

|Grade          |A+ |A  |A- |B+ |B  |B- |C+ |C  |C- |D+ |D  |D- |F  |
|---------------|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|Current system |4.3|4.0|3.7|3.3|3.0|2.7|2.3|2.0|1.7|1.3|1.0| - |0.0|
|Past System    |4.5|4.0| - |3.5|3.0| - |2.5|2.0| - |1.5|1.0| - |0.0|

+ Assume that there are no other invalid grades such as C++ or E being entered

1. Compile  
```
gcc sources.c -o filename
```
2. Run
```
.\filename A+ B- 
