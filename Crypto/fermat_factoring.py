import math as m

def fermat_fact(n):
    x = m.ceil(m.sqrt(n))
    y2 = x ** 2 - n
    while m.ceil(m.sqrt(y2)) != m.sqrt(y2):
        x = x + 1
        y2 = y2 + 2 * x - 1
    return (x - m.sqrt(y2), x + m.sqrt(y2))

while True:
    n = int(input("Insert odd number: "))
    print(fermat_fact(n))
