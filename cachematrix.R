## These functions save on costly computation by casheing the inverse of a matrix.

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {

        inv <- NULL
        set <- function(y) {
                # use `<<-` to assign a value to an object in an environment 
                # different from the current environment. 
                x <<- y
                inv <<- NULL
        }
        get = function() x
        setinv = function(inverse) inv <<- inverse 
        getinv = function() inv
        list(set=set, get=get, setinv=setinv, getinv=getinv)
}


## Function will return inverse of the original matrix input to makeCacheMatrix()

cacheSolve <- function(x, ...) {

        inv <- x$getinv()
        
        if (!is.null(inv)){
                message("getting cached data")
                return(inv)
        }
        
        # if not already calc'd and cashed, calculate the inverse 
        data <- x$get()
        inv <- solve(data, ...)
        
        # set value of the inverse in the cache 
        x$setinv(inv)
        
        return(inv)
}
