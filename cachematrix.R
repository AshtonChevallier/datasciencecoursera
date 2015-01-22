## The pair of functions is designed to cache the inverse of a matrix and pull that cached
## data rather than resolve.

## Here we make a special vector of functions to allow matrix solve to cache answers.

makeCacheMatrix <- function(x = matrix()) {
    
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setInverse <- function(solve) m <<- solve
    getInverse <- function() m
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}

## Check to see if the answer is cached, if so, pull from cache, if not, resolve matrix.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    
        m <- x$getInverse()
        if(!is.null(m)) {
            message("getting cached data")
            return(m)
        }
        data <- x$get()
        m <- solve(data, ...)
        x$setInverse(m)
        m
}
