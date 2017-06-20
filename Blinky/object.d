module object;

alias size_t    = typeof(int.sizeof);
alias ptrdiff_t = typeof(cast(void*)0 - cast(void*)0);
alias string    = immutable(char)[];

extern(C) __gshared void* _Dmodule_ref;

struct ModuleInfo
{ 
    uint _flags;
    uint _index;
}

class Object
{ 

}

class TypeInfo 
{ 
    version(DigitalMars)
    {
        //DMD complains if this doesn't exist
        size_t getHash(in void* p) @trusted nothrow const { return cast(size_t)p; }
    }
}

class TypeInfo_Typedef
{

}

class TypeInfo_Struct : TypeInfo
{
    string name;
    void[] m_init;      // initializer; m_init.ptr == null if 0 initialize

  @safe pure nothrow
  {
    size_t   function(in void*)           xtoHash;
    bool     function(in void*, in void*) xopEquals;
    int      function(in void*, in void*) xopCmp;
    string   function(in void*)           xtoString;

    enum StructFlags : uint
    {
        hasPointers = 0x1,
        isDynamicType = 0x2, // built at runtime, needs type info in xdtor
    }
    StructFlags m_flags;
  }
    union
    {
        void function(void*)                xdtor;
        void function(void*, const TypeInfo_Struct ti) xdtorti;
    }
    void function(void*)                    xpostblit;

    uint m_align;

    version (X86_64)
    {
        override int argTypes(out TypeInfo arg1, out TypeInfo arg2)
        {
            arg1 = m_arg1;
            arg2 = m_arg2;
            return 0;
        }
        TypeInfo m_arg1;
        TypeInfo m_arg2;
    }
    immutable(void)* m_RTInfo;                // data for precise GC
}


class TypeInfo_Interface : TypeInfo 
{
    version(D_LP64)
    {
        ubyte[8] ignore;
    }
    else
    {
        ubyte[4] ignore;
    }
}

class TypeInfo_Class : TypeInfo 
{
    // See https://github.com/ldc-developers/ldc/issues/781
    version(LDC)  
    {
        byte[]                init;
        string                name;
        void*[]               vtbl;
        void*[]               interfaces;
        TypeInfo_Class        base;
        void*                 destructor;
        void function(Object) classInvariant;
        uint                  m_flags;
        void*                 deallocator;
        void*[]               m_offTi;
        void function(Object) defaultConstructor;  
        immutable(void)*      m_RTInfo;           
    }
    else version(D_LP64)
    {
        ubyte[136] ignore;
    }
    else
    {
        
        ubyte[68] ignore;
    }
}

class TypeInfo_Enum : TypeInfo_Typedef
{

}

class TypeInfo_Invariant : TypeInfo_Const
{
    
}



class TypeInfo_Delegate : TypeInfo
{
    version(D_LP64)
    {
        ubyte[24] ignore;
    }
    else
    {
        ubyte[12] ignore;
    }
}

class TypeInfo_Const : TypeInfo
{
    version(D_LP64)
    {
        ubyte[8] ignore;
    }
    else
    {
        ubyte[4] ignore;
    }
}

// Only LDC seems to require this
version(LDC)
{
    class TypeInfo_AssociativeArray : TypeInfo
    {
        //TypeInfo value;
        //TypeInfo key;
        version(D_LP64)
        {
            ubyte[16] ignore;
        }
        else
        {
            ubyte[8] ignore;
        }
    }
}

bool _xopEquals(in void*, in void*)
{
    // TODO: errror here.  Not supported
    return false;
}


class Throwable
{ }

class Error : Throwable
{ 
    this(string x)
    { }
}