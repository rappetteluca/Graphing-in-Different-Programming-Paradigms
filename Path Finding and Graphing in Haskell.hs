--Definitions
type Node = Integer
type Edge = (Integer, Integer)
type Graph = [Edge]
type Path = [Node]

g :: Graph
g = [(1,2), (1,3), (2,3), (2,4), (3,4)]

h :: Graph
h = [(1,2), (1,3), (2,1), (3,2), (4,4)]
--Functions
nodes :: Graph -> [Integer]
nodes [] = []
nodes ls = (makeUnique (flatten ls))

neighbors :: Node -> Graph -> [Node]
neighbors _ [] = []
neighbors n g = (makeUnique (edgesToNeighbors (nodeEdgesFrom n g)))

detach :: Node -> Graph -> Graph
detach _ [] = []
detach n (e:es) | (isEdgeFrom n e) || (isEdgeTo n e) = detach n es | otherwise = e : detach n es

paths :: Node -> Node -> Graph -> [Path]
paths _ _ [] = []
paths s t g | (s == t) = [[s]] | otherwise = getAllPaths s t g []

--Helpers
newEdge :: Integer -> Integer -> Edge
newEdge from to = (from, to)

edgeGetSource :: Edge -> Node
edgeGetSource e = fst e

edgeGetDest :: Edge -> Node
edgeGetDest e = snd e

newGraph :: [(Integer, Integer)] -> [Edge]
newGraph [] = []
newGraph (x:xs) = (newEdge (fst x) (snd x)):newGraph xs

makeUnique :: [Integer] -> [Integer]
makeUnique ls = (makeUniqueHelper ls [])
--Could also use 'filter' instead of a helper
makeUniqueHelper :: [Integer] -> [Integer] -> [Integer]
makeUniqueHelper [] _ = []
makeUniqueHelper (x:xs) seen | (elem x seen) = makeUniqueHelper xs seen | otherwise = x : makeUniqueHelper xs (x:seen)

flatten :: [(Integer, Integer)] -> [Integer]
flatten [] = []
flatten (x:xs) = (fst x) : (snd x) : flatten xs

nodeCount :: Graph -> Int
nodeCount [] = 0
nodeCount g = length (nodes g)

edgesToNeighbors :: [Edge] -> [Node]
edgesToNeighbors [] = []
--edgesToNeighbors n (e:es) | (n == (fst e)) = (snd e) : edgesToNeighbors n es | otherwise = edgesToNeighbors n es
edgesToNeighbors (x:xs) = (edgeGetDest x) : edgesToNeighbors xs

isEdgeFrom :: (Eq a) => a -> (a,a) -> Bool
isEdgeFrom n e |(fst e) == n = True | otherwise = False

isEdgeTo :: (Eq a) => a -> (a,a) -> Bool
isEdgeTo n e |(snd e) == n = True | otherwise = False

nodeEdgesFrom :: Node -> Graph -> [Edge]
nodeEdgesFrom _ [] = []
nodeEdgesFrom n g = filter (isEdgeFrom n) g

nodeEdgesTo :: Node -> Graph -> [Edge]
nodeEdgesTo _ [] = []
nodeEdgesTo n g = filter (isEdgeTo n) g

nodeEdges :: Node -> Graph -> [Edge]
nodeEdges _ [] = []
nodeEdges n g = (nodeEdgesFrom n g) ++ (nodeEdgesTo n g)

t :: [Path]
t = (concat [[[1,2,3,4], f], [[1,3,4], [1,3,5,4]]])

f :: Path
f = (concat [[1,2], [4]])

q :: Path
q = (concat [[1], [2]])

getAllPaths :: Node -> Node -> Graph -> [Edge] -> [Path]
getAllPaths _ _ [] _ = []
getAllPaths s t g his | (s == t) = [(edgeGetSource (head his)):(edgesToNeighbors his)] | otherwise = (concatMap (enumerateEdgePath s t g his) x) where x = (nodeEdgesFrom s g)

enumerateEdgePath :: Node -> Node -> Graph -> [Edge] -> Edge -> [Path]
enumerateEdgePath s t g his act | (elem act his) = [] | otherwise = (getAllPaths (edgeGetDest act) t g (his ++ act:[]))

--Utility Functions 
--Note: Prelude gives you fst and snd, but the syntax is below (in synonym form) anyways
fstNode :: (Node,Node) -> Node
fstNode (x,_) = x

sndNode :: (Node,Node) ->  Node
sndNode (_,y) = y

sort :: [Integer] -> [Integer]
sort [] = []
sort (x:xs) = sort [y|y<-xs,y<x]++[x]++ sort [y|y<-xs,y>=x]