%Multiple Access Techniques for 5G Wireless Net works and Beyond中码本，SCMA
%codebook design,” in Proc. IEEE 80th Vehicular Technology Conference
%因子图
%[0 1 1 0 1 0
% 1 0 1 0 0 1
% 0 1 0 1 0 1
% 1 1 0 1 1 0]
function CB = CodeBook_test()
CB(:,:,1)=[  0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i
-0.746424286896854 + 0.665470347897277i	-0.665470347897277 - 0.746424286896854i	0.665470347897277 + 0.746424286896854i	0.746424286896854 - 0.665470347897277i
0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i
-0.973252778377929 - 0.229736869874302i	-0.229736869874302 + 0.973252778377929i	0.973252778377929 + 0.229736869874302i	0.229736869874302 - 0.973252778377929i];

CB(:,:,2)=[  0.973252778377929 + 0.229736869874302i	-0.229736869874302 + 0.973252778377929i	0.229736869874302 - 0.973252778377929i	-0.973252778377929 - 0.229736869874302i
0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i
0.746424286896854 - 0.665470347897277i	0.665470347897277 + 0.746424286896854i	-0.746424286896854 + 0.665470347897277i	-0.665470347897277 - 0.746424286896854i
0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i];

CB(:,:,3)=[ -0.746424286896854 + 0.665470347897277i	-0.665470347897277 - 0.746424286896854i	0.665470347897277 + 0.746424286896854i	0.746424286896854 - 0.665470347897277i
0.519244395468625 - 0.854625799853025i	0.854625799853025 + 0.519244395468625i	-0.519244395468625 + 0.854625799853025i	-0.854625799853025 - 0.519244395468625i
0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i
0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i];

CB(:,:,4)=[  0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i
0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i
0.973252778377929 + 0.229736869874302i	-0.229736869874302 + 0.973252778377929i	0.229736869874302 - 0.973252778377929i	-0.973252778377929 - 0.229736869874302i
0.519244395468625 - 0.854625799853025i	0.854625799853025 + 0.519244395468625i	-0.519244395468625 + 0.854625799853025i	-0.854625799853025 - 0.519244395468625i];

CB(:,:,5)=[  -0.519244395468625 + 0.854625799853025i	-0.854625799853025 - 0.519244395468625i	0.854625799853025 + 0.519244395468625i	0.519244395468625 - 0.854625799853025i
0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i
0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i
0.746424286896854 - 0.665470347897277i	0.665470347897277 + 0.746424286896854i	-0.746424286896854 + 0.665470347897277i	-0.665470347897277 - 0.746424286896854i];

CB(:,:,6)=[  0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i
0.973252778377929 + 0.229736869874302i	-0.229736869874302 + 0.973252778377929i	0.229736869874302 - 0.973252778377929i	-0.973252778377929 - 0.229736869874302i
0.519244395468625 - 0.854625799853025i	-0.854625799853025 - 0.519244395468625i	-0.519244395468625 + 0.854625799853025i	0.854625799853025 + 0.519244395468625i
0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i	0.00000000000000 + 0.00000000000000i];
end
