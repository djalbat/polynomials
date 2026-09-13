import isTermInteger, isTermNaturalNumber from "decimal-numbers";

Boolean isTermIntegerPolynomial(Node termNode, Node indeterminateTermNode) {
  Boolean termPositiveIntegerPolynomial = isTermPositiveIntegerPolynomial(termNode, indeterminateTermNode);
  
  Boolean termNegativeIntegerPolynomial = isTermNegativeIntegerPolynomial(termNode, indeterminateTermNode);

  Boolean termIntegerPolynomial = (termPositiveIntegerPolynomial || termNegativeIntegerPolynomial);

  return termIntegerPolynomial;
}

Boolean isTermPositiveIntegerPolynomial(Node termNode, Node indeterminateTermNode) {
  Boolean termIntegerMonomial = isTermIntegerMonomial(termNode, indeterminateTermNode);
  
  Boolean termStrictIntegerPolynomial = isTermStrictIntegerPolynomial(termNode, indeterminateTermNode);

  Boolean termPositiveIntegerPolynomial = (termIntegerMonomial || termStrictIntegerPolynomial);

  return termPositiveIntegerPolynomial;
}

Boolean isTermNegativeIntegerPolynomial(Node termNode, Node indeterminateTermNode) {
  { List<Node> childNodes } = termNode;

  Boolean termNegativeIntegerPolynomial = apply(childNodes, [
    isMinus, 
    isBacktick, 
    isArgumentTermPositiveIntegerPolynomial
  ], indeterminateTermNode);

  return termNegativeIntegerPolynomial;
}

Boolean isTermStrictIntegerPolynomial(Node termNode, Node indeterminateTermNode) {
  { List<Node> childNodes } = termNode;

  Boolean termStrictIntegerPolynomial = apply(childNodes, [
    isArgumentTermIntegerPolynomial, 
    isBacktick, 
    isPlusOrMinus, 
    isBacktick, 
    isArgumentTermIntegerMonomial
  ], indeterminateTermNode);

  return termStrictIntegerPolynomial;
}

Boolean isTermIntegerMonomial(Node termNode, Node indeterminateTermNode) {
  Boolean termNaturalNumber = isTermNaturalNumber(termNode);

  Boolean termIndeterminate = isTermIndeterminate(termNode, indeterminateTermNode);
  
  Boolean termExponential = isTermExponential(termNode, indeterminateTermNode);
  
  Boolean termCompound = isTermCompound(termNode, indeterminateTermNode);

  Boolean termIntegerMonomial = (termNaturalNumber || termIndeterminate || termExponential || termCompound);

  return termIntegerMonomial;
}

Boolean isTermCompound(Node termNode, Node indeterminateTermNode) {
  { List<Node> childNodes } = termNode;

  Boolean termCompound = apply(childNodes, [
    isArgumentTermNaturalNumber,
    isNoWhitespace,
    isArgumentTermIndeterminateOrExponential
  ], indeterminateTermNode);

  return termCompound;
}

Boolean isTermExponential(Node termNode, Node indeterminateTermNode) {
  { List<Node> childNodes } = termNode;

  Boolean termExponential = apply(childNodes, [
    isArgumentTermIndeterminate, 
    isNoWhitespace, 
    isCaret, 
    isNoWhitespace, 
    isArgumentTermNaturalNumber
  ], indeterminateTermNode);

  return termExponential;
}

Boolean isTermIndeterminate(Node termNode, Node indeterminateTermNode) {
  Boolean indeterminate = (termNode == indeterminateTermNode);  

  return indeterminate;
}

Boolean isTermIndeterminateOrExponential(Node termNode, Node indeterminateTermNode) {
  Boolean termExponential = isTermExponential(termNode, indeterminateTermNode);

  Boolean termIndeterminate = isTermIndeterminate(termNode, indeterminateTermNode);

  Boolean termIndeterminateOrExponential = (termExponential || termIndeterminate);

  return termIndeterminateOrExponential;
}

export Boolean isArgumentTermNaturalNumber(Node argumentNode, Node indeterminateTermNode) {
  Node termNode = nodeQuery(argumentNode, "/argument/term!");

  Boolean argumentTermNaturalNumber = 

    if (termNode != null) {
      Boolean termNaturalNumber = isTermNaturalNumber(termNode);

      return termNaturalNumber;
    }

    else
      false
  ;

  return argumentTermNaturalNumber;
}

Boolean isArgumentTermIndeterminate(Node argumentNode, Node indeterminateTermNode) {
  Node termNode = nodeQuery(argumentNode, "/argument/term!");

  Boolean isArgumentTermIndeterminate = 

    if (termNode != null) {
      Boolean termIndeterminate = isTermIndeterminate(termNode, indeterminateTermNode);

      return termIndeterminate;
    }

    else
      false
  ;

  return isArgumentTermIndeterminate;
}

Boolean isArgumentTermIntegerMonomial(Node argumentNode, Node indeterminateTermNode) {
  Node termNode = nodeQuery(argumentNode, "/argument/term!");

  Boolean argumentTermIntegerMonomial = 

    if (termNode != null) {
      Boolean termIntegerMonomial = isTermIntegerMonomial(termNode, indeterminateTermNode);

      return termIntegerMonomial;
    }

    else
      false
  ;

  return argumentTermIntegerMonomial;
}

Boolean isArgumentTermIntegerPolynomial(Node argumentNode, Node indeterminateTermNode) {
  Node termNode = nodeQuery(argumentNode, "/argument/term!");

  Boolean argumentTermIntegerPolynomial = 

    if (termNode != null) {
      Boolean termIntegerPolynomial = isTermIntegerPolynomial(termNode, indeterminateTermNode);

      return termIntegerPolynomial;
    }

    else
      false
  ;

  return argumentTermIntegerPolynomial;
}

Boolean isArgumentTermPositiveIntegerPolynomial(Node argumentNode, Node indeterminateTermNode) {
  Node termNode = nodeQuery(argumentNode, "/argument/term!");

  Boolean argumentTermIntegerPolynomial = 

    if (termNode != null) {
      Boolean termPositiveIntegerPolynomial = isTermPositiveIntegerPolynomial(termNode, indeterminateTermNode);

      return termPositiveIntegerPolynomial;
    }

    else
      false
  ;

  return argumentTermIntegerPolynomial;
}

Boolean isArgumentTermIndeterminateOrExponential(Node argumentNode, Node indeterminateTermNode) {
  Node termNode = nodeQuery(argumentNode, "/argument/term!");

  Boolean argumentTermIndeterminateOrExponential = 

    if (termNode != null) {
      Boolean termIndeterminateOrExponential = isTermIndeterminateOrExponential(termNode, indeterminateTermNode);

      return termIndeterminateOrExponential;
    }

    else
      false
  ;

  return argumentTermIndeterminateOrExponential;
}

Boolean isCaret(Node node, Node indeterminateTermNode) {
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

Boolean isMinus(Node node, Node indeterminateTermNode) {
  { Boolean terminal } = node;

  Boolean minus = 

    if (terminal) {
      Node terminalNode = node;

      { String content } = terminalNode;

      Boolean minus = (content == "-");

      return minus;
    }
    else
      false

  ;

  return minus;
}

Boolean isBacktick(Node node, Node indeterminateTermNode) {
  { Boolean terminal } = node;

  Boolean backtick = 

    if (terminal) {
      Node terminalNode = node;

      { String type } = terminalNode;

      Boolean backtick = (type == "backtick");

      return backtick;
    }
    else
      false

  ;

  return backtick;
}

Boolean isPlusOrMinus(Node node, Node indeterminateTermNode) {
  { Boolean terminal } = node;

  Boolean plusOrMinus = 

    if (terminal) {
      Node terminalNode = node;

      { String content } = terminalNode;

      Boolean plusOrMinus = ((content == "+") || (content == "-"));

      return plusOrMinus;
    }
    else
      false

  ;

  return plusOrMinus;
}

Boolean isNoWhitespace(Node node, Node indeterminateTermNode) {
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
