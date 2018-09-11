from Crypto.Cipher import AES
import base64
import os

key = "YELLOW SUBMARINE"

DecodeAES = lambda c, e: c.decrypt(base64.b64decode(e))
cipher = AES.new(key)
with open("7.txt", "r") as f:
    encoded = f.read()
    decoded = DecodeAES(cipher, encoded)
    fw = open("7.txt.new", "w")
    fw.write(str(decoded))
    f.close()
