// RUN: %clang -emit-llvm -g -S %s -o - | FileCheck %s
class Class
{
public:
//CHECK: DW_TAG_const_type
    int foo (int p) const {
        return p+m_int;
    }  

protected:
    int m_int;
};

Class c;
