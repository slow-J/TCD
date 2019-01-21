//
// matrixMultiply.cpp
//
#include <iostream> // delete this later
#include "helper.h"                                     // helper functions

#define K           1024LL                              // NB: 64 bit
#define M           (K*K)                               //
#define G           (K*K*K)                             //

#define N           50                                  // N x N matrices
#define NSECONDS    10                                  // run for NSECONDS

UINT matA[N][N];
UINT matB[N][N];
UINT matC[N][N];

UINT matB_transposed[N][N];
UINT matD[N][N];

//
// main
//
int main(int argc, char **argv) {

    // header
    char date[256];
    getDateAndTime(date, sizeof(date));

    // get L2 cache size
    UINT cacheSz = getL2CacheSz() / (UINT) sizeof(UINT);

    // run details
    printf("%s %s\n", getHostName(), date);

#ifdef _DEBUG
    printf("DEBUG");
#else
    printf("RELEASE");
#endif

    printf("\n");

    // OS details
    printf("%s %s bit exe\n", getOSName(), (is64bitExe() ? "64" : "32"));

    // CPU details
    printf("Intel%s family %u model %u stepping %u %s", (cpu64bit() ? "64" : "32"), cpuFamily(), cpuModel(), cpuStepping(), cpuBrandString());
    printf(" NCPUS=%u RAM=%zuGB L2 cacheSz=%zuK\n", getNumberOfCPUs(), (getPhysicalMemSz() + G - 1) / G, cacheSz*sizeof(UINT)/1024);

    // cache details
    getCacheLineSz();          // get cache line size and output cache organisation
    printf("\n");

    //
    // initialise matA (random NxN matrix) and
    // initialise matB (random NxN matrix)
    //
    for (UINT row = 0; row < N; row++) {
        for (UINT col = 0; col < N; col++) {
            matA[row][col] = rand() % 10;
            matB[row][col] = rand() % 10;
        }
    }

    //
    // multiply matrices for NSECONDS
    // standard algorithmn matC = matA*matB
    //
    UINT cnt0 = 0;
    UINT64 t99, t0 = getWallClockMS();
    while (1) {

        // matC = matA*matB
        for (UINT row = 0; row  < N; row++) {
            for (UINT col = 0; col < N; col++) {
                UINT sum = 0;
                for (UINT k = 0; k < N; k++)
                    sum += matA[row][k]*matB[k][col];
                matC[row][col] = sum;
            }
        }
        cnt0++;

        t99 = getWallClockMS();
        if ((t99 - t0) > NSECONDS*1000)
            break;

    }
    printf("%ux%u matrix multiplication\n", N, N);
    printf("cnt=%u %8.2f op/s\n\n", cnt0, cnt0*1000.0/(t99 - t0));

    //
    // multiply matrices for NSECONDS
    // tranpose matB
    // matD = matA*matB_transposed
    //
    UINT cnt1 = 0;
    t0 = getWallClockMS();
    while (1) {

        // matB_transposed = tranpose matB
        // ADD YOUR CODE HERE
       
       
        for (UINT i=0; i<N; i++)
        {
          for (UINT j=0; j<N; j++)
          {
            matB_transposed[j][i] = matB[i][j];
          }
        }
       
        // matD = matA*matB_transposed
        // ADD YOUR CODE HERE
       
      
        for (UINT row = 0; row  < N; row++) {
            for (UINT col = 0; col < N; col++) {
                UINT sum = 0;
                for (UINT k = 0; k < N; k++)
                    sum += matA[row][k]*matB_transposed[col][k];
                matD[row][col] = sum;
            }
        }

        cnt1++;

        t99 = getWallClockMS();
        if ((t99 - t0) > NSECONDS*1000)
            break;

    }
    printf("%ux%u matrix multiplication using matB_transposed\n", N, N);
    printf("cnt=%u %8.2f op/s\n\n", cnt1, (double) cnt1*1000.0/(t99 - t0));

    //
    // check that matC and matD identical
    //
    UINT err = 0;
    for (UINT row = 0; row  < N; row++) {
        for (UINT col = 0; col < N; col++) {
            if (matC[row][col] != matD[row][col]) {
                err = 1;
                break;
            }
        }
    }

    if (err) {
        printf ("ERROR: matC and matD are NOT identical\n");
    } else {
        printf("OK %8.2f time faster\n", (double) cnt1/cnt0);
    }

    quit(0);

    return 0;
}

