install_BiocManager <- function(){
  if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager"){
    BiocManager::install(version = "3.12")
  }
}
#install_BiocManager()
library(rhdf5)
##creando grupos en el archivo
file <- h5createFile("example.h5")
file <- h5createGroup("example.h5", "foo")
file <- h5createGroup("example.h5", "baa")
file <- h5createGroup("example.h5", "foo/foobaa")

##Reading h5file content
h5ls("example.h5")
## Writing data by group
A <- matrix(1:10, nr=5, nc = 2)
h5write(A,"example.h5", "foo/A")
B <- array(seq(.1, 2., by = .1), dim =c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B,"example.h5","foo/foobaa/B")

## reading saved data
A <- h5read("example.h5", "foo/A")
