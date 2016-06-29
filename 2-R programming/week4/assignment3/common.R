readfile <- function(fname="outcome-of-care-measures.csv"){
    outcome <- read.csv(fname, colClasses = "character")
    return(outcome)
}