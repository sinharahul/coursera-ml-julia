@doc """
  #RBFKERNEL returns a radial basis function kernel between x1 and x2
    sim = gaussianKernel(x1, x2) returns a gaussian kernel between x1 and x2
    and returns the value in sim
""" ->
function gaussianKernel(x1, x2, sigma)
  # You need to return the following variables correctly.
  sim = 0

  if contains(@sprintf("%s", x1), "Array")
    x1 = x1[:]
    x2 = x2[:]
  end

  # ====================== YOUR CODE HERE ======================
  # Instructions: Fill in this function to return the similarity between x1
  #               and x2 computed using a Gaussian kernel with bandwidth
  #               sigma
  #
  #
  # =============================================================

  return sim
end
