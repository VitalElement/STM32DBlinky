module main;

class Point
{
    this (int x, int y)
    {
        X = x;
        Y = y;
    }
    
    int X;
    int Y;
    
    int Sum ()
    {
        return X + Y;
    }
}

private int Sum (int x, int y)
{
    auto result = 0;
    
    result = x + y;
    
    return result;
}

void Main()
{
    int y = 0;
    
    scope p = new Point(2,2);
    
    y++;
    
    y++;
    
    y = Sum(y ,4);
    
    if(y > 4)
    {
        y--;
    }
    else
    {
        y++;
    }
}


