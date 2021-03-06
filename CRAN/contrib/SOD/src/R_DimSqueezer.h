#ifndef _R_DimSqueezer
#define _R_DimSqueezer

#include <Rcpp.h>
#include <string>
#include "sod/DistanceMapper.h"
#ifdef HAVE_CL
#include "sod/oCL_DistanceMapperManager.h"  // not necessary if we use a pointer
#endif

// It seems that this _has_ to be here.
// I could not get away with using it within the RCPP_MODULE part
using namespace Rcpp;   

// standard squeezer
class R_DimSqueezer {
 public :
  R_DimSqueezer(NumericMatrix r_positions);
  ~R_DimSqueezer();

  Rcpp::List squeeze(unsigned int target_dimensionality, unsigned int iter_no);
  Rcpp::List squeezeDF(NumericMatrix dimFactors);
  void useOpenMP(bool use_openMP);
  void setOmpThreadNo(unsigned int tno);
  void removeResidualStress(bool remResidual);
  
 private:
  DistanceMapper* mapper;
  float* positions;
  float* distances;
  float totalDistance, totalSqDistance;
  unsigned int dimension_no;
  unsigned int node_no;

  bool multithreaded;
};

// openCL based squeezer
// This really ought to be done using inheritance, but .. 
#ifdef HAVE_CL
class R_CL_DimSqueezer {
 public:
  R_CL_DimSqueezer(NumericMatrix r_positions);
  ~R_CL_DimSqueezer();

  Rcpp::List squeeze(unsigned int target_dimensionality, unsigned int iter_no, 
		     unsigned int local_work_size);

 private:
  OCL_DistanceMapperManager* mapper;
  float* positions;
  float* distances;
  float totalDistance, totalSqDistance;
  unsigned int dimension_no;
  unsigned int node_no;
};
#endif

// Rcpp_Module creates code that can crash the R session if the
// the values of external pointers become NULL. Hence it can't
// really be used.

/*
RCPP_MODULE(mod_R_DimSqueezer) {
  class_<R_DimSqueezer>("DimSqueezer")
    .constructor<NumericMatrix>()
    .method("squeeze", &R_DimSqueezer::squeeze)
    .method("squeezeDF", &R_DimSqueezer::squeezeDF)
    .method("useOpenMP", &R_DimSqueezer::useOpenMP)
    ;
#ifdef HAVE_CL
  class_<R_CL_DimSqueezer>("DimSqueezer_CL")
    .constructor<NumericMatrix>()
    .method("squeeze", &R_CL_DimSqueezer::squeeze)
    ;
#endif
};
*/

#endif
