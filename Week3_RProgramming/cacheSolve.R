cacheSolve <- function(x, ...) {
        # x = output from makeCacheMatrix()
        # Computes the inverse of the special "matrix" returned by makeCacheMatrix
        
        inv = x$getinv()
        
        if (!is.null(inv)){
                # retrieve from the cache, skip calculation 
                message("getting cached data")
                return(inv)
        }
        
        mat.data = x$get()
        inv = solve(mat.data, ...)
        x$setinv(inv)
        return(inv)
}
