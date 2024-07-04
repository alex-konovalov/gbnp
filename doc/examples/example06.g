######################### BEGIN COPYRIGHT MESSAGE #########################
# GBNP - computing Gröbner bases of noncommutative polynomials
# Copyright 2001-2010 by Arjeh M. Cohen, Dié A.H. Gijsbers, Jan Willem
# Knopper, Chris Krook. Address: Discrete Algebra and Geometry (DAM) group
# at the Department of Mathematics and Computer Science of Eindhoven
# University of Technology.
#
# For acknowledgements see the manual. The manual can be found in several
# formats in the doc subdirectory of the GBNP distribution. The
# acknowledgements formatted as text can be found in the file chap0.txt.
#
# GBNP is free software; you can redistribute it and/or modify it under
# the terms of the Lesser GNU General Public License as published by the
# Free Software Foundation (FSF); either version 2.1 of the License, or
# (at your option) any later version. For details, see the file 'LGPL' in
# the doc subdirectory of the GBNP distribution or see the FSF's own site:
# https://www.gnu.org/licenses/lgpl.html
########################## END COPYRIGHT MESSAGE ##########################

### filename = "example06.g"
### authors Cohen & Gijsbers

### THIS IS A GAP PACKAGE FOR COMPUTING NON-COMMUTATIVE GROBNER BASES

### Last change: August 22 2001.
### amc

# <#GAPDoc Label="Example06">
# <Section Label="Example06"><Heading>From the Tapas book</Heading>
# This example is a standard commutative Gröbner basis computation from the book
# Some Tapas of Computer Algebra
# <Cite Key="CohenCuypersSterk1999"/>, page 339.
# There are six variables, named <M>a</M>, ... , <M>f</M> by default.
# We work over the rationals and study the ideal generated by the twelve polynomials
# occurring on the middle of page 339 of the Tapas book
# in a project by De Boer and Pellikaan on the ternary cyclic code of length 11.
# Below these are named <C>p1</C>, ..., <C>p12</C>.
# The result should be the union of <M>\{a,b\}</M> and
# the set of 6 homogeneous binomials
# (that is, polynomials with two terms) of degree 2 forcing
# commuting between <M>c</M>, <M>d</M>, <M>e</M>, and <M>f</M>.
# <P/>

# <!--
# a = 1
# b = 2
# sigma_i = i+2 (i=1,2,3,4) = c,d,e,f -->

# <P/>
# First load the package and set the standard infolevel <Ref
# InfoClass="InfoGBNP" Style="Text"/> to 2 and the time infolevel <Ref
# Func="InfoGBNPTime" Style="Text"/> to 1 (for more information about the info
# level, see Chapter <Ref Chap="Info"/>).

# <L>
LoadPackage("gbnp", false);
SetInfoLevel(InfoGBNP,2);
SetInfoLevel(InfoGBNPTime,1);
# </L>

# Now define some functions which will help in the construction of relations.
# The function <C>powermon(g, exp)</C> will return the monomial <M>g^{exp}</M>.
# The function <C>comm(a, b)</C> will return a relation forcing commutativity
# between its two arguments <C>a</C> and <C>b</C>.

# <L>
powermon := function(base, exp)
 local ans,i;
 ans := [];
 for i in [1..exp] do ans :=  Concatenation(ans,[base]); od;
 return ans;
end;;

comm := function(a,b)
  return [[[a,b],[b,a]],[1,-1]];
end;;
# </L>

# Now the relations are entered.

# <L>
p1 := [[[5,1]],[1]];;
p2 := [[powermon(1,3),[6,1]],[1,1]];;
p3 := [[powermon(1,9),Concatenation([3],powermon(1,3))],[1,1]];;
p4 := [[powermon(1,81),Concatenation([3],powermon(1,9)),
        Concatenation([4],powermon(1,3))],[1,1,1]];;
p5 := [[Concatenation([3],powermon(1,81)),Concatenation([4],powermon(1,9)),
        Concatenation([5],powermon(1,3))],[1,1,1]];;
p6 := [[powermon(1,27),Concatenation([4],powermon(1,81)),Concatenation([5],
        powermon(1,9)),Concatenation([6],powermon(1,3))],[1,1,1,1]];;
p7 := [[powermon(2,1),Concatenation([3],powermon(1,27)),Concatenation([5],
        powermon(1,81)),Concatenation([6],powermon(1,9))],[1,1,1,1]];;
p8 := [[Concatenation([3],powermon(2,1)),Concatenation([4],powermon(1,27)),
        Concatenation([6],powermon(1,81))],[1,1,1]];;
p9 := [[Concatenation([],powermon(1,1)),Concatenation([4],powermon(2,1)),
        Concatenation([5],powermon(1,27))],[1,1,1]];;
p10 := [[Concatenation([3],powermon(1,1)),Concatenation([5],powermon(2,1)),
        Concatenation([6],powermon(1,27))],[1,1,1]];;
p11 := [[Concatenation([4],powermon(1,1)),Concatenation([6],powermon(2,1))],
        [1,1]];;
p12 := [[Concatenation([],powermon(2,3)),Concatenation([],powermon(2,1))],
        [1,-1]];;
KI := [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12];;
for i in [1..5] do
    for j in [i+1..6] do
        Add(KI,comm(i,j));
    od;
od;
# </L>

# The relations can be shown with <Ref Func="PrintNPList" Style="Text"/>:

# <L>
PrintNPList(KI);
Length(KI);
# </L>

# It is sometimes easier to enter the relations as elements of a free algebra
# and then use the function <Ref Func="GP2NP" Style="Text"/> or the function
# <Ref Func="GP2NPList" Style="Text"/> to convert them.
# This will be demonstrated below. More about converting can be read
# in Section <Ref Sect="TransitionFunctions"/>.

# <L>
F:=Rationals;;
A:=FreeAssociativeAlgebraWithOne(F,"a","b","c","d","e","f");;
a:=A.a;; b:=A.b;; c:=A.c;; d:=A.d;; e:=A.e;; f:=A.f;;
KI_gp:=[e*a,                         #p1
        a^3 + f*a,                      #p2
        a^9 + c*a^3,                    #p3
        a^81 + c*a^9 + d*a^3,           #p4
        c*a^81 + d*a^9 + e*a^3,         #p5
        a^27 + d*a^81 + e*a^9 + f*a^3,  #p6
        b + c*a^27 + e*a^81 + f*a^9,    #p7
        c*b + d*a^27 + f*a^81,          #p8
        a + d*b + e*a^27,               #p9
        c*a + e*b + f*a^27,             #p10
        d*a + f*b,                      #p11
        b^3 - b];;                      #p12
# </L>

# These relations can be converted to NP form (see <Ref Sect="NP"/>) with <Ref
# Func="GP2NPList" Style="Text"/>. For use in a Gröbner basis computation we have to
# order the NP polynomials in <C>KI</C>.
# This can be done with <Ref Func="CleanNP" Style="Text"/>.

# <L>
KI_np:=GP2NPList(KI_gp);;
Apply(KI,x->CleanNP(x));;
KI_np=KI{[1..12]};
# </L>

# The Gröbner basis can now be calculated with <Ref Func="SGrobner"
# Style="Text"/> and printed with <Ref Func="PrintNPList" Style="Text"/>.

# <L>
GB := SGrobner(KI);;
PrintNPList(GB);
# </L>


# </Section>
# <#/GAPDoc>
