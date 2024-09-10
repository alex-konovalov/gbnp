#############################################################################
##
#W  ncordmachine.gd
##  NMO: Machinery for installing NM orderings                Randall Cone
##
##
#Y  (C) 2010 Mathematics Dept., Virginia Polytechnic Institute, USA
##
#############################################################################

#############################################################################
##
##  <#GAPDoc Label="IsNoncommutativeMonomialOrdering">
##  <ManSection>
##  <Filt Name="IsNoncommutativeMonomialOrdering"
##        Arg="&lt;obj>"
##        Type="Category"/>
##
##  <Description>
##  A noncommutative monomial ordering is an object representing a monomial ordering
##  on a noncommutative (associative) algebra.  All <Package>NMO</Package>
##  orderings are of this category.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory("IsNoncommutativeMonomialOrdering",IsObject);


#############################################################################
##
##  <#GAPDoc Label="LtFunctionListRep">
##  <ManSection>
##  <Attr Name="LtFunctionListRep"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##  Returns the low-level comparison function used by the given
##  ordering.
##  The function returned is a comparison
##  function on the external representations (lists) for monomials in the
##  algebra.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute("LtFunctionListRep", IsNoncommutativeMonomialOrdering);


#############################################################################
##
##  <#GAPDoc Label="NextOrdering">
##  <ManSection>
##  <Attr Name="NextOrdering"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##  Returns the next noncommutative monomial ordering chained to the given ordering, if one
##  exists.  It is usually called after a <C>true</C> determination
##  has been made with a <C>HasNextOrdering</C> call.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute("NextOrdering",IsNoncommutativeMonomialOrdering);


#############################################################################
##
##  <#GAPDoc Label="ParentAlgebra">
##  <ManSection>
##  <Attr Name="ParentAlgebra"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##  Returns the parent algebra used in the creation of the given
##  ordering.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute("ParentAlgebra", IsNoncommutativeMonomialOrdering );


#############################################################################
##
##  <#GAPDoc Label="LexicographicTable">
##  <ManSection>
##  <Attr Name="LexicographicTable"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##   Returns the ordering of the generators of the <C>ParentAlgebra</C>,
##   as specified in the creation of the given ordering.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute("LexicographicTable", IsNoncommutativeMonomialOrdering);


#############################################################################
##
##  <#GAPDoc Label="LexicographicIndexTable">
##  <ManSection>
##  <Attr Name="LexicographicIndexTable"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##   Returns the ordering of the generators of the <C>ParentAlgebra</C>,
##   as specified in the creation of the given ordering.
##  <P/>
##  An example here would be useful.  We create
##  a length left-lexicographic ordering on an algebra <C>A</C>
##  with an order
##  on the generators of <M>b &lt; a &lt; d &lt; c</M>.  Then in accessing the attributes
##  via the attributes above we see how the list given by <C>LexicographicIndexTable</C>
##  indexes the ordered generators:
##  <Example>
##  gap> A := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c","d");
##  &lt;algebra-with-one over Rationals, with 4 generators>
##  gap> ml := NCMonomialLeftLengthLexOrdering(A,2,4,1,3);
##  NCMonomialLeftLengthLexicographicOrdering([ (1)*b, (1)*d, (1)*a, (1)*c ])
##  gap>  LexicographicTable(ml);
##  [ (1)*b, (1)*d, (1)*a, (1)*c ]
##  gap> LexicographicIndexTable(ml);
##  [ 3, 1, 4, 2 ]
##  </Example>
##
##  The index table shows that the generator <M>a</M> is the third in the generator
##  ordering, <M>b</M> is the least generator in the ordering, <M>c</M> is the greatest
##  and <M>d</M> the second least in order.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute("LexicographicIndexTable", IsNoncommutativeMonomialOrdering);


#############################################################################
##
##  <#GAPDoc Label="LexicographicPermutation">
##  <ManSection>
##  <Attr Name="LexicographicPermutation"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##  Experimental permutation based on the information in <C>LexicographicTable</C>,
##  could possibly be used to make indexed versions of
##  comparison functions more efficient.  Currently only used
##  by the <Package>NMO</Package> built-in ordering <C>NCMonomialLLLTestOrdering</C>.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute("LexicographicPermutation", IsNoncommutativeMonomialOrdering);


#############################################################################
##
##  <#GAPDoc Label="AuxilliaryTable">
##  <ManSection>
##  <Attr Name="AuxilliaryTable"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##  An extra table carried by the given ordering which can be used
##  for such things as weight vectors, etc.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute("AuxilliaryTable", IsNoncommutativeMonomialOrdering);


#############################################################################
##
#R  IsNoncommutativeMonomialOrderingDefaultRep
##
##  The following two lines create the representation and family for
##  our noncommutative monomial ordering objects.
##
DeclareRepresentation("IsNoncommutativeMonomialOrderingDefaultRep",
  IsAttributeStoringRep and IsPositionalObjectRep
  and IsNoncommutativeMonomialOrdering,[]);

BindGlobal("NoncommutativeMonomialOrderingsFamily",
  NewFamily("NoncommutativeMonomialOrderingsFamily",
  IsNoncommutativeMonomialOrdering, IsNoncommutativeMonomialOrdering) );

#############################################################################
##
##  <#GAPDoc Label="InstallNoncommutativeMonomialOrdering">
##  <ManSection>
##  <Func Name="InstallNoncommutativeMonomialOrdering"
##        Arg="&lt;string>, &lt;function>, &lt;function2>"/>
##
##  <Description>
##    Given a name <C>&lt;string></C>, a direct comparison function <C>&lt;function></C>, and an
##    indexed comparison function <C>&lt;function2></C>, <C>InstallNoncommutativeMonomialOrdering</C>
##    will install a monomial ordering function to allow the creation of
##    a monomial ordering based on the provided functions.
##    <P/>
##
##    For example, we create a length ordering by setting up the two comparison
##    functions, choosing a name for the ordering type
##    and then calling <C>InstallNoncommutativeMonomialOrdering</C>.
##
##    <Example>
##    gap> f1 := function(a,b,aux)
##    >   return Length(a) &lt; Length(b);
##    > end;
##    function( a, b, aux ) ... end
##    gap> f2 := function(a,b,aux,idx)
##    >   return Length(a) &lt; Length(b);
##    > end;
##    function( a, b, aux, idx ) ... end
##
##    DeclareGlobalFunction("lenOrdering");
##    InstallNoncommutativeMonomialOrdering("lenOrdering",f1,f2);
##    </Example>
##
##    Now we create an ordering based on this new function, and make
##    some simple comparisons. (Note: we are passing in an empty
##    <C>aux</C> table since it is not being used.  Also, the comparison
##    function is the non-indexed version since we determined
##    no lex order on the generators):
##    <Example>
##    gap> A := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c");
##    &lt;algebra-with-one over Rationals, with 3 generators>
##    gap> ml := lenOrdering(A);
##    lenOrdering([ (1)*a, (1)*b, (1)*c ])
##    gap> 
##    gap> LtFunctionListRep(ml)([1,2],[1,1,1],[]);
##    true
##    gap> LtFunctionListRep(ml)([1,1],[],[]);
##    false
##    </Example>
##    <P/>
##
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction("InstallNoncommutativeMonomialOrdering");


#############################################################################
##
##  <#GAPDoc Label="OrderingLtGtFunctions">
##  <ManSection>
##  <Oper Name="OrderingLtFunctionListRep"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##  </Description>
##
##  <Oper Name="OrderingGtFunctionListRep"
##        Arg="&lt;NoncommutativeMonomialOrdering>"/>
##
##  <Description>
##  Given a noncommutative monomial ordering, 
##  <C>OrderingLtFunctionListRep</C> and <C>OrderingGtFunctionListRep</C>
##  return functions which compare the `list' representations
##  (NP representations) of two
##  monomials from the ordering's associated parent algebra.
##  These functions are not typically accessed by the user.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("OrderingLtFunctionListRep",
  [ IsNoncommutativeMonomialOrdering ]
);
DeclareOperation("OrderingGtFunctionListRep",
  [ IsNoncommutativeMonomialOrdering ]
);


#############################################################################
##
#O  OrderGenerators( <algebra>, <list> )
##
##  Given an algebra and an ordered list (partial or full) of generators for
##  the algebra, `OrderGenerators' will return a full list of generators
##  based on the given ordering, and will complete the list if necessary.
##
DeclareOperation("OrderGenerators",
  [ IsAlgebra, IsList]
);


#############################################################################
##
#O  IndexGenerators( <list> )
##
##  Given an ordered list of generators for an algebra, `IndexGenerators'
##  transforms the list to one with which sorting comparisons may be made.
##
DeclareOperation("IndexGenerators", [ IsList ]);

##
#E
