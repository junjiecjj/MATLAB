%SCMA Codebook Design," 2014 IEEE 80th Vehicular Technology Conference (VTC2014-Fall)
%因子图
%[0 1 1 0 1 0
% 1 0 1 0 0 1
% 0 1 0 1 0 1
% 1 0 0 1 1 0]
function CB = CodeBook_HuaWei()
CB(:,:,1)=[  0	0	0	0
-0.314367142196058-0.228284238795815i	-1.10002519013067-0.799341245859398i	1.10002519013067+0.799341245859398i	   0.314367142196058+0.228284238795815i
0	0	0	0
1.35983274566460	-0.388498898041740	0.388498898041740	-1.35983274566460];

CB(:,:,2)=[  1.35983274566460 	-0.388498898041740 	0.388498898041740	-1.35983274566460
0	0	0	0
-0.314367142196058-0.228284238795815i	-1.10002519013067-0.799341245859398i	1.10002519013067+0.799341245859398i	  0.314367142196058+0.228284238795815i
0	0	0	0];

CB(:,:,3)=[  -1.10002519013067+0.799341245859398i	0.314367142196058-0.228284238795815i	-0.314367142196058+0.228284238795815i	1.10002519013067-0.799341245859398i
0.241101411535489-0.304667660122791i	0.844028145411234-1.06625020791126i	-0.844028145411234+1.06625020791126i	-0.241101411535489+0.304667660122791i
0	0	0	0
0	0	0	0];

CB(:,:,4)=[  0	0	0	0
0	0	0	0
1.35983274566460	-0.388498898041740	0.388498898041740	-1.35983274566460
-0.00952627703624418-0.388325693004717i	 -0.0334285721453659-1.35931313055353i	0.0334285721453659+1.35931313055353i	0.00952627703624418+0.388325693004717i
];

CB(:,:,5)=[ -0.00952627703624418-0.388325693004717i	-0.0334285721453659-1.35931313055353i	0.0334285721453659+1.35931313055353i	0.00952627703624418+0.388325693004717i
0	0	0	0
0	0	0	0
-1.10002519013067+0.799341245859398i	0.314367142196058-0.228284238795815i	-0.314367142196058+0.228284238795815i	1.10002519013067-0.799341245859398i];

CB(:,:,6)=[  0	0	0	0
1.35983274566460	-0.388498898041740	0.388498898041740	-1.35983274566460
0.241101411535489-0.304667660122791i	0.844028145411234-1.06625020791126i	 -0.844028145411234+1.06625020791126i	-0.241101411535489+0.304667660122791i
0	0	0	0];
end

