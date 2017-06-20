module main;

final abstract class TestClass1 { }
final abstract class TestClass2 { }
final abstract class TestClass3 { }
final abstract class TestClass4 { }
final abstract class TestClass5 { }
final abstract class TestClass6 { }
final abstract class TestClass7 { }
final abstract class TestClass8 { }
final abstract class TestClass9 { }

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
    scope p = new Point(2,2);
    
    int sum = p.Sum();
    
    p.X = 1;
    p.Y = 1;
    
    int sum2 = p.Sum();
    
    int x = 0; 
    
    x++;
}


