#' GLMNET model penalizing nodes with high degree
#'
#' This function overrides the `trans.fun` options in `network.options` with
#' an heuristic described in Veríssimo et al. that penalizes nodes with high
#' degree.
#'
#' @param xdata input data, can be a matrix or MultiAssayExperiment
#' @param ydata response data compatible with glmnet
#' @param network type of network, see below
#' @param network.options options to calculate network
#' @param ... parameters that glmnet accepts
#'
#' @return see glmNetSparse
#' @export
#'
#' @seealso glmNetSparse
#' @examples
#' xdata <- matrix(rnorm(100), ncol = 5)
#' glmOrphan(xdata, rnorm(nrow(xdata)), 'correlation', family = 'gaussian',
#'           network.options = networkOptions(min.degree = .2))
glmOrphan <- function(xdata, ydata, network,
                      network.options = networkOptions(), ...) {

    network.options$trans.fun <- orphanHeuristic
    glmSparseNet(xdata, ydata, network,
                 network.options = networkOptions(), ...)
}

#' GLMNET model penalizing nodes with small degree
#'
#' This function overrides the `trans.fun` options in `network.options` with
#' an heuristic described in Veríssimo et al. that penalizes nodes with small
#' degree.
#'
#' @param xdata input data, can be a matrix or MultiAssayExperiment
#' @param ydata response data compatible with glmnet
#' @param network type of network, see below
#' @param network.options options to calculate network
#' @param ... parameters that glmnet accepts
#'
#' @return see glmNetSparse
#' @export
#'
#' @seealso glmNetSparse
#' @examples
#' xdata <- matrix(rnorm(100), ncol = 5)
#' glmHub(xdata, rnorm(nrow(xdata)), 'correlation', family = 'gaussian',
#'        network.options = networkOptions(min.degree = .2))
glmHub <- function(xdata, ydata, network,
                   network.options = networkOptions(), ...) {

    network.options$trans.fun <- hubHeuristic
    glmSparseNet(xdata, ydata, network,
                 network.options = network.options, ...)
}

#' GLMNET model penalizing nodes with small degree
#'
#' This function overrides the `trans.fun` options in `network.options` with the
#' inverse of a degree described in Veríssimo et al. (2015) that penalizes
#' nodes with small degree.
#'
#' @param xdata input data, can be a matrix or MultiAssayExperiment
#' @param ydata response data compatible with glmnet
#' @param network type of network, see below
#' @param network.options options to calculate network
#' @param ... parameters that glmnet accepts
#'
#' @return see glmNetSparse
#' @export
#'
#' @seealso glmNetSparse
#' @examples
#' xdata <- matrix(rnorm(100), ncol = 5)
#' glmDegree(xdata, rnorm(nrow(xdata)), 'correlation',
#'           family = 'gaussian',
#'           network.options = networkOptions(min.degree = .2))
glmDegree <- function(xdata, ydata, network,
                      network.options = networkOptions(), ...) {

    network.options$trans.fun <- function(x) { return(1 / x)}
    glmSparseNet(xdata, ydata, network,
                 network.options = network.options, ...)
}

#' GLMNET cross-validation model penalizing nodes with high degree
#'
#' This function overrides the `trans.fun` options in `network.options` with
#' an heuristic described in Veríssimo et al. that penalizes nodes with high
#' degree.
#'
#' @param xdata input data, can be a matrix or MultiAssayExperiment
#' @param ydata response data compatible with glmnet
#' @param network type of network, see below
#' @param network.options options to calculate network
#' @param ... parameters that glmnet accepts
#'
#' @return see cv.glmSparseNet
#' @export
#'
#' @seealso glmNetSparse
#' @examples
#' xdata <- matrix(rnorm(100), ncol = 5)
#' cv.glmOrphan(xdata, rnorm(nrow(xdata)), 'correlation',
#'              family = 'gaussian',
#'              nfolds = 5,
#'              network.options = networkOptions(min.degree = .2))
cv.glmOrphan <- function(xdata, ydata, network,
                         network.options = networkOptions(), ...) {

    network.options$trans.fun <- orphanHeuristic
    cv.glmSparseNet(xdata, ydata, network,
                    network.options = network.options, ...)
}

#' GLMNET cross-validation model penalizing nodes with small degree
#'
#' This function overrides the `trans.fun` options in `network.options` with the
#' inverse of a degree described in Veríssimo et al. (2015) that penalizes
#' nodes with small degree.
#'
#' @param xdata input data, can be a matrix or MultiAssayExperiment
#' @param ydata response data compatible with glmnet
#' @param network type of network, see below
#' @param network.options options to calculate network
#' @param ... parameters that glmnet accepts
#'
#' @return see cv.glmSparseNet
#' @export
#'
#' @seealso glmNetSparse
#' @examples
#' xdata <- matrix(rnorm(100), ncol = 5)
#' cv.glmDegree(xdata, rnorm(nrow(xdata)), 'correlation',
#'             family = 'gaussian',
#'             nfolds = 5,
#'             network.options = networkOptions(min.degree = .2))
cv.glmDegree <- function(xdata, ydata, network,
                         network.options = networkOptions(), ...) {
    network.options$trans.fun <- function(x) { 1 / x}
    cv.glmSparseNet(xdata, ydata, network,
                    network.options = network.options, ...)
}

#' GLMNET cross-validation model penalizing nodes with small degree
#'
#' This function overrides the `trans.fun` options in `network.options` with
#' an heuristic described in Veríssimo et al. that penalizes nodes with small
#' degree.
#'
#' @param xdata input data, can be a matrix or MultiAssayExperiment
#' @param ydata response data compatible with glmnet
#' @param network type of network, see below
#' @param network.options options to calculate network
#' @param ... parameters that glmnet accepts
#'
#' @return see cv.glmSparseNet
#' @export
#'
#' @seealso glmNetSparse
#' @examples
#' xdata <- matrix(rnorm(100), ncol = 5)
#' cv.glmHub(xdata, rnorm(nrow(xdata)), 'correlation',
#'           family = 'gaussian',
#'           nfolds = 5,
#'           network.options = networkOptions(min.degree = .2))
cv.glmHub <- function(xdata, ydata, network,
                      network.options = networkOptions(), ...) {

    network.options$trans.fun <- hubHeuristic
    cv.glmSparseNet(xdata, ydata, network,
                    network.options = network.options, ...)
}
