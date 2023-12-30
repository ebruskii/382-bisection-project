

#include <iostream>
#include <sstream>
#include <iomanip>
#include <limits>
using namespace std;

int n;
double a, b;
double compute(double x, double eq[]){
    double x_x0 = x;
    double sum_x1 = eq[0]; // sum starts at first value
    cout << "first var\n" << eq[0] << endl;
    double thismult_x2 = 1;
    int counter_x3 = 0;
    int offset_x4 = 0;
    double coeff_x5 = eq[offset_x4];
    double xpower_x6 = 1;
    //cout << " coeff should be 5.3, it is " << coeff_x5 << endl;
    //offset_x4 = 1;
    if (counter_x3 == 0){
        cout << "no power \n" << endl;
        goto noPower;
    }
    nextNum:
    if(counter_x3 > n){
        cout << "\n\n sum is: " << sum_x1 << endl;
        return sum_x1;
    }
    cout << counter_x3 << ": current coefficient: " << coeff_x5 << endl;
    
    //cout << "\tx2, multiplication total: should be 2, 4, etc " << thismult_x2 << endl;
    //does not need to update
    /*for (int i = 0; i < counter_x3; i ++){
        thismult_x2 = thismult_x2 * x_x0;
        cout << "\tx2, multiplication total: " << thismult_x2 << endl;
    } */
    thismult_x2 = xpower_x6 * coeff_x5;
    cout << "  x2*coeff: " << thismult_x2 << endl;
    //cout << "should be: " << thismult_x2 * coeff_x5 << endl; 
    // mult * coefficient
    sum_x1  = sum_x1 + thismult_x2;
     cout << "  sum*coeffthis: " << sum_x1 << endl;

    noPower: 
    xpower_x6 = xpower_x6 * x_x0; //multiplies it by one more x 
    
    
    cout << "\tx2, multiplication total: should be 2, 4, etc " << xpower_x6 << endl;
    //does not need to update
    //cout << counter_x3 << "\tx3: counter: "  << endl;
    cout << "x0: " << x_x0 << endl;
    cout << "x1, sum: " << sum_x1 << endl;
    cout << "x2, x^power *coeff: " << thismult_x2 << endl;
    cout << "x3, counter: " << counter_x3<< endl;
    cout << "x4, offset: " << offset_x4 << endl;
   
    cout << "x5, coeff: " << coeff_x5 << endl;
    cout << "next coefficient will be: " << eq[counter_x3+1] << endl; //should over for the last one idc
    //cout << "xpower_x6 * x_x0: " << xpower_x6 * x_x0 << endl;
    cout << "\n" << endl;


    thismult_x2 = 1;
    counter_x3 = counter_x3 + 1;
    offset_x4 ++; //would be offset = offset + 8;
    coeff_x5 = eq[offset_x4];
    


    goto nextNum;

    return 0;
}

double bisect(double eq[], double a, double b){
    double fA_x20 = compute(a, eq);
    double fB_x21 = compute(b, eq);
    double m = midpoint(1, -1);
    double fC_x22 = compute (m, eq);

    cout << "f(a): "  << fA_x20 << endl;
    cout << "f(b): "  << fB_x21 << endl;
    cout << "f(c): "  << fC_x22 << endl;
    return 0;
}

double midpoint (double x, double y){
    double total_x0 = a + b;
    double midpoint_x0 = total_x0 / 2; 
    cout << "a is: " << a << ", b is: " << b << ", mid is: " << midpoint_x0 << endl;
    return midpoint_x0; 
}

int main(int argc, char* argv[]){
	//coeff: .double 5.3, 0.0, 2.9, -3.1 // coefficients of the polynomial function 
    /*double coeff[] = {5.3, 0.0, 2.9, -3.1};
    n = 3;
    //cout << "poly of 1 is: " << compute(1., coeff) << endl;
    //cout << "poly of 2 is: " << compute(2., coeff) << endl;
    compute(2.0, coeff);
   // cout << compute(1., coeff) << ;
    cout << "\n\n\n" << endl;
    */

    double coeff1[] = {.2, 3.1, -.3, 1.9, .2};
    n = 4;
    compute(1.0, coeff1);

    bisect(coeff1, 1, -1);

    return 0;
}
