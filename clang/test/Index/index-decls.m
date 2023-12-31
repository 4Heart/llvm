@interface I
@property (readonly) id prop;
 -(id)prop;
@end

@interface I()
@property (assign,readwrite) id prop;
@end

@implementation I
@synthesize prop = _prop;
@end

@interface I1
__attribute__((something)) @interface I2 @end
@end

@interface I3
@property (assign,readwrite) id auto_prop;
@end

@implementation I3
-(void)meth {
  _auto_prop = 0;
}
@end

int test1() {
  extern int extvar;
  extvar = 2;
  extern int extfn();
  return extfn();
}

@interface I4
@property (assign, nonatomic) id prop;
-(id)prop;
-(void)setProp:(id)p;
@end

@implementation I4
@synthesize prop = _prop;
-(id)prop {
  return 0;
}
-(void)setProp:(id)p {
}
@end

@class I5;
@interface I5
-(void)meth;
@property (class) int c;
@end

// RUN: c-index-test -index-file %s -target x86_64-apple-macosx10.7 > %t
// RUN: FileCheck %s -input-file=%t
// CHECK: [indexDeclaration]: kind: objc-class | name: I | {{.*}} | loc: 1:12
// CHECK: [indexDeclaration]: kind: objc-instance-method | name: prop | {{.*}} | loc: 3:7
// CHECK: [indexDeclaration]: kind: objc-property | name: prop | {{.*}} | loc: 2:25
// CHECK: [indexDeclaration]: kind: objc-category | name:  | {{.*}} | loc: 6:12
// CHECK: [indexDeclaration]: kind: objc-instance-method | name: setProp: | {{.*}} | loc: 7:33
// CHECK: [indexDeclaration]: kind: objc-property | name: prop | {{.*}} | loc: 7:33

// CHECK: [indexDeclaration]: kind: objc-instance-method | name: prop | {{.*}} | loc: 11:13 | {{.*}} | lexical-container: [I:10:17]
// CHECK: [indexDeclaration]: kind: objc-instance-method | name: setProp: | {{.*}} | loc: 11:13 | {{.*}} | lexical-container: [I:10:17]
// CHECK: [indexDeclaration]: kind: objc-ivar | name: _prop | {{.*}} | loc: 11:20

// CHECK: [indexDeclaration]: kind: objc-ivar | name: _auto_prop | {{.*}} | loc: 19:33
// CHECK: [indexEntityReference]: kind: objc-ivar | name: _auto_prop | {{.*}} | loc: 24:3

// CHECK: [indexDeclaration]: kind: function | name: test1 | {{.*}} | loc: 28:5
// CHECK: [indexDeclaration]: kind: variable | name: extvar | {{.*}} | loc: 29:14
// CHECK: [indexEntityReference]: kind: variable | name: extvar | {{.*}} | loc: 30:3
// CHECK: [indexDeclaration]: kind: function | name: extfn | {{.*}} | loc: 31:14
// CHECK: [indexEntityReference]: kind: function | name: extfn | {{.*}} | loc: 32:10

// CHECK: [indexDeclaration]: kind: objc-class | name: I4 | {{.*}} | loc: 35:12
// CHECK: [indexEntityReference]: kind: objc-property | name: prop | {{.*}} | cursor: ObjCSynthesizeDecl=prop:36:34 (Definition) | loc: 42:13 | <parent>:: kind: objc-class | name: I4 | {{.*}} | container: [I4:41:17] | refkind: direct
// CHECK-NOT: [indexDeclaration]: kind: objc-instance-method {{.*}} loc: 36:
// CHECK-NOT: [indexDeclaration]: kind: objc-instance-method {{.*}} loc: 42:

// CHECK: [indexDeclaration]: kind: objc-instance-method | name: meth | {{.*}} loc: 52:8 | {{.*}} | isRedecl: 0 | isDef: 0 |
// CHECK: [indexDeclaration]: kind: objc-property | name: c | USR: c:objc(cs)I5(cpy)c | lang: ObjC | cursor: ObjCPropertyDecl=c:53:23 [class,] | loc: 53:23
