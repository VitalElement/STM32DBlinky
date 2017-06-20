module main;

import core.stdc.config;

final abstract class TestClass1 { }
final abstract class TestClass2 { }
final abstract class TestClass3 { }
final abstract class TestClass4 { }
final abstract class TestClass5 { }
final abstract class TestClass6 { }
final abstract class TestClass7 { }
final abstract class TestClass8 { }
final abstract class TestClass9 { }

__gshared extern (C) extern c_ulong _stackStart;
__gshared extern (C) extern c_ulong __bss_end__;

__gshared extern (C) extern c_ulong __text_end__; 


extern (C) void* malloc (uint size)
{
    c_ulong* result = &__bss_end__;
    
    return result;
}

extern (C) void _d_callfinalizer (void *p)
{
}

extern (C) void _d_eh_resume_unwind (void *p)
{
}

class Point 
{
    this (int x, int y)
    {
        X = x;
        Y = y;
    }
    
    int Sum ()
    {
        int result = 0;
        
        result += X;
        result += Y;
        
        return result;
    }
    
    int X;
    int Y;
}

void Main()
{
    int x = 0; 
    
    __gshared extern (C) heapStart = &__bss_end__;
    
    x++;
    
    auto p = new Point(2,2); 
    
    int sum = p.Sum();
    
    p.X = 1;
    p.Y = 1;
    
    int sum2 = p.Sum();
}


