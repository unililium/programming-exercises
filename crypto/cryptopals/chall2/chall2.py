import binascii
from Crypto.Util.strxor import strxor

a = "1c0111001f010100061a024b53535009181c"
b = "686974207468652062756c6c277320657965"
expected = b"746865206b696420646f6e277420706c6179"

a = binascii.unhexlify(a)
b = binascii.unhexlify(b)

c = strxor(a, b)
print(binascii.hexlify(c))
if expected == binascii.hexlify(c):
    print(c)
