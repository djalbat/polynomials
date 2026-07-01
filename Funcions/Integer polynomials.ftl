Boolean isTermIntegerPolynomial(Node termNode, Node indeterminateTermNode) {
  String indeterminateIdentifier = identifierFromTermNode(indeterminateTermNode);

  Boolean integerPolynomial = 

    if (indeterminateIdentifier != "") {
      Boolean integer = isTermInteger(termNode);
      Boolean compound = isTermCompound(termNode, indeterminateIdentifier);
      Boolean expoential = isTermExponential(termNode, indeterminateIdentifier);
      Boolean indeterminate = isTermIndeterminate(termNode, indeterminateIdentifier);

      Boolean integerPolynomial = (integer || compound || expoential || indeterminate);  

      return integerPolynomial;
    }

    else
      false
  ;

  return integerPolynomial;
}

Boolean isTermIndeterminate(Node termNode, String indeterminateIdentifier) {
  Boolean indeterminate = 

    if (termNode != null) {
      String identifier = identifierFromTermNode(termNode);

      Boolean indeterminate = (identifier == indeterminateIdentifier);  

      return indeterminate;
    }
    else
      false

  ;

  return indeterminate;
}

Boolean isTermExponential(Node termNode, String indeterminateIdentifier) {
  { List<Node> childNodes } = termNode;

  Integer childNodesLength = lengthOf(childNodes);

  Boolean exponential = 

    if (childNodesLength == 5) {
      [ , Node centerLeftChildNode, Node centerChildNode, Node centerRightChildNode,  ] = childNodes;

      Boolean centerChildCaret = isCaret(centerChildNode);

      Boolean centerLeftChildNoWhitespace = isNoWhitespace(centerLeftChildNode);
      Boolean centerRightChildNoWhitespace = isNoWhitespace(centerRightChildNode);

      Boolean exponential = 

        if (centerChildCaret && centerLeftChildNoWhitespace && centerRightChildNoWhitespace) {
          [ Node leftChildNode, , , , Node rightChildNode ] = childNodes;

          Node leftTermNode = nodeQuery(leftChildNode, "/argument/term!");
          Node rightTermNode = nodeQuery(rightChildNode, "/argument/term!");

          Boolean leftCompound = isTermCompound(leftTermNode, indeterminateIdentifier);

          Boolean leftIndeterminate = isTermIndeterminate(leftTermNode, indeterminateIdentifier);

          Boolean rightInteger = isTermInteger(rightTermNode);

          Boolean exponential = ((leftCompound || leftIndeterminate) && rightInteger);

          return exponential;
        }
        else
          false

      ;

      return exponential;
    }
    else
      false

  ;

  return exponential;
}

Boolean isTermCompound(Node termNode, String indeterminateIdentifier) {
  { List<Node> childNodes } = termNode;

  Integer childNodesLength = lengthOf(childNodes);

  Boolean compound = 

    if (childNodesLength == 3) {
      [ , Node centerChildNode, ] = childNodes;

      Boolean centerChildNoWhitespace = isNoWhitespace(centerChildNode);

      Boolean compound = 

        if (centerChildNoWhitespace) {
          [ Node leftChildNode, , Node rightChildNode ] = childNodes;

          Node leftTermNode = nodeQuery(leftChildNode, "/argument/term!");
          Node rightTermNode = nodeQuery(rightChildNode, "/argument/term!");

          Boolean rightTermIndeterminate = isTermIndeterminate(rightTermNode, indeterminateIdentifier);

          Boolean leftTermInteger = isTermInteger(leftTermNode);

          Boolean compound = (leftTermInteger && rightTermIndeterminate);

          return compound;
        }
        else
          false

      ;

      return compound;
    }
    else
      false

  ;

  return compound;
}

Boolean isCaret(Node node) {
  { Boolean terminal } = node;

  Boolean caret = 

    if (terminal) {
      Node terminalNode = node;

      { String content } = terminalNode;

      Boolean caret = (content == "^");

      return caret;
    }
    else
      false

  ;

  return caret;
}

Boolean isTermInteger(Node termNode) {
  Boolean integer = 

    if (termNode != null) {
      Boolean integer = tryInteger(termNode);

      return integer;
    }
    else
      false

    ;

  return integer;
}

Boolean isNoWhitespace(Node node) {
  { Boolean terminal } = node;

  Boolean noWhitespace = 

    if (terminal) {
      Node terminalNode = node;

      { Boolean noWhitespace } = terminalNode;

      return noWhitespace;
    }
    else
      false

  ;

  return noWhitespace;
}

String identifierFromTermNode(Node termNode) {
  Node identifierTerminalNode = nodeQuery(termNode, "/term/variable!/@identifier!");

  String identifier = 

    if (identifierTerminalNode != null) {
      { String content as identifier } = identifierTerminalNode;

      return identifier;
    }

    else
      ""
  ;

  return identifier;
}
