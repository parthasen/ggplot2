ScaleIdentity <- proto(ScaleDiscrete, {  
  doc <- TRUE
  common <- c("colour","fill","size","shape","linetype")
  new <- function(., name=NULL, breaks=NULL, labels=NULL, formatter = NULL, variable="x") {
    .$proto(name=name, breaks=breaks, .labels=labels, .input=variable, .output=variable, formatter = formatter)
  }

  train <- function(., data, drop = FALSE) {
    .$breaks <- union(.$breaks, unique(data))
  }
  trained <- function(.) !is.null(.$.labels)  

  map_df <- function(., data) {
    if (!all(.$input() %in% names(data))) return(data.frame())
    data[, .$input(), drop=FALSE]
  }
  output_breaks <- function(.) .$breaks
  labels <- function(.) .$.labels

  # Documentation -----------------------------------------------

  objname <- "identity"
  desc <- "Use values without scaling"
  icon <- function(.) textGrob("f(x) = x", gp=gpar(cex=1.2))
  
  examples <- function(.) {
    colour <- c("red", "green", "blue", "yellow")
    qplot(1:4, 1:4, fill = colour, geom = "tile")
    qplot(1:4, 1:4, fill = colour, geom = "tile") + scale_fill_identity()
    
    # To get a legend, you also need to supply the labels to
    # be used on the legend
    qplot(1:4, 1:4, fill = colour, geom = "tile") +
      scale_fill_identity(labels = letters[1:4], name = "trt")
    
    # cyl scaled to appropriate size
    qplot(mpg, wt, data = mtcars, size = cyl)

    # cyl used as point size
    qplot(mpg, wt, data = mtcars, size = cyl) + scale_size_identity()
  
  }
  
})
