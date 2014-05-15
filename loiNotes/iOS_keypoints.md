<br/>Delegation
<br/>Apple uses the delegation pattern
<br/>
<br/>Protocols
<br/>For every object that can have a delegate, 
there is a corresponding protocol that declares the messages that the object can send its delegate.
<br/>The delegate implements methods from the protocol for events its is interested in.
<br/>When a class implements methods from a protocol, it is said to conform to the protocol.
<br/>
<br/>JSON data
<br/>JSON can contain the most basic objects we use to represent model objects:
<br/>arrays, dictionaries, strings, and numbers.
<br/>
<br/>A dictionary contains one or more key-value pairs, where the value can be another
<br/>dictionary, string, number, or array.
<br/>An array can consist of strings, numbers, dictionaries, and other arrays.
<br/>Thus, a JSON document is a nested set of these types of values.
<br/>
<br/>A JSON dictionary is delimited with curly braces ({ and }).
<br/>Within curly braces are the key-value pairs that belong to that dictionary.
<br/>A sting is represented by using text within quotations.
<br/>Arrays are represented with square brackets([ and ]).
<br/>
<br/>Parsing JSON data
<br/>NSJSONSerialization and the basic foundation objects
<br/>it will create instances of NSDictionary, NSArray, NSString, NSNumber