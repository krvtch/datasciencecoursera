makeCacheMatrix <- function(x = matrix()) {
        # x = an invertible square matrix
        # Returns a list that contains functions that can:
        # 1. set the matrix
        # 2. get the matrix
        # 3. set the inverse
        # 4. get the inverse
        # and is used as input to cacheSolve()
        
        inv = NULL
        set = function(y) {
                # <<- is used to assign a value to an object in an environment that is different from the current environment 
                x <<- y
                inv <<- NULL
        }
        get = function() x
        setinv = function(inverse) inv <<- inverse 
        getinv = function() inv
        list(set=set, get=get, setinv=setinv, getinv=getinv)
}
