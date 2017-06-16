module main;

private int Sum (int x, int y)
{
    auto result = 0;
    
    result = x + y;
    
    return result;
}

void Main()
{
    int y = 0;
    
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


