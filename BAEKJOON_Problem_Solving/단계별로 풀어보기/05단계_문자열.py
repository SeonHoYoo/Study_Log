# -*- coding: utf-8 -*-
"""5단계 문자열.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/17r697-Xl2-lU6k2fb1M1NT7EChTYVTJN
"""

#27866
s = input()
i = int(input())
print(s[i-1])

#2743
s = input()
print(len(s))

#9086
n = int(input())
for i in range(n):
    s = input()
    print(s[0]+s[len(s)-1])

#11654
c = input()
print(ord(c))

#11720
n = int(input())
s = input()
sum = 0
for i in range(n):
    sum += int(s[i])
print(sum)

#10809
s = input()
for i in range(97,123):
    print(s.find(chr(i)),end=' ')

#2675
t = int(input())
for i in range(t):
    r,s = input().split()
    for j in range(len(s)):
        print(s[j]*int(r),end='')
    print()

#1152
s = input().split()
print(len(s))

#2908
a,b = input().split()
a = int(a[::-1])
b = int(b[::-1])
if a>b:
    print(a)
else:
    print(b)

#5622
n = input()
sum = 0
for i in range(len(n)):
  if ord(n[i])-65<3:
    sum += 3
    continue
  if ord(n[i])-65<6:
    sum += 4
    continue
  if ord(n[i])-65<9:
    sum += 5
    continue
  if ord(n[i])-65<12:
    sum += 6
    continue
  if ord(n[i])-65<15:
    sum += 7
    continue
  if ord(n[i])-65<19:
    sum += 8
    continue
  if ord(n[i])-65<22:
    sum += 9
    continue
  else:
    sum += 10
print(sum)

#11718
while True:
    try:
        print(input())
    except:
        break