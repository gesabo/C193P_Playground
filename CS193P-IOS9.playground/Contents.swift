
/*: Swift Notes
 
 # Standford CS193P iOS9

 ## Optionals
 */
/*: Optionals can be "chained" */

import UIKit
import Foundation

var display: UILabel?

//Long way
if let label = display {
    if let text = label.text {
        let x = text.hashValue
    }
}

//Using Optional Chaining
// "try and unwrap this, if you can go to the next value and unwrap it, if you can't just return nil"
if let x = display?.text?.hashValue { print("much easier") }

/*:  The Optional "Defaulting" operator ?? */

//long way
let s: String? = "" //might be nil
if s != nil {
    display?.text = s
} else {
    display?.text = " " //space here to preserve height
}

//betterway
//display.text = s ?? " " //if s is not nil, unwrap it and use that value, otherwise use " " space

/*: # Tuples */

let myTuple: (String, Int, Double) = ("Hello", 5, 0.85)
let (word, number, value) = myTuple // tuple elements named when accessing the tuple
print(word)
print(number)

//or can write
let myOtherTuple: (w: String, i: Int, v: Double) = ("Hello", 5, 0.85)
print(myOtherTuple.w)
print(myOtherTuple.i)

/*:  Tuples can be used to return multiple values */
func getSize() -> (weight: Double, height: Double) { return (250,80) }
let x = getSize()
print("weight is \(x.weight) height is \(x.height)")

//: =========================

/*:  # Range */

let array = ["a", "b", "c", "d"]
let subArray1 = array[2...3]
let subArray2 = array[2..<3] //does not include "c"
for i in 27...30 { print("\(i)") } //rance is enumeratable like Array, String, Dictionary

/*:  # Data Structures: Class Struct & Enum */

/*:
 
 Clases are reference types and have inheritance, Structs and Enums are value types and no inheritance
 
 *Immutability*
 if a reference type (struct or enum) is assigned to a variable via let, it is immutable.  So if I say let x = myStruct, I can't append to x.
 
 Also, function parameters are constants (implicit let), so by default they cannot be mutated, if you want them to be, must mark ala *mutating func* (this is a under the hood performance enhancement, since when you say x = myStruct, Swift doesn't actually want to make a copy everytime, it only wants to make a copy when it's needed, so when you mark a func as mutating (i.e. that the function should be able to mutate that struct, you're telling Swift to make the copy now)
 
 
 
 ## When to use Class vs. Struct? 
 
 Structs for fundamental values like strings, ints, arrays, dictionaries, points for drawing, Classes for anything else (anything big)
 
 */

/*:  # Methods */

/*: 
 
 ## Parameter Names
 
 All parameters to all functions have an *internal* name and an *external* name.  **The internal name is the name of the local var you use inside the method, the external name is what callers use when they call the method**
 
 You can use _ if you don't want callers to use an external name for a given parameter.  This is Swift's default for the first parameter! For all others the internal name is, by default, the external name.
 */

func foo(first: Int, externalSecond second: Double) {  //removed externalFirst
    var sum = 0.0
    for _ in 0..<first { sum += second }
}

func bar() {
    let result = foo(first: 123, externalSecond: 5.5)
}

/*: 
 override methods, or a method can be marked *final* so it can't be overridden by its subclass 
 Can also mark entire class final, so the entire class is not subclassable (I think Apple has done this) 
 
 ## Instances AND Types can have methods and properties
 Usually we're using instances, but see below:
 
 */

var d: Double = 5.5
if d.sign == .minus {
    d = Double.abs(d) //this is calling abs (absolute value) on the Class Double that Apple wrote
    //so in Apple's class Double { } they wrote a method called: static func abs(d: Double) -> Double ("static" meaning it's a "type method" not an "instance method")
    
}

/*:  # Properties
 
 ## Property Observers
 
 Let you observe changes to any property with willSet and didSet.  Constrast from get and set in a computed property, here willSet and didSet is just code that is going to get called whenever this property gets set.
 Will also be invoked if you mutate a struct (e.g. add something to a dictionary), but not for reference types (Classes)
 
 ```
 var someStoredProperty: Int = 42 {
    willSet { newValue is the new value }
    didSet {oldValue is the old value}
 }
 
 override var inheritedProperty {
    willSet { newValue is the new value } 
    didSet { oldValue is the old value }
 ```
 
 ### very commonly we use to update UI: 
 
 
 
 ```
    var operations: Dictionary<String>, Operation> = [ ... ] {
    willSet { will be executed if an operation is added/removed } update UI here
    didSet { will be executed if an operation is added/removed }
 
 ```
 
 
 ## Lazy Initialzation
 Cheat code of swift.  A lazy property does not get initialized until someone *accesses* it.
 
```
lazy var brain = CalculatorBrain() //nice if calculator brian uses lots of resources

lazy var someProperty: Type = {
    construct the value of someProperty here
    return <the constructed value>
}()
 
 lazy var myProperty = self.initializeMyProperty() //normally would be illegal to access self here, because you can't access your properties until you're initilized.  Catch 22
```
 
 lazy always must be vars, no lazy let 
 
 can be used to not need an init right now
 
 # Array
 
 ```
 var a = Array<String>() 
 ```
 is the same as 
 ```
 var a = [String]() 
 ```
 
 The () means I'm calling an initializer with no arguments.
 
 enumerating an array: 
 ```
 for animal in animals {
 }
 ```
 ## filter
 Takes a closure (that will return a bool) you pass in (like $0 > 20) and performs that closure on an array, and only returns the true cases:
 
 */
let bigNumbers = [2,47,118,5,9].filter({$0 > 20}) //do not need these parenthesis here, see map
bigNumbers

/*: 
 
 ## map
 Takes a closure (that converts each element in array to something else, like an array of ints to array of string) and returns the transformed array
 
 
 */

let stringified: [String] = [1,2,3].map {String($0)} //no parenthesis, because they are optional when closure is last argument to a function -"trailing closure syntax"
stringified

/*: 
 ## reduce 
 reduces an entire array to a single value
 */
let sum: Int = [1,2,3].reduce(0) { $0 + $1 } //the first arugment is the index of the array you want to start with
sum

/*: 
 
  # Dictionary
 
*/

var pac10TeamRankings = Dictionary<String, Int>()
//same as 
var pack10TeamRankings = [String:Int]()
pack10TeamRankings = ["Stanford":1, "Cal":10]

/*: 
 use a tuple with for-in to enumerate a Dictionary 
 
 */

// could use _ if only wanted the values
for (key, value) in pack10TeamRankings {
    print("\(key) = \(value)")
}

/*:
 
 # String
 
 */


/*:
 
 # Initilization
 
 Most of time we don't need inits because of (1) properties can have defaults set using = (2) optionals, which then start out as nil (3) lazy vars (4) initiliazation by executing a closure 
 
 Only need an init when can't do any of these. 
 
 You also get "free" init methods: 
 (1) if all properties in a base class (no superclass) have defaults you get init() for free
 (2) If a struct has no initializers, it will get a default one iwth all properties as arguments
 
 ```
 var someString = String() //the () is calling an empty init method! 
 
 ```
 
 But as soon as you add your own init for your struct, you loose the "free" ones
 
 ## Init Rules
 
 What can you do inside an init? 
 
 (1) you can set any properties value, even those with default values
 (2) Constant properties (i.e. properties declared with let) can we set
 (3) YOu can call other init methods in your own class using self.init(<args>) 
 (4) In a class you can call super.init(<args>)
 (5) But there are rules for calling inits from inits in a class: 

 What are you **required** to do inside an init?
 
 (1) By the time any init is done, all properties must have values (optionals can have the value nil) 
 (2) You must initialize all properties *introduced by your class* before calling a superclass's init
 (3) You must call a superclass's init before you assign a value to an inhereited property (i.e. you do yours, call super, now you can touch theirs)
 (4) Calling of other inits must be completed before you can access properties or invoke methods (accessing self)
 (5) there are 2 types of inits in a class
 

 
 **convenience**  (I have a default for some of the arguments, but this is for convenience)
        -must (and can only) call an init in its own class (i.e. cannot call super) 
        -must call that init before it can set any property values (i.e. you must let a designated initializer init your own properties first)
 
**designated** (i.e. not marked "convenience")
        -must (and can only) call a designated init thats in its immediate superclass
 
 Inheriting init    
 
(1) If you don't implement any designated inits, you'll in herit all of your superclass's designated
(2) If you ovveride all of your superclass's designated inits, you'll inhereit all its convenience inits
(3) If you implement no inits, you''l inhereit all of your superclass's inits
(4) Any init inhereited by these rules qualifies to satisfy any of the rules above
 
 Required init
 
(1) A class can mark one or more of it's init methods as required (meaning a subclass must implement (or inherit) this init) e.g. UIView has a required init.
 
 Failable initailzers
 
If an init is declared with a ? (or !) after the word init, it returns an Optional
 
 
```
    init?(arg1: Type1, ...) {
        // might return nil in here
    }
```
 
 These are rare
 
 ```
 let image = UIImage(named: "foo") // image is an OptionalUIImage (i.e. UIImage?) (
 
 ```
 usually we would use if-let for these cases...
 
 Creating Objects
 
 
 ## AnyObject
    -special type (actually protocol)
    used for compatibility with old Objective-C APIs (meant "pointer to object of unknown class" see it in prepareForSegue)
    Swift is strongly typed so no such thing
 
 ```
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject) //sender is the object that originated the transition, can be button, row in table, custom code in controller etc. so has to be AnyObject
    func touchDigiet(sender: AnyObject) //can be sent by button or slider
 ```
 
 or when you want ot return an object and you don't want the caller to know it's class ...

 We have to cast it using as? (optional because it might not be convertable) 
 
 ```
  let ao: AnyObject = ...
    if let foo = ao as? SomeClass {
    // we can use foo and know that it is of type SomeClass in here
    }
 ```
 
 for example if you wire up an action in storyboard and left as AnyObject instead of changing to UIBUtton, we'd have to cast the sender as AnyObject to UIButton
 
 ```
 @IBACtion func touchDigit(sender: AnyObject) {
    if let sendingButton = sender as? UIButton {
        let digit = sendingButton.currentTitle!
    }
 }
 ```
 
 ## Property List

 Another use of AnyObject
 
p lists is just the definition of a term
 
It means an AnyObject which is known to be a collection of objects which are ONLY one of String, Array, Dictionary, Double, Int, NSData, NSDATA
 
Even though in Swift these Types are structs and not classes, they are "briged" to Obj-C
 
Example of P-List: NSUserDefaults
-NSUD = a tiny database that stores P List data
 
calling .Synchronize forced them to save to disk (even though they are auto saved)
 
 ## Assertions
Intentionally crash your program if some condition is not true (and give a message)
```
     assert(() -> Bool, "message")  //The function argument is an "autoclosure" however, so you don't need the { }
```
 
 */
 
 














