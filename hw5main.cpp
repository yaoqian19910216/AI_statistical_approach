//
//  main.cpp
//  HW_5
//
//  Created by Qian Yao on 5/18/13.
//  Copyright (c) 2013 Qian Yao. All rights reserved.
//

#include <iostream>
#include <iomanip>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <set>
#include <algorithm>
#include <cmath>
#include <stack>
#include <functional>
#include <numeric>

using namespace std;
struct Protein
{
    string sequence;
    double label;
};

//----------------------------------------------------------------------------------
//right click the product to get the working directory and put txt files there.
void initializesample(string a, vector<Protein>& data)

{
    string line; Protein DNA;
    ifstream myfile;
    myfile.open(a);
    if(!myfile)
    {
        cout << "can't open or find the file" << endl;
        exit(1);
    }
    while(getline(myfile,line))//get next line from the file
    {
        
        if(line.empty())
            continue;
        istringstream inputstream(line);//separtae the line based on the spaces between words
        inputstream>>DNA.sequence;
        inputstream>>DNA.label;
        
        data.push_back(DNA);//get the matrix
    }
    myfile.close();
    
}

//string kernel = the number of command substring of length p 
double stringkernel(const string s,const string t,const double p)
{
    typedef string :: size_type str_size;
    str_size i;
    string v_substr,pre_a;
    size_t found1,found2;
    double count = 0;
    
    for(i = 0;i < s.size() - p + 1;i++)
    {
        
        //get the substring of length p in a
        v_substr = s.substr(i,p);
        //get previous string of a
        pre_a = s.substr(0,i);
        found1 = pre_a.find(v_substr);
        if(found1 == string::npos)//check if v appears earlier in s
        {
            found2 = t.find(v_substr);//check if v appears in t
            if(found2 != string::npos)
            {
                count ++;
                //cout<<"the command substring is "<<v_substr<<endl;
            }
                
        }
    }
    return count;
        
    
}

//---------------Kernel Perception Algorithm-----------------
void Kernelperception( const vector<Protein> data, vector<string> & x_string, vector<double> & y_label,const double p )

{
    
    typedef vector<Protein> :: size_type vec_Pro_size;
    typedef vector<string> :: size_type vec_str_size;
    typedef vector<double> :: size_type vec_size;
    vec_Pro_size t;
    vec_str_size i;
    double kernelproduct;
    x_string.push_back(data[0].sequence);
    y_label.push_back(data[0].label);
    for(t = 1;t < data.size();t++)
    {
        kernelproduct = 0.0;
        //calculate kernel product
        for(i = 0;i < x_string.size();i++)
        {
            kernelproduct  = kernelproduct + y_label[i]*stringkernel(x_string[i], data[t].sequence, p);
        }
        
        //store the string and label where a mistake has been made
        if(data[t].label*kernelproduct <= 0)
        {
            x_string.push_back(data[t].sequence);
            y_label.push_back(data[t].label);
        }
           
        
    }
}
//---------testing the data using kernel perception algorithm----------
double Kernelperceptiontest(const vector<Protein>data, const vector<string> x_string, const vector<double> y_label,const double p)
{
    
    typedef vector<Protein> :: size_type vec_Pro_size;
    typedef vector<string> :: size_type vec_str_size;
    typedef vector<double> :: size_type vec_size;
    
    vec_Pro_size t;
    vec_str_size i;
    double kernelproduct = 0.0;
    double errornumber = 0.0;
    
    for(t = 0; t < data.size();t++)
    {
        kernelproduct = 0.0;
        //calculate kernelproduct
        for(i = 0;i < x_string.size();i++)
        {
            kernelproduct  = kernelproduct + y_label[i]*stringkernel(x_string[i], data[t].sequence, p);
        }
        //count number of error data
        if(data[t].label*kernelproduct <= 0)
            errornumber++;
    }
    
    return  errornumber/data.size();
    
    
    
}


//---------main function-----------------
int main(int argc, const char * argv[])
{
    
    typedef vector<Protein> :: size_type vec_size;
    vector<Protein> traindata,testdata;
    vector<string> x_string1,x_string2;
    vector<double> y_label1,y_label2;
    double p1 = 3.0, p2 = 4.0;
    initializesample("hw5train.txt", traindata);
    initializesample("hw5test.txt", testdata);
    
    //get the classifier using kernel perception and test training
    //data with p = 3
    Kernelperception( traindata, x_string1, y_label1,p1);
    cout << "the error with p = " << p1 << " is " << endl;
    cout<< "the traning error is " << Kernelperceptiontest(traindata, x_string1, y_label1, p1) << endl;
    cout << "the test error is " << Kernelperceptiontest(testdata, x_string1, y_label1, p1) << endl;
    
    cout<<endl;
    
    //get the classifier using kernel perception and test training
    //data with p = 4
    Kernelperception( traindata, x_string2, y_label2,p2);
    cout << "the error with p = " << p2 << " is " << endl;
    cout<< "the traning error is " << Kernelperceptiontest(traindata, x_string2, y_label2, p2) << endl;
    cout << "the test error is " << Kernelperceptiontest(testdata, x_string2, y_label2, p2) << endl;
    return 0;
}

