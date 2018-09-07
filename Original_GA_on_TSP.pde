import java.util.*;
import java.io.*;

for(int counter=1;counter<101;counter=counter+1){
//try{  
//    PrintWriter out = new PrintWriter("C:\\Users\\timot\\Desktop\\haha.txt"); 
//    out.println(99);
//    out.println(99);
//    out.close();
//}catch ( IOException e)
//{
//}


int [][] city = new int [20][2];

city[0][0]=152;
city[0][1]=19;

city[1][0]=135;  
city[1][1]=778;

city[2][0]=17;
city[2][1]=12;

city[3][0]=317;
city[3][1]=408;

city[4][0]=553;
city[4][1]=161;

city[5][0]=390;
city[5][1]=136;

city[6][0]=75;
city[6][1]=237;

city[7][0]=920;
city[7][1]=81;

city[8][0]=280;
city[8][1]=928;

city[9][0]=243;
city[9][1]=550;

city[10][0]=161;
city[10][1]=719;

city[11][0]=982;
city[11][1]=932;

city[12][0]=506;
city[12][1]=285;

city[13][0]=481;
city[13][1]=743;

city[14][0]=891;
city[14][1]=284;;

city[15][0]=332;
city[15][1]=653;

city[16][0]=84;
city[16][1]=431;

city[17][0]=313;
city[17][1]=824;

city[18][0]=534;
city[18][1]=736;

city[19][0]=145;
city[19][1]=262;


//++++++++++++++++++++++++++++++++++++++++++++++


//initialization
//run once to set up the first generation

//generating 20 numbers without duplicating


//number of generation  
int numgen = 1000;

//generation size (number of population in a generation)
int gensize = 1000;

int[][][] pop = new int[numgen][gensize][20];

  
  
   for(int j=0; j<gensize;j=j+1){
     for(int i=0; i < 20; i=i+1) {
       float x = random(0,19);
       int rx = Math.round(x);
       pop [0][j][i] = rx; 
     
       for(int k=0; k<i;k=k+1) {
         if (pop[0][j][k]!=pop[0][j][i])
         {continue;} 
         else {i=i-1;
           break;}
       } 
     }
   }
   
   // beware that array starts with 0, not 1
   //println(pop[0][0]);
 
   
   

float [][] fitness = new float [numgen][gensize];
//inverse of fitness
float[][] inverse = new float [numgen][gensize];

for(int gen=0;gen<gensize;gen=gen+1) {
//int gen=0;

//fitness function

//eg. fitness [1][2] corresponds to pop [1][2]
for(int c=0;c<gensize;c=c+1){
 int point0 = pop[gen][c][0];
 int point19 = pop[gen][c][19];
 float firstdis = sqrt(pow(city[point0][1] - city[point19][1],2) + pow(city[point0][0] - city[point19][0],2)); 
   for(int e=0;e<19;e=e+1){
     int point1 = pop[gen][c][e];
     int point2 = pop[gen][c][e+1];
     fitness[gen][c] = fitness[gen][c] + sqrt(pow(city[point1][1] - city[point2][1],2) + pow(city[point1][0] - city[point2][0],2));  
   }
 fitness[gen][c]=fitness[gen][c] + firstdis;
 println(fitness[0][c]);
 }


if (gen == numgen-1){break;}

 //convert fitness to probability
 //because we need to minimize the function, producing probabilities of inverse of fitness can help us facilitate our fitness proportionate selection.


for(int w=0; w<gensize;w=w+1){
  inverse [gen][w]=1/fitness[gen][w];}


//sum of inverses
float inversesum=0;
 for (float i : inverse[gen]){
  inversesum += i;}
  //println("sum:",inversesum); 
//probability of each chromosome

float[][] prob = new float [numgen][gensize];
 for(int s=0;s<gensize;s=s+1){
 prob[gen][s] = inverse[gen][s]/inversesum;}
 
 
//cumulative probabilities 
float [][] cumprob = new float [numgen][gensize];
float p = 0;
for (int e=0;e<gensize;e=e+1){
  cumprob[gen][e]= p + prob[gen][e];
  p=cumprob[gen][e];}

//start looping to produce a new generation
//order = order in EACH GENERATION
for (int order=0;order<gensize;order=order+1){
//selection of parents
//[2] = two parents

int [][] parents = new int [2][20];

for(int r=0; r<2; r=r+1) {
  float y = random(0,1);
if (y>cumprob[gen][gensize-1])
{parents[r] = pop[gen][gensize-1];}
else {
for (int u=0;u<gensize-1;u=u+1){
  if ((y>cumprob[gen][u]) && (y<cumprob[gen][u+1])){
    parents[r] = pop[gen][u];
  break;}
    else {continue;}}
}}

//println("+++++++++++++++++++++++++++++++++++++++++");

//creation of neigbor lists
  //WARNING: CHANGE OF REPRESENTATION 
  //neighbors and parents are temporary variables
  //FROM pop[gen][slots] to neighbors[city positions]
  //first [] -> two neigborlists for two parents
  //second [] -> number of cities
  //third [] -> each city connects to two other cities
int [][][] neighbors = new int [2][20][2];


for(int listnumber=0;listnumber<2;listnumber=listnumber+1){

for (int h=0;h<20;h=h+1){
  for (int q=0;q<20;q=q+1){
  if (parents[listnumber][q] == h){
    if (q==0)
      {neighbors[listnumber][h][0]=parents[listnumber][1];
      neighbors[listnumber][h][1]=parents[listnumber][19];
    break;}
      else { 
        if (q==19)
      {neighbors[listnumber][h][0]=parents[listnumber][0];
      neighbors[listnumber][h][1]=parents[listnumber][18];
    break;}
          else {    neighbors[listnumber][h][0]= parents[listnumber][q-1];
    neighbors[listnumber][h][1]= parents[listnumber][q+1];}}}
        else{continue;

        }}}
}
for (int u=0;u<20;u=u+1){
//println("neighborlist0:",neighbors[0][u]);
//println("+++++++++++++++++++");
//println("neigborlist1:", neighbors[1][u]);
}




import java.util.*;
import java.util.Arrays.*;
import java.util.ArrayList;
import java.util.Random;


//changing array to arraylist



//list0
ArrayList<ArrayList<Integer>> neighborlist0 = new ArrayList<ArrayList<Integer>>();
  

  
  ArrayList<Integer> flist0 = new ArrayList<Integer>();
  ArrayList<Integer> flist1 = new ArrayList<Integer>();
  ArrayList<Integer> flist2 = new ArrayList<Integer>();
  ArrayList<Integer> flist3 = new ArrayList<Integer>();
  ArrayList<Integer> flist4 = new ArrayList<Integer>();
  ArrayList<Integer> flist5 = new ArrayList<Integer>();
  ArrayList<Integer> flist6 = new ArrayList<Integer>();
  ArrayList<Integer> flist7 = new ArrayList<Integer>();
  ArrayList<Integer> flist8 = new ArrayList<Integer>();
  ArrayList<Integer> flist9 = new ArrayList<Integer>();
  ArrayList<Integer> flist10 = new ArrayList<Integer>();
  ArrayList<Integer> flist11 = new ArrayList<Integer>();
  ArrayList<Integer> flist12 = new ArrayList<Integer>();
  ArrayList<Integer> flist13 = new ArrayList<Integer>();
  ArrayList<Integer> flist14 = new ArrayList<Integer>();
  ArrayList<Integer> flist15 = new ArrayList<Integer>();
  ArrayList<Integer> flist16 = new ArrayList<Integer>();
  ArrayList<Integer> flist17 = new ArrayList<Integer>();
  ArrayList<Integer> flist18 = new ArrayList<Integer>();
  ArrayList<Integer> flist19 = new ArrayList<Integer>();




neighborlist0.add(flist0);
neighborlist0.add(flist1);
neighborlist0.add(flist2);
neighborlist0.add(flist3);
neighborlist0.add(flist4);
neighborlist0.add(flist5);
neighborlist0.add(flist6);
neighborlist0.add(flist7);
neighborlist0.add(flist8);
neighborlist0.add(flist9);
neighborlist0.add(flist10);
neighborlist0.add(flist11);
neighborlist0.add(flist12);
neighborlist0.add(flist13);
neighborlist0.add(flist14);
neighborlist0.add(flist15);
neighborlist0.add(flist16);
neighborlist0.add(flist17);
neighborlist0.add(flist18);
neighborlist0.add(flist19);




flist0.add(neighbors[0][0][0]);
flist0.add(neighbors[0][0][1]);

flist1.add(neighbors[0][1][0]);
flist1.add(neighbors[0][1][1]);
 
flist2.add(neighbors[0][2][0]);
flist2.add(neighbors[0][2][1]);

flist3.add(neighbors[0][3][0]);
flist3.add(neighbors[0][3][1]);  
  
flist4.add(neighbors[0][4][0]);
flist4.add(neighbors[0][4][1]);

flist5.add(neighbors[0][5][0]);
flist5.add(neighbors[0][5][1]);  
 
flist6.add(neighbors[0][6][0]);
flist6.add(neighbors[0][6][1]); 
 
flist7.add(neighbors[0][7][0]);
flist7.add(neighbors[0][7][1]);

flist8.add(neighbors[0][8][0]);
flist8.add(neighbors[0][8][1]);

flist9.add(neighbors[0][9][0]);
flist9.add(neighbors[0][9][1]);

flist10.add(neighbors[0][10][0]);
flist10.add(neighbors[0][10][1]);

flist11.add(neighbors[0][11][0]);
flist11.add(neighbors[0][11][1]);

flist12.add(neighbors[0][12][0]);
flist12.add(neighbors[0][12][1]);

flist13.add(neighbors[0][13][0]);
flist13.add(neighbors[0][13][1]);
 
flist14.add(neighbors[0][14][0]);
flist14.add(neighbors[0][14][1]);

flist15.add(neighbors[0][15][0]);
flist15.add(neighbors[0][15][1]);  
 
flist16.add(neighbors[0][16][0]);
flist16.add(neighbors[0][16][1]); 
 
flist17.add(neighbors[0][17][0]);
flist17.add(neighbors[0][17][1]);

flist18.add(neighbors[0][18][0]);
flist18.add(neighbors[0][18][1]);

flist19.add(neighbors[0][19][0]);
flist19.add(neighbors[0][19][1]);
 

 
 
//List1

ArrayList<ArrayList<Integer>> neighborlist1 = new ArrayList<ArrayList<Integer>>();
  
 // neighborlists.add(new ArrayList<Integer>());
  
  ArrayList<Integer> list0 = new ArrayList<Integer>();
  ArrayList<Integer> list1 = new ArrayList<Integer>();
  ArrayList<Integer> list2 = new ArrayList<Integer>();
  ArrayList<Integer> list3 = new ArrayList<Integer>();
  ArrayList<Integer> list4 = new ArrayList<Integer>();
  ArrayList<Integer> list5 = new ArrayList<Integer>();
  ArrayList<Integer> list6 = new ArrayList<Integer>();
  ArrayList<Integer> list7 = new ArrayList<Integer>();
  ArrayList<Integer> list8 = new ArrayList<Integer>();
  ArrayList<Integer> list9 = new ArrayList<Integer>();
  ArrayList<Integer> list10 = new ArrayList<Integer>();
  ArrayList<Integer> list11 = new ArrayList<Integer>();
  ArrayList<Integer> list12 = new ArrayList<Integer>();
  ArrayList<Integer> list13 = new ArrayList<Integer>();
  ArrayList<Integer> list14 = new ArrayList<Integer>();
  ArrayList<Integer> list15 = new ArrayList<Integer>();
  ArrayList<Integer> list16 = new ArrayList<Integer>();
  ArrayList<Integer> list17 = new ArrayList<Integer>();
  ArrayList<Integer> list18 = new ArrayList<Integer>();
  ArrayList<Integer> list19 = new ArrayList<Integer>();




neighborlist1.add(list0);
neighborlist1.add(list1);
neighborlist1.add(list2);
neighborlist1.add(list3);
neighborlist1.add(list4);
neighborlist1.add(list5);
neighborlist1.add(list6);
neighborlist1.add(list7);
neighborlist1.add(list8);
neighborlist1.add(list9);
neighborlist1.add(list10);
neighborlist1.add(list11);
neighborlist1.add(list12);
neighborlist1.add(list13);
neighborlist1.add(list14);
neighborlist1.add(list15);
neighborlist1.add(list16);
neighborlist1.add(list17);
neighborlist1.add(list18);
neighborlist1.add(list19);




list0.add(neighbors[1][0][0]);
list0.add(neighbors[1][0][1]);

list1.add(neighbors[1][1][0]);
list1.add(neighbors[1][1][1]);
 
list2.add(neighbors[1][2][0]);
list2.add(neighbors[1][2][1]);

list3.add(neighbors[1][3][0]);
list3.add(neighbors[1][3][1]);  
  
list4.add(neighbors[1][4][0]);
list4.add(neighbors[1][4][1]);

list5.add(neighbors[1][5][0]);
list5.add(neighbors[1][5][1]);  
 
list6.add(neighbors[1][6][0]);
list6.add(neighbors[1][6][1]); 
 
list7.add(neighbors[1][7][0]);
list7.add(neighbors[1][7][1]);

list8.add(neighbors[1][8][0]);
list8.add(neighbors[1][8][1]);

list9.add(neighbors[1][9][0]);
list9.add(neighbors[1][9][1]);

list10.add(neighbors[1][10][0]);
list10.add(neighbors[1][10][1]);

list11.add(neighbors[1][11][0]);
list11.add(neighbors[1][11][1]);

list12.add(neighbors[1][12][0]);
list12.add(neighbors[1][12][1]);

list13.add(neighbors[1][13][0]);
list13.add(neighbors[1][13][1]);
 
list14.add(neighbors[1][14][0]);
list14.add(neighbors[1][14][1]);

list15.add(neighbors[1][15][0]);
list15.add(neighbors[1][15][1]);  
 
list16.add(neighbors[1][16][0]);
list16.add(neighbors[1][16][1]); 
 
list17.add(neighbors[1][17][0]);
list17.add(neighbors[1][17][1]);

list18.add(neighbors[1][18][0]);
list18.add(neighbors[1][18][1]);

list19.add(neighbors[1][19][0]);
list19.add(neighbors[1][19][1]);
 
//println(neighborlist1); 

//forming union list0 and list 1


ArrayList<ArrayList<Integer>> neighborunion = new ArrayList<ArrayList<Integer>>();

  ArrayList<Integer> ulist0 = new ArrayList<Integer>();
  ArrayList<Integer> ulist1 = new ArrayList<Integer>();
  ArrayList<Integer> ulist2 = new ArrayList<Integer>();
  ArrayList<Integer> ulist3 = new ArrayList<Integer>();
  ArrayList<Integer> ulist4 = new ArrayList<Integer>();
  ArrayList<Integer> ulist5 = new ArrayList<Integer>();
  ArrayList<Integer> ulist6 = new ArrayList<Integer>();
  ArrayList<Integer> ulist7 = new ArrayList<Integer>();
  ArrayList<Integer> ulist8 = new ArrayList<Integer>();
  ArrayList<Integer> ulist9 = new ArrayList<Integer>();
  ArrayList<Integer> ulist10 = new ArrayList<Integer>();
  ArrayList<Integer> ulist11 = new ArrayList<Integer>();
  ArrayList<Integer> ulist12 = new ArrayList<Integer>();
  ArrayList<Integer> ulist13 = new ArrayList<Integer>();
  ArrayList<Integer> ulist14 = new ArrayList<Integer>();
  ArrayList<Integer> ulist15 = new ArrayList<Integer>();
  ArrayList<Integer> ulist16 = new ArrayList<Integer>();
  ArrayList<Integer> ulist17 = new ArrayList<Integer>();
  ArrayList<Integer> ulist18 = new ArrayList<Integer>();
  ArrayList<Integer> ulist19 = new ArrayList<Integer>();
 
neighborunion.add(ulist0);
neighborunion.add(ulist1);
neighborunion.add(ulist2);
neighborunion.add(ulist3);
neighborunion.add(ulist4);
neighborunion.add(ulist5);
neighborunion.add(ulist6);
neighborunion.add(ulist7);
neighborunion.add(ulist8);
neighborunion.add(ulist9);
neighborunion.add(ulist10);
neighborunion.add(ulist11);
neighborunion.add(ulist12);
neighborunion.add(ulist13);
neighborunion.add(ulist14);
neighborunion.add(ulist15);
neighborunion.add(ulist16);
neighborunion.add(ulist17);
neighborunion.add(ulist18);
neighborunion.add(ulist19);

ulist0.add(flist0.get(0));
ulist0.add(flist0.get(1));
ulist0.add(list0.get(0));
ulist0.add(list0.get(1));

ulist1.add(flist1.get(0));
ulist1.add(flist1.get(1));
ulist1.add(list1.get(0));
ulist1.add(list1.get(1));
  
ulist2.add(flist2.get(0));
ulist2.add(flist2.get(1));
ulist2.add(list2.get(0));
ulist2.add(list2.get(1));

ulist3.add(flist3.get(0));
ulist3.add(flist3.get(1));
ulist3.add(list3.get(0));
ulist3.add(list3.get(1));

ulist4.add(flist4.get(0));
ulist4.add(flist4.get(1));
ulist4.add(list4.get(0));
ulist4.add(list4.get(1));

ulist5.add(flist5.get(0));
ulist5.add(flist5.get(1));
ulist5.add(list5.get(0));
ulist5.add(list5.get(1));
  
ulist6.add(flist6.get(0));
ulist6.add(flist6.get(1));
ulist6.add(list6.get(0));
ulist6.add(list6.get(1));

ulist7.add(flist7.get(0));
ulist7.add(flist7.get(1));
ulist7.add(list7.get(0));
ulist7.add(list7.get(1));

ulist8.add(flist8.get(0));
ulist8.add(flist8.get(1));
ulist8.add(list8.get(0));
ulist8.add(list8.get(1));

ulist9.add(flist9.get(0));
ulist9.add(flist9.get(1));
ulist9.add(list9.get(0));
ulist9.add(list9.get(1));
  
ulist10.add(flist10.get(0));
ulist10.add(flist10.get(1));
ulist10.add(list10.get(0));
ulist10.add(list10.get(1));

ulist11.add(flist11.get(0));
ulist11.add(flist11.get(1));
ulist11.add(list11.get(0));
ulist11.add(list11.get(1));

ulist12.add(flist12.get(0));
ulist12.add(flist12.get(1));
ulist12.add(list12.get(0));
ulist12.add(list12.get(1));

ulist13.add(flist13.get(0));
ulist13.add(flist13.get(1));
ulist13.add(list13.get(0));
ulist13.add(list13.get(1));
  
ulist14.add(flist14.get(0));
ulist14.add(flist14.get(1));
ulist14.add(list14.get(0));
ulist14.add(list14.get(1));

ulist15.add(flist15.get(0));
ulist15.add(flist15.get(1));
ulist15.add(list15.get(0));
ulist15.add(list15.get(1));

ulist16.add(flist16.get(0));
ulist16.add(flist16.get(1));
ulist16.add(list16.get(0));
ulist16.add(list16.get(1));

ulist17.add(flist17.get(0));
ulist17.add(flist17.get(1));
ulist17.add(list17.get(0));
ulist17.add(list17.get(1));

ulist18.add(flist18.get(0));
ulist18.add(flist18.get(1));
ulist18.add(list18.get(0));
ulist18.add(list18.get(1));
  
ulist19.add(flist19.get(0));
ulist19.add(flist19.get(1));
ulist19.add(list19.get(0));
ulist19.add(list19.get(1));



//println();
//println(neighborunion);


//eliminating duplicates

for (ArrayList<Integer> w : neighborunion){
//eliminating duplicates
for(int k=0;k<20;k=k+1){
  if (w.indexOf(k) != w.lastIndexOf(k)){
    w.remove(w.lastIndexOf(k));}
   else {continue;}
}
}
//println("Duplication eliminated");
//println();
//println(neighborunion);


//crossover probability
//crossover probability:90%
//need to pay attention due to proceeding to another generation
ArrayList<Integer> child = new ArrayList<Integer>();
int N = 0;


float crossprob = random(0,100);
if (crossprob>90){
  float parentprob = random(0,100);
  if (parentprob>50) {
    pop[gen+1][order]=parents[0]; }
    else {pop[gen+1][order]=parents[1];}}
  else {//crossover:
     //setting up the crossover with first node
   //N = first node (at this moment)
   float firstnodeprob = random (0,2);
   
   if (firstnodeprob > 1) {
     N = parents[0][0];
   }
   else {N = parents[1][0];}}
   
   //+++++++++++++++++++CROSSOVER BEGINS +++++++++++++++++++++
 while (child.size() < 20) {
 ArrayList<Integer> minvalue = new ArrayList<Integer>();
 ArrayList<Integer> leftover = new ArrayList<Integer>();
 ArrayList<Integer> x = new ArrayList<Integer>();
 int previous = 999;
 //int[] i = new int [4];
     child.add(N);
     //remove N from all neighbor lists
     for (ArrayList<Integer> a : neighborunion){
       if (a.indexOf(N) != -1) {
         a.remove(a.indexOf(N));
       } else {continue;}
     }    
   if (!(neighborunion.get(N).isEmpty())){
       //finding the list with the least elements
       int[] gg = new int [4];
       int limit = (neighborunion.get(N)).size();
       for(int d=0;d<limit;d=d+1){
       gg[d] =  (neighborunion.get((neighborunion.get(N)).get(d))).size();
       //previous is first set to be 999.
       previous = min (previous, gg[d]);
       }
     //previous = the length of the shortest neighbor set(s)
     //array e = the lengths of each neighbor sets    
   for (int g=0;g<limit;g=g+1){        
     if (previous == gg[g]) {
       x.add(g);
       minvalue.add(gg[g]);} 
     //println(minvalue);}
     else {continue;}
   }    
     if (minvalue.size() == 1){ 
       N = ((neighborunion.get(N)).get(x.get(0))); } 
     else {float fewest = random (0,minvalue.size());      
       N = (neighborunion.get(N)).get(x.get(int(fewest)));
     } }      
    else {
      for(int i=0;i<20;i=i+1) {
         if (child.contains(i)){
           continue;}
           else {leftover.add(i);}
      }
      if (!(leftover.isEmpty())) {
      float remains = random(0, leftover.size());
      //println(leftover.size());
      int rremains = int(remains);
      N = leftover.get(rremains);}
    }}
//++++++++++++++++CROSSOVER FINISHED++++++++++++++++++++++++++
//mutation probability
int point1 = 0;
int point2 = 0;
//MUTATION BEGINS
//Restriction site mutation (RSM)
float mutationprob = random(0,100);
//change mutation probability
if (mutationprob>5){
  //println("no mutation");
 for (int y=0;y<20;y=y+1){
   pop[gen+1][order][y] = child.get(y); } }   
   else {
     float reverse1 = random(0,20);
     float reverse2 = random(0,20);
     int rreverse1 = int(reverse1);
     int rreverse2 = int(reverse2);
     
     if (rreverse1>rreverse2){
      point1 = rreverse2;
      point2 = rreverse1;
     } else {
      point1 = rreverse1;
      point2 = rreverse2;}
 
    ArrayList<Integer> clone = new ArrayList <Integer>();
     int w = 0; 
     clone.addAll(child);
    
     while ((point1+w)!=point2+1){
      child.set(point1+w,clone.get(point2-w));
      //println(child);
      w=w+1;}
            
      for (int f=0;f<20;f=f+1){
   pop[gen+1][order][f] = child.get(f); }
   }
   }
}


 
 
 
//all fitnesses
try{  
    PrintWriter out = new PrintWriter("C:\\Users\\timot\\Dropbox\\IB Math\\Math EE\\GA Experiment Data\\Raw Data\\MU_0.05 (Jan 9)\\"+counter+"fitnesses.txt"); 
    for (int ss = 0;ss<numgen;ss=ss+1){
    for (int x=0;x<gensize;x=x+1){
    out.println(fitness[ss][x]);}
  }
    out.close();
}catch ( IOException e)
{
}

//max inverses all along
 float mm = 0;
try{  
    PrintWriter out = new PrintWriter("C:\\Users\\timot\\Dropbox\\IB Math\\Math EE\\GA Experiment Data\\Raw Data\\MU_0.05 (Jan 9)\\"+counter+"maxinverses.txt"); 
 
    for (int ss = 0;ss<numgen;ss=ss+1){
      for (int x=0;x<gensize;x=x+1){
     mm = max(mm,inverse[ss][x]);
     }out.println(mm);}
     out.close();
}
catch ( IOException e)
{
}


 
try{  
    PrintWriter out = new PrintWriter("C:\\Users\\timot\\Dropbox\\IB Math\\Math EE\\GA Experiment Data\\Raw Data\\MU_0.05 (Jan 9)\\"+counter+"pergen_bestpop.txt"); 
 
    for (int ss = 0;ss<numgen;ss=ss+1){
      float kk=0;
      for (int x=0;x<gensize;x=x+1){
     kk = max(kk,inverse[ss][x]);
     }
 for(int uu=0;uu<gensize;uu=uu+1){
   if(fitness[ss][uu] == (1/kk)){
     for(int hh=0;hh<20;hh=hh+1)
       {out.println(pop[ss][uu][hh]);}
     break;}
       else{continue;}
   
 }
     
}
out.close();}
catch ( IOException e)
{
}







//max inverses per generation
try{
  PrintWriter out = new PrintWriter("C:\\Users\\timot\\Dropbox\\IB Math\\Math EE\\GA Experiment Data\\Raw Data\\MU_0.05 (Jan 9)\\"+counter+"pergen_maxinveres.txt");

    for (int ss = 0;ss<numgen;ss=ss+1){
        float yy = 0;
      for (int x=0;x<gensize;x=x+1){
     yy = max(yy,inverse[ss][x]);
     }out.println(yy);}
     out.close();

}
catch ( IOException e)
{
}


}
  