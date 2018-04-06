#ifndef STRESSINFO_H
#define STRESSINFO_H

#include <vector>

// Note that stressInfo is also defined in distanceMapper.h
// currently in the historical section. We should
struct stressInfo {
  unsigned int dimNo;
  unsigned int activeDimNo;
  std::vector<float> dimFactors;
  float stress;
  float Kruskal_stress;
  // Here Kruskal_stress is the sum of squared deviations
  // This isn't actually the Kruskal stress, which is
  // sqrt( sum(squared_deviates)/total_sq_distance )
  // but since we don't know the total_sq_distance here
  // we refer to this as Kruskal_stress.
  
  stressInfo(){
    dimNo = activeDimNo = 0;
    stress = Kruskal_stress = 0;
  }
  stressInfo(std::vector<float> df, float str, float k_stress)
  : dimNo(df.size()), activeDimNo(df.size()), dimFactors(df), 
    stress(str), Kruskal_stress(k_stress)
  {
  }
  void setStress(int dim_no, float* df, unsigned int ad, float s, float k_stress=0){
    dimNo = dim_no;
    activeDimNo = ad;
    dimFactors.resize(dimNo);
    for(unsigned int i=0; i < dimNo; ++i)
      dimFactors[i] = df[i];
    stress = s;
    Kruskal_stress = k_stress;
  }
  void setStress(std::vector<float> dims, float s, float k_stress=0){
    dimNo = activeDimNo = dims.size();
    dimFactors = dims;
    stress = s;
    Kruskal_stress = k_stress;
  }
  float dimensionality(){
    float d=0;
    for(unsigned int i=0; i < dimFactors.size(); ++i)
      d += dimFactors[i];
    return(d);
  }
  float currentDF(){
    if(activeDimNo - 1 > 0)
      return(dimFactors[activeDimNo - 1]);
    return(1.0);
  }
};

#endif
