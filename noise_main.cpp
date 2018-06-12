/*
 * pv.cpp
 *
 */

#include <columns/buildandrun.hpp>
// #include <layers/NoiseLayer.hpp>
#define MAIN_USES_CUSTOM_GROUPS

#ifdef MAIN_USES_CUSTOM_GROUPS
#include <columns/PV_Init.hpp>
#endif // MAIN_USES_CUSTOM_GROUPS


#include <layers/HyPerLayer.hpp>


#include <climits>
#include <limits>
#include <cmath>

double gaussian_noise(double mean, double sdev){
    const double epsilon = std::numeric_limits<double>::min();
    const double two_pi = 2.0*3.14159265358979323846;
    
    static double z0, z1;
    static bool generate;
    generate = !generate;
    
    if (!generate)
				return z1 * sdev + mean;
    
    double u1, u2;
    do
    {
				u1 = rand() * (1.0 / RAND_MAX);
				u2 = rand() * (1.0 / RAND_MAX);
    }
    while ( u1 <= epsilon );
    
    z0 = sqrt(-2.0 * log(u1)) * cos(two_pi * u2);
    z1 = sqrt(-2.0 * log(u1)) * sin(two_pi * u2);
    
    return z0 * sdev + mean;
    
}




namespace PV {

		class NoiseLayer : public HyPerLayer {

		public:
				NoiseLayer(const char *name, HyPerCol *hc);
				virtual ~NoiseLayer();

				
		protected:
				NoiseLayer();
				int initialize(const char *name, HyPerCol *hc);
				virtual Response::Status updateState(double timestamp, double dt) override;


		private:
				int initialize_base();
		};

		int NoiseLayer::initialize_base(){
				return PV_SUCCESS;
		}
		
		NoiseLayer::NoiseLayer() { initialize_base();}

		NoiseLayer::NoiseLayer(const char *name, HyPerCol *hc) {
				NoiseLayer::initialize_base();
				initialize(name, hc);
		}

		NoiseLayer::~NoiseLayer(){ }


				
		int NoiseLayer::initialize(const char *name, HyPerCol *hc){
				int status = HyPerLayer::initialize(name, hc);
				return status;
		}

		Response::Status NoiseLayer::updateState(double timestamp, double dt) {
				HyPerLayer::updateState(timestamp, dt);
				float *A  = getCLayer()->activity->data;
				int total = getNumExtendedAllBatches();

#ifdef PV_USE_OPENMP_THREADS
#pragma omp parallel for
#endif
				for (int i = 0; i < total; ++i) {
						A[i] = gaussian_noise(0, 0.5);
				}

				return Response::SUCCESS;
		}


} // End PV namespace




int main(int argc, char *argv[]) {

#ifndef MAIN_USES_CUSTOM_GROUPS
//
// The most basic invocation of PetaVision, suitable if you are running from a params file with
// no custom classes.
//
		int status = buildandrun(argc, argv);
#else // MAIN_USES_CUSTOM_GROUPS
		PV_Init pv_initObj(&argc, &argv, false /*do not allow unrecognized arguments*/);
//
// If you create a new class that buildandrun needs to know about, you need to register the
// keyword
// with the PV_Init object.  Generally, this can be done with the Factory::create function
// template:
//
		pv_initObj.registerKeyword("NoiseLayer", Factory::create<NoiseLayer>);
// pv_initObj.registerKeyword("CustomClass2", Factory::create<CustomClass2>);
// etc.
//
		int status = buildandrun(&pv_initObj, NULL, NULL);
#endif // MAIN_USES_CUSTOM_GROUPS
		return status == PV_SUCCESS ? EXIT_SUCCESS : EXIT_FAILURE;
}
