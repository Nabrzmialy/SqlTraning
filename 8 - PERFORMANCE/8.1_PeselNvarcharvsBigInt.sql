
CREATE TABLE dbo.[IntPesel](
	[Pesel] bigint NOT NULL PRIMARY KEY,
	[Name] nvarchar(100) NOT NULL,
)

CREATE TABLE dbo.[TextPesel](
	[Pesel] nvarchar(11) NOT NULL PRIMARY KEY,
	[Name] nvarchar(100) NOT NULL,
)

-- Insert pesels to both tables:
45011117466
45022176296
45031737237
45051271728
45060489138
45062581753
45071444797
45073018365
45100189288
45101865491
45110295681
45111041311
45112321544
45120983327
46021134146
46021154234
46021727858
46031427735
46031676863
46032226432
46032568659
46050193956
46052716894
46062638681
46070374865
46072155277
46072525924
46090252466
46102136674
46102256349
46110457491
46110716512
46120282799
46121835668
47010899435
47020182116
47020379428
47020923184
47031613883
47040359769
47051642517
47062886739
47070229155
47071593181
47071593839
47072139937
47081817183
47081863313
47082542659
47092655936
47092893343
47100478234
47102153834
47102976679
47111099899
47121026971
47121433962
48020421696
48030838527
48032539853
48041884122
48042136563
48052374926
48052752612
48060255941
48060637945
48060782393
48062135588
48062634223
48062992763
48071049375
48080253651
48080918356
48081554843
48082081294
48092111628
48101732448
48121062433
49010168249
49012776264
49020983421
49021871312
49031993752
49040513158
49063035488
49070453712
49081929646
49091335972
49092761158
49100897644
49110158638
49122716772
50011977174
50021936691
50022287598
50031094138
50031225446
50033071991
50041678795
50042964958
50051918461
50071532892
50072539577
50072619752
50080847954
50081051411
50110836758
50111562225
50120342258
51041185872
51042059626
51050867589
51071177355
51072137871
51072225835
51080976284
51082492289
51091581178
51091985798
51100569816
51102743823
51121436764
52021815394
52031028289
52032042257
52042349966
52050829425
52051639997
52051737114
52052889773
52061477116
52062893955
52072739124
52082566868
52090567244
52090839965
52110629345
52111013725
52120628673
52121817498
53012351637
53013056661
53020391526
53022641698
53030894563
53040936145
53041146592
53050757958
53051178464
53061388158
53062012418
53072341982
53072556397
53081172935
53083126734
53092652811
53101057192
53102233195
53123063986
54012852746
54020265163
54022772623
54051579873
54061733382
54072141336
54090139441
54091522981
54092213178
54092597528
54101592917
54102258315
54102697529
54121826654
54122248239
55011694812
55030396465
55031388555
55041551233
55051831444
55051898166
55060948924
55063012886
55071154262
55071279383
55081047846
55090771536
55092686771
55101454153
55112652438
56010687674
56012562728
56020124693
56022748235
56030123235
56030451493
56031979972
56032925484
56040214484
56040558467
56041284774
56042726611
56051673274
56052794215
56060113433
56080351835
56081096359
56081531986
56090238632
56091383584
56092779928
56101611463
56111767158
56112891195
56120131184
57010533392
57021697452
57022412939
57022524634
57030698714
57041043323
57042217956
57070184747
57071483593
57091064264
57092171611
57092788828
57101597173
57101738927
57101858685
57110517249
57110997791
57111379473
57121741123
57121942418
58010716482
58021934176
58030823313
58031249541
58041064792
58041484987
58042285839
58052177948
58061119234
58061685465
58061784331
58081863456
58101149933
58110727847
58113059532
58120583978
58120881762
58121945463
59011956934
59022417679
59030925357
59031353665
59031967565
59032422449
59042551865
59052136379
59080247597
59090526387
59100913154
59101052267
59110287366
60040571227
60050288463
60050661611
60050854257
60052722868
60070176388
60070927489
60071144782
60072192647
60090454697
60090547557
60110697318
60110825296
60111387962
61030411716
61030527941
61030668521
61031748217
61042569999
61050176215
61050368737
61051687329
61061266868
61070645649
61071891179
61090334813
61091731916
61091966532
61110745179
61121237364
62020293547
62041397136
62042228183
62051444457
62062028341
62062229872
62070686762
62072943865
62073144128
62081642827
62091229395
62100992188
62101221421
62111211245
62120135653
62122762857
63011789281
63021217697
63033045873
63041633873
63042576283
63051099654
63053189991
63062774539
63100549646
63103059436
63112056862
63120272755
63120362285
63120789446
63121718238
64040587279
64041291564
64041475733
64042188324
64060259839
64072383999
64072879447
64072994995
64080738198
64082523255
64082626293
64091966441
64091987912
64100543296
64100691227
65011373981
65021053275
65040114922
65041194642
65042225129
65042857627
65042871894
65043084473
65052614964
65052744311
65060615715
65062499533
65072292731
65082716973
65090939627
65100174455
65100255679
65112237261
66020741826
66021624627
66022816162
66041251887
66041667464
66052224539
66070488867
66070662869
66070699476
66070874677
66071668444
66081499571
66090824148
66092111462
66102596838
66103043445
67011732171
67021858164
67022189881
67030845948
67030859396
67051765719
67051886263
67070785572
67071162716
67071515224
67080325621
67091716139
67120542465
67121498352
68010194221
68012353275
68031619662
68041459289
68041598171
68042727684
68050631533
68051283326
68052729496
68062539427
68062652171
68072785614
68082176475
68082717999
68110298379
68111894635
69010854478
69020125649
69022081835
69022389148
69040596344
69050653491
69070593429
69071749461
69080711251
69090188357
69091246441
69111986928
70010295994
70012068473
70012252539
70031959637
70040755259
70061058698
70062095917
70062226485
70071328752
70073187333
70082868438
70092564694
70100742894
70102538693
70102651231
70102884749
70110928431
70111598419
70112434112
71010719231
71020838128
71020883128
71021186213
71041068962
71041121717
71061396511
71062751337
71071879125
71072311567
71080328317
71081133174
71093036469
71100975552
71101714527
71102861457
71103138387
71111386851
71112756439
71121671152
72010379337
72010764535
72011292659
72012311841
72022016433
72030398235
72050777283
72051236499
72053064223
72062353994
72062598513
72062787322
72080886377
72101185876
72110721878
72120731223
72121863367
73030424654
73032339882
73040216995
73050246858
73062328164
73062354916
73062399678
73070836576
73071416182
73071915193
73080225687
73082288471
73082337366
73082834832
73101151511
73110232447
73112042598
73122558937
73122665316
73122689224
74011884982
74012214391
74021668222
74021811323
74030129396
74031065778
74031373978
74031466685
74042991349
74050321332
74061115575
74061875473
74071041734
74081431921
74090415228
74090867766
74091955798
74102316811
74110858233
74111185468
74112917198
74122289278
75011051646
75011447432
75021252413
75021891867
75041947737
75050639485
75051411547
75052376924
75101197995
75102286881
75110592785
75111747221
76020255919
76021263414
76032113795
76032676647
76040276529
76041952367
76041975571
76051176997
76052286378
76061259954
76070488668
76070828828
76072068853
76072497866
76080868838
76092183914
77013078863
77022318516
77032512959
77032842225
77042986847
77042991418
77051422224
77051932642
77060747259
77073117812
77080956615
77081296631
77082575818
77120924611
77121537588
77122641796
78012231583
78012361619
78021147556
78050187668
78052866682
78061254465
78061398949
78081256773
78081299327
78082524185
78083178321
78090788689
78102176691
78110135424
78111744496
78123073326
79011487142
79012813373
79020483164
79032958737
79033046264
79040618676
79041991512
79050378711
79050793888
79051453341
79051939155
79062534732
79081849765
79091449874
79092548978
79101845315
79112429537
79122464689
80020483283
80021764554
80030468894
80030552151
80050743247
80060712637
80070754724
80081335813
80090577912
80091053879
80100397888
80110952754
80123123963
81010672845
81011929373
81020596139
81031123199
81031998139
81041086156
81042062773
81052796479
81053084245
81070967226
81103075678
81120769192
81121262762
81121764967
82010497856
82013114756
82021813382
82032328323
82041038822
82041272662
82060199753
82061258732
82071391728
82072427477
82081422245
82081973314
82100324567
82102328835
82110315498
82111144231
82111677177
83031344316
83042171868
83042183955
83042199312
83042968981
83051263477
83051873823
83061173542
83061316473
83062514993
83070315559
83080128682
83080341838
83081229887
83082749863
83092648934
83100944784
83112765991
83113072687
84010412448
84011997564
84020239851
84021787896
84030724224
84032766417
84040278663
84040478124
84071197496
84072092158
84073056623
84091331641
84092337141
84100799473
84101827865
84110238753
84111478642
84112929673
84121387556
85010731229
85012874571
85030651763
85031518197
85032145682
85041428446
85052486299
85060414916
85060521661
85060595741
85060772753
85061736143
85070491758
85070541637
85082347669
85082634565
85100257426
85102549813
85102993131
85103039364
85110922927
85120783473
85123193884
86010378739
86061056536
86062172336
86070999543
86072247552
86080669544
86081647743
86090157286
86101091141
86101325275
87021149451
87021384643
87032069474
87032837684
87041072212
87041075871
87042532818
87062645295
87070233332
87091035669
87100792743
87102893152
87121458945
87122295468
88010163113
88011986711
88020578431
88021895571
88022791524
88031062871
88032465659
88042935434
88062621841
88071946135
88080578512
88080927231
88090256675
88090376586
88091986788
88101842796
88122464872
88122588329
89012199113
89012777124
89060955189
89071096431
89080281798
89080848764
89102844466
89110662674
89111416548
89121361719
89123165489
90013082418
90013086283
90021325585
90021428172
90030242361
90032725217
90041489494
90050843533
90051991617
90053043121
90061078555
90061768926
90070129475
90071488717
90081772116
90083038799
90110677982
90110834738
90111658412
90112274699
91012519172
91012838291
91021248645
91042535818
91050694129
91051334549
91052596511
91052748895
91061761445
91080226521
91082516541
91092296316
91100589696
91112446938
91120587153
91121793681
92010475918
92012453611
92012614553
92012749554
92020167962
92020451469
92020861927
92022995338
92032383134
92062152393
92062666999
92062951558
92071427569
92080186543
92101483989
92110477265
92122097927
93011862459
93013057729
93021787188
93061846353
93062568137
93070151958
93071866428
93080132817
93082388735
93101933351
93102295825
93110862293
93110964735
93112718882
93120961672
94012135481
94020976735
94022818426
94040572438
94040843677
94050942469
94051085163
94062053162
94080373491
94082144541
94092438483
94101941748
94110428135
94120649335
95011072726
95021842373
95022416256
95041955316
95050313374
95060916295
95062863151
95072059937
95080888767
95081845464
95082272917
95111311615
95111382273
96010151328
96012172941
96022022629
96041318244
96061368951
96070611945
96072418564
96082815164
96091472224
96100418982
96110254727
96121156586
96122842792
97010593372
97011517654
97020365792
97022885746
97032693119
97041897669
97042113135
97052781434
97060693848
97063035687
97072272651
97072554771
97080469737
97082146452
97092314586
97102439625
97102448559
97110812364
97110867166
97123095417
98010845377
98012379137
98012574952
98021456618
98040682238
98041493329
98042888359
98052485458
98062881163
98073061819
98073174461
98080894996
98090949765
98091022546
98091699652
98100374426
98100978644
99010711589
99021555116
99031285221
99031649856
99062535731
99062677572
99071957333
99080167141
99080954868
99081596535
99091355423
99092934755



SET STATISTICS IO ON
SET STATISTICS TIME ON

-- Compare query costs and performance.

-- Find people with pesel 65100174455 from both tables

-- Find people born in year 1965 from both tables 

-- Find people born  in (1991) in may (05) on day (06) in both tables

-- Find people born in year 1965 from both tables using "WHERE pesel in (...)"

