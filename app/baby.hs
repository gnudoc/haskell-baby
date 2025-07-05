doubleMe :: Int -> Int
doubleMe x = x + x
doubleUs :: Int -> Int -> Int
doubleUs x y = doubleMe (x + y)

quadrupleSmallNumber :: Int -> Int
quadrupleSmallNumber x = doubleMe (if x > 100 then x else doubleMe x)
-- ^ if statements MUST have else
-- if statements are expressions like any other

conanO'Brien :: String
conanO'Brien = "Hi! I'm Conan!"
-- ^ function names start with lowercase
-- they can contain '
-- a function with no parameters is a "name" or "definition"
-- functions are immutable


----------------------
--LISTS--AND--TUPLES--
----------------------

-- lists are homogenous - all the same type of items
somePrimes :: [Int]
somePrimes = [2,3,5,7,11]

-- strings are lists of characters
-- list concatenation is ++
-- it requires walking the entire first list then appending the second list

longerString :: String -> String -> String
longerString x y = x ++ y

-- prepend a single item to the start of a list w :
-- this is instantaneous

prependedItem a b = a:b

{- so "string" is syntactic sugar for ['s','t','r','i','n','g']
 - which is syntactic sugar for 's':'t':'r':'i':'n':'g':[]
 - (remember the empty list)
 -}

getNthItem list n = list !! n -- 0 indexed

-- in nested lists, all the items have to be the same type
-- so [[1,2,3],[4,5,6],[',']] is illegal

-- compare lists lexicographically with >, <=, == etc
maxList x y = if x >= y then x else y

-- head x and tail x of a list are as expected
-- last x is last item, init x is all but last item
-- these four give a RUNTIME error if used w empty list

-- length x returns the length of a list
-- null x returns a bool
-- reverse x reverses a list
-- take x y returns a list of the x items at the start of list y
-- drop x y returns the list without the x items at the start

-- minimum x and maximum x can be used on lists of comparable items
-- sum x returns the sum of a list of numbers
-- product x works similarly
-- x `elem` y checks if x is an element of y

-- RANGES --
-- [n..m] is the same as [n, n+1, ... ,m-1, m] for int n and int m
-- if n is a float but m is an int then we stop before m but it's still n+1, n+2 etc
-- if m is a float then it gets rounded to the nearest n + int
-- e.g [1.1..4.9] == [1.1,2.1,3.1,4.1,5.1]
-- e.g [1.1..4.5] == [1.1,2.1,3.1,4.1]
-- e.g ['A'..'d'] == "ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcd"
-- N.B. we can also specify the first two terms of an arithmetic sequence where a!=1
-- e.g [3, 7..20] == [3,7,11,15,19] and [2,4..20] for the even naturals <= 20
-- or [20,19..1] for the naturals from 20 to 1 in descending order.
-- or [0,2..] for all even numbers (but watch out for trying to evaluate this on the repl!)
-- another way to do this sort of cleverness (and much more) is list comprehension.

-- cycle will repeat a finite list infinitely
-- repeat will give an infinite listing repeating a single element
-- and replicate m n will give a list of the element n repeated m times

-- LIST COMPREHENSION --
evensUnder20 = [x*2 | x <- [1..10]] -- vaguely reminiscent of java lambda syntax...
evensUnder20DivisibleBy5 = [x*2 | x <- [1..10], x*2 `mod` 5 == 0]
anotherOne = [x | x <- [50..150], x `mod` 7 == 3] -- predicate is the bit after ,
-- we can have multiple predicates
-- e.g. A first attempt at sieving primes
primesUnder200 = [x | x <- [2..200], odd x,
                                   x==3 || x`mod`3/=0,
                                   x==5 || x`mod`5/=0,
                                   x==7 || x`mod`7/=0,
                                   x==11 || x`mod`11/=0,
                                   x==13 || x`mod`13/=0]
-- not the actual fizz-buzz problem - just demonstrates using a function parameter
fizzBuzz xx = [if x `mod` 3 == 0 then "fizz" else "buzz" | x <- xx, odd x]

-- TUPLES --
-- tuple types include their length and the types of their elements
-- and they're not necessarily homogenous
-- so you can't have a list of a (string, integer) and a pair of (integer, string)
-- or a pair and a triple.

---------
--TYPES--
---------

-- staticly typed
-- every expression has a type, including functions
-- type inference works
-- type names have Capitals
-- :: == "has a type of" - both in our type declarations and in repl/compiler messages
-- function type declarations:
---- myFunction :: Int -> Int -> Bool -- notice no separation of parameters and return
---- myFunction x y = if x == y then True else False

-- Int is a 32 or 64 bit signed integer (so fast, but overflow bugs)
-- Integer is of arbitrary precision
-- Floats are single-precision, Doubles are double-precision

-- Type variables - like generics (from other langs) with additional power
-- written with lowercase e.g. the repl will report that:
-- :t head
-- head :: [a] -> a
-- :t fst
-- fst :: (a, b) -> a

-- typeclasses - like interfaces in java, for polymorphism
-- :t elem
-- elem :: (Foldable t, Eq a) => a -> t a -> Bool
---  elem takes an a and a container t holding more a's and returns a Bool.
---  The t has to be Foldable (ie traversible)
---  The a has to be Eq-able (ie comparable for equality)
-- NB Eq is a different comparability vs Ord (which is required for funcs like (>)

-- sometimes, a function will return a type from a typeclass, but more info is needed
-- to work out which *particular* type - either by inference or by a type annotation
-- (because remember we have to know at compile time! dynamic typing is not an option!)
--   eg read :: (Read a) => String -> a - takes a string version of some other type,
--   like "7" or "15.2" or "True" and knows to return a Read-able type, but which one?
--   if we do `read "7" + 3.2` it'll infer a Float but `read "7" + 3` infers an Int
--   we can do type annotation -  `read "7" :: Float` -  if inference not possible


--------------------
--PATTERN MATCHING--
--------------------

-- switch/if-elif-else constructs are not needed - just define the function for each case
-- eg:
lucky :: (Integral a) => a -> String
lucky 7 = "DING DING DING! We have a winner!"
lucky x = "Better luck next time!"

-- same idea with recursion - just define the function for the base and recursive cases:
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n-1)

-- more pattern-matching - the tuple parameters' items used directly:
addVectors :: (Num a) => (a,a)->(a,a)->(a,a)
addVectors (x1,y1) (x2,y2) = (x1+x2,y1+y2)
-- ^ I'd instinctively put a comma between the 2 parameter pairs but that's wrong


-- Add this main function at the end (or anywhere) in the file
main :: IO ()
main = do
    putStrLn "Hello from my Haskell baby program!"
    putStrLn $ "Double 5 is: " ++ show (doubleMe 5)
    putStrLn $ "Double 3 and 4 is: " ++ show (doubleUs 3 4)
    putStrLn $ "Conan says: " ++ conanO'Brien
    putStrLn $ "The 3rd item in primes is: " ++ show (getNthItem somePrimes 2)
    putStrLn $ "Is 5 in primes? " ++ show (5 `elem` somePrimes)
