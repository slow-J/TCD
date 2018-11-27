{- slowinsj Jakub Slowinski -}
module Ex02 where
-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !


-- a binary tree datatype
data Tree k d
  = Br (Tree k d) (Tree k d) k d
  | Leaf k d
  | Nil
  deriving (Eq, Show)

type IntFun = Tree Int Int -- binary tree with integer keys and data

data Expr
  = Val Double
  | Var String
  | Add Expr Expr
  | Mul Expr Expr
  | Sub Expr Expr
  | Abs Expr
  | Sign Expr
   deriving (Eq, Show)



-- Part 1 : Tree Insert -------------------------------

-- Implement:
ins :: Ord k => k -> d -> Tree k d -> Tree k d
ins k d Nil = Leaf k d
ins k d (Leaf k2 d2) -- leaf
    | k == k2 = Leaf k d 
    | k < k2  = Br (Leaf k d) Nil k2 d2 -- go left
    | k > k2  = Br Nil (Leaf k d) k2 d2 -- go right

ins k d (Br left right k2 d2)  -- branch
    | k == k2 = Br left right k d 
    | k < k2  = Br (ins k d left) right k2 d2 -- recursive call left
    | k > k2 = Br left (ins k d right) k2 d2 -- recursive call right 



-- Part 2 : Tree Lookup -------------------------------

-- Implement:
lkp :: (Monad m, Ord k) => Tree k d -> k -> m d

lkp Nil _ = fail "empty"

lkp (Leaf k d) lkpKey -- leaf
    | lkpKey == k = return d -- return the data
    | otherwise   = fail "key doesn't match" -- Fail lookup

lkp (Br left right k d) lkpKey -- br
    | lkpKey == k = return d         -- Return data
    | lkpKey < k  = lkp left lkpKey  -- Search left subtree
    | lkpKey > k = lkp right lkpKey -- Search right subtree

--lkp _ _ = error "lkp NYI"

-- Part 3 : Instance of Num for Expr

{-
  Fix the following instance for Num of Expr so all tests pass

  Note that the tests expect simplification to be done
  only when *all* Expr arguments are of the form Val v

  Hint 1 :  implementing fromInteger *first* is recommended!
  Hint 2 :  remember that Double is already an instance of Num
-}


     
instance Num Expr where
  (Val e1) + (Val e2) = Val (e1+e2)
  e1 + e2 = Add e1 e2
  
  (Val e1) - (Val e2) = Val (e1-e2)
  e1 - e2 = Sub e1 e2
  
  (Val e1) * (Val e2) = Val (e1*e2)
  e1 * e2 = Mul e1 e2
  
  negate (Val e) = Val (0-e)
  negate e = Sub 0 e
  
  abs (Val e) | e >= 0    = Val e
              | otherwise = Val(-e)
  abs e = Abs e
  
  signum (Val e) | e == 0    = Val (0.0)
                 | e > 0     = Val (1.0)
                 | otherwise = Val (-1.0)
                 
  signum e = Sign e
  
  fromInteger i = Val $ fromIntegral i
