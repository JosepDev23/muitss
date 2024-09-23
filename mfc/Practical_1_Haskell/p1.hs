module P1 where

import Data.Char (ord, chr)

-- 3. Ejercicios para resolver sobre tipos basicos

-- Ejercicio 1
siguienteLetra :: Char -> Char
siguienteLetra c 
    | c == 'z' = 'a'
    | c == 'Z' = 'A'
    | otherwise = chr (ord c + 1)

--Ejercicio 2
sumatorio :: Int -> Int -> Int
sumatorio x y
    | x == y = x
    | x < y = x + sumatorio (x+1) y
    | x > y = x + sumatorio (x-1) y

-- Ejercicio 3
productorio :: Int -> Int -> Int
productorio x y
    | x == y = x
    | x < y = x * productorio (x+1) y
    | x > y = y * productorio x (y+1)

-- Ejercicio 4
maximo :: Int -> Int -> Int
maximo x y
    | x < y = y
    | otherwise = x

-- Ejercicio 5
factorial :: Int -> Int
factorial x
    | x == 0 = 1
    | otherwise = x * factorial (x-1)

-- Ejercicio 6
sumFacts :: Int -> Int
sumFacts x
    | x == 0 = 1
    | otherwise = (factorial x) + (sumFacts (x-1))





-- Ejercicios a resolver sobre tipos listas

-- Ejercicio 1
sumaTuplas :: [(Int, Int)] -> [Int]
sumaTuplas = map (\(x, y) -> x + y)

-- Ejercicio 2
primerElemento :: [a] -> a
primerElemento (x:xs) = x

ultimoElemento :: [a] -> a
ultimoElemento x = last x

-- Ejercicio 3
divisores :: Int -> [Int]
divisores n = [x | x <- [1..n], (mod n x) == 0]

-- Ejercicio 4
enteroPerteneceLista :: Int -> [Int] -> Bool
enteroPerteneceLista x y
    | y == [] = False
enteroPerteneceLista x (y:ys)
    | x == y = True
    | otherwise = enteroPerteneceLista x ys

-- Ejercicio 5 
reemplazar :: Eq a => a -> a -> [a] -> [a]
reemplazar _ _ [] = []
reemplazar n p (x:xs)
    | x == n = p : reemplazar n p xs
    | otherwise = x : reemplazar n p xs

-- Ejercicio 6
contarOcurrencias :: Eq a => a -> [a] -> Int
contarOcurrencias _ [] = 0 
contarOcurrencias n (x:xs)
    | x == n  = 1 + contarOcurrencias n xs 
    | otherwise = contarOcurrencias n xs 

-- Ejercicio 7
multiplosDe5ListasIntensionales :: [Int] -> [Int]
multiplosDe5ListasIntensionales xs = [x | x <- xs, x `mod` 5 == 0]

multiplosDe5OrdenSuperior :: [Int] -> [Int]
multiplosDe5OrdenSuperior xs = filter (\x -> x `mod` 5 == 0) xs

-- Ejercicio 8
extraerMayusculas :: String -> String
extraerMayusculas xs = [x | x <- xs, x `elem` ['A'..'Z']]
