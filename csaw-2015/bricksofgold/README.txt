Challenge: Bricks of Gold
Category: Crypto
Author: Sophia D'Antoine
Points: 500 

Question Text: 
We've captured this encrypted file being smuggled into the country. All we know is that they rolled their own custom CBC mode algorithm - its probably terrible. 

Can you help us?


Answer: flag{c4sh_Rul3s_ev3ryTh1ng_4r0und_m3}

Organizer Description:
	This challenge is an encrypted file using a custom XOR CBC mode algorithm (IV and Key are both 4 bytes). To solve this, you need to figure out how to decrypt the file using knowledge of file headers, cryptography, and python brute force (only need to brute force 4 bytes so it's easy). 

To distribute:
	bricks_of_gold_40d12e05cd6d67ed51d29a6da39d6878 (md5sum appended)

Setup:
	This challenge has no setup or server component. Just need to distribute the file above.

Hints:
	as it is multi-staged, ask me for hints based on what ppl are stuck on