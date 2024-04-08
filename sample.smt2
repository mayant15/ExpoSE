(declare-fun X () String)
(declare-fun str.charCodeAt (String Int) Int)

(assert (= (to_real (str.charCodeAt X 2)) 109.0))

(model-add str.charCodeAt
           ((x!1 String) (x!2 Int))
           Int
           (let ((a!1 (ite (= (str.at x!1 x!2) (str.from_code 254))
                           254
                           (ite (= (str.at x!1 x!2) (str.from_code 255))
                                255
                                (- 1)))))
           (let ((a!2 (ite (= (str.at x!1 x!2) (str.from_code 252))
                           252
                           (ite (= (str.at x!1 x!2) (str.from_code 253))
                                253
                                a!1))))
           (let ((a!3 (ite (= (str.at x!1 x!2) (str.from_code 250))
                           250
                           (ite (= (str.at x!1 x!2) (str.from_code 251))
                                251
                                a!2))))
           (let ((a!4 (ite (= (str.at x!1 x!2) (str.from_code 248))
                           248
                           (ite (= (str.at x!1 x!2) (str.from_code 249))
                                249
                                a!3))))
           (let ((a!5 (ite (= (str.at x!1 x!2) (str.from_code 246))
                           246
                           (ite (= (str.at x!1 x!2) (str.from_code 247))
                                247
                                a!4))))
           (let ((a!6 (ite (= (str.at x!1 x!2) (str.from_code 244))
                           244
                           (ite (= (str.at x!1 x!2) (str.from_code 245))
                                245
                                a!5))))
           (let ((a!7 (ite (= (str.at x!1 x!2) (str.from_code 242))
                           242
                           (ite (= (str.at x!1 x!2) (str.from_code 243))
                                243
                                a!6))))
           (let ((a!8 (ite (= (str.at x!1 x!2) (str.from_code 240))
                           240
                           (ite (= (str.at x!1 x!2) (str.from_code 241))
                                241
                                a!7))))
           (let ((a!9 (ite (= (str.at x!1 x!2) (str.from_code 238))
                           238
                           (ite (= (str.at x!1 x!2) (str.from_code 239))
                                239
                                a!8))))
           (let ((a!10 (ite (= (str.at x!1 x!2) (str.from_code 236))
                            236
                            (ite (= (str.at x!1 x!2) (str.from_code 237))
                                 237
                                 a!9))))
           (let ((a!11 (ite (= (str.at x!1 x!2) (str.from_code 234))
                            234
                            (ite (= (str.at x!1 x!2) (str.from_code 235))
                                 235
                                 a!10))))
           (let ((a!12 (ite (= (str.at x!1 x!2) (str.from_code 232))
                            232
                            (ite (= (str.at x!1 x!2) (str.from_code 233))
                                 233
                                 a!11))))
           (let ((a!13 (ite (= (str.at x!1 x!2) (str.from_code 230))
                            230
                            (ite (= (str.at x!1 x!2) (str.from_code 231))
                                 231
                                 a!12))))
           (let ((a!14 (ite (= (str.at x!1 x!2) (str.from_code 228))
                            228
                            (ite (= (str.at x!1 x!2) (str.from_code 229))
                                 229
                                 a!13))))
           (let ((a!15 (ite (= (str.at x!1 x!2) (str.from_code 226))
                            226
                            (ite (= (str.at x!1 x!2) (str.from_code 227))
                                 227
                                 a!14))))
           (let ((a!16 (ite (= (str.at x!1 x!2) (str.from_code 224))
                            224
                            (ite (= (str.at x!1 x!2) (str.from_code 225))
                                 225
                                 a!15))))
           (let ((a!17 (ite (= (str.at x!1 x!2) (str.from_code 222))
                            222
                            (ite (= (str.at x!1 x!2) (str.from_code 223))
                                 223
                                 a!16))))
           (let ((a!18 (ite (= (str.at x!1 x!2) (str.from_code 220))
                            220
                            (ite (= (str.at x!1 x!2) (str.from_code 221))
                                 221
                                 a!17))))
           (let ((a!19 (ite (= (str.at x!1 x!2) (str.from_code 218))
                            218
                            (ite (= (str.at x!1 x!2) (str.from_code 219))
                                 219
                                 a!18))))
           (let ((a!20 (ite (= (str.at x!1 x!2) (str.from_code 216))
                            216
                            (ite (= (str.at x!1 x!2) (str.from_code 217))
                                 217
                                 a!19))))
           (let ((a!21 (ite (= (str.at x!1 x!2) (str.from_code 214))
                            214
                            (ite (= (str.at x!1 x!2) (str.from_code 215))
                                 215
                                 a!20))))
           (let ((a!22 (ite (= (str.at x!1 x!2) (str.from_code 212))
                            212
                            (ite (= (str.at x!1 x!2) (str.from_code 213))
                                 213
                                 a!21))))
           (let ((a!23 (ite (= (str.at x!1 x!2) (str.from_code 210))
                            210
                            (ite (= (str.at x!1 x!2) (str.from_code 211))
                                 211
                                 a!22))))
           (let ((a!24 (ite (= (str.at x!1 x!2) (str.from_code 208))
                            208
                            (ite (= (str.at x!1 x!2) (str.from_code 209))
                                 209
                                 a!23))))
           (let ((a!25 (ite (= (str.at x!1 x!2) (str.from_code 206))
                            206
                            (ite (= (str.at x!1 x!2) (str.from_code 207))
                                 207
                                 a!24))))
           (let ((a!26 (ite (= (str.at x!1 x!2) (str.from_code 204))
                            204
                            (ite (= (str.at x!1 x!2) (str.from_code 205))
                                 205
                                 a!25))))
           (let ((a!27 (ite (= (str.at x!1 x!2) (str.from_code 202))
                            202
                            (ite (= (str.at x!1 x!2) (str.from_code 203))
                                 203
                                 a!26))))
           (let ((a!28 (ite (= (str.at x!1 x!2) (str.from_code 200))
                            200
                            (ite (= (str.at x!1 x!2) (str.from_code 201))
                                 201
                                 a!27))))
           (let ((a!29 (ite (= (str.at x!1 x!2) (str.from_code 198))
                            198
                            (ite (= (str.at x!1 x!2) (str.from_code 199))
                                 199
                                 a!28))))
           (let ((a!30 (ite (= (str.at x!1 x!2) (str.from_code 196))
                            196
                            (ite (= (str.at x!1 x!2) (str.from_code 197))
                                 197
                                 a!29))))
           (let ((a!31 (ite (= (str.at x!1 x!2) (str.from_code 194))
                            194
                            (ite (= (str.at x!1 x!2) (str.from_code 195))
                                 195
                                 a!30))))
           (let ((a!32 (ite (= (str.at x!1 x!2) (str.from_code 192))
                            192
                            (ite (= (str.at x!1 x!2) (str.from_code 193))
                                 193
                                 a!31))))
           (let ((a!33 (ite (= (str.at x!1 x!2) (str.from_code 190))
                            190
                            (ite (= (str.at x!1 x!2) (str.from_code 191))
                                 191
                                 a!32))))
           (let ((a!34 (ite (= (str.at x!1 x!2) (str.from_code 188))
                            188
                            (ite (= (str.at x!1 x!2) (str.from_code 189))
                                 189
                                 a!33))))
           (let ((a!35 (ite (= (str.at x!1 x!2) (str.from_code 186))
                            186
                            (ite (= (str.at x!1 x!2) (str.from_code 187))
                                 187
                                 a!34))))
           (let ((a!36 (ite (= (str.at x!1 x!2) (str.from_code 184))
                            184
                            (ite (= (str.at x!1 x!2) (str.from_code 185))
                                 185
                                 a!35))))
           (let ((a!37 (ite (= (str.at x!1 x!2) (str.from_code 182))
                            182
                            (ite (= (str.at x!1 x!2) (str.from_code 183))
                                 183
                                 a!36))))
           (let ((a!38 (ite (= (str.at x!1 x!2) (str.from_code 180))
                            180
                            (ite (= (str.at x!1 x!2) (str.from_code 181))
                                 181
                                 a!37))))
           (let ((a!39 (ite (= (str.at x!1 x!2) (str.from_code 178))
                            178
                            (ite (= (str.at x!1 x!2) (str.from_code 179))
                                 179
                                 a!38))))
           (let ((a!40 (ite (= (str.at x!1 x!2) (str.from_code 176))
                            176
                            (ite (= (str.at x!1 x!2) (str.from_code 177))
                                 177
                                 a!39))))
           (let ((a!41 (ite (= (str.at x!1 x!2) (str.from_code 174))
                            174
                            (ite (= (str.at x!1 x!2) (str.from_code 175))
                                 175
                                 a!40))))
           (let ((a!42 (ite (= (str.at x!1 x!2) (str.from_code 172))
                            172
                            (ite (= (str.at x!1 x!2) (str.from_code 173))
                                 173
                                 a!41))))
           (let ((a!43 (ite (= (str.at x!1 x!2) (str.from_code 170))
                            170
                            (ite (= (str.at x!1 x!2) (str.from_code 171))
                                 171
                                 a!42))))
           (let ((a!44 (ite (= (str.at x!1 x!2) (str.from_code 168))
                            168
                            (ite (= (str.at x!1 x!2) (str.from_code 169))
                                 169
                                 a!43))))
           (let ((a!45 (ite (= (str.at x!1 x!2) (str.from_code 166))
                            166
                            (ite (= (str.at x!1 x!2) (str.from_code 167))
                                 167
                                 a!44))))
           (let ((a!46 (ite (= (str.at x!1 x!2) (str.from_code 164))
                            164
                            (ite (= (str.at x!1 x!2) (str.from_code 165))
                                 165
                                 a!45))))
           (let ((a!47 (ite (= (str.at x!1 x!2) (str.from_code 162))
                            162
                            (ite (= (str.at x!1 x!2) (str.from_code 163))
                                 163
                                 a!46))))
           (let ((a!48 (ite (= (str.at x!1 x!2) (str.from_code 160))
                            160
                            (ite (= (str.at x!1 x!2) (str.from_code 161))
                                 161
                                 a!47))))
           (let ((a!49 (ite (= (str.at x!1 x!2) (str.from_code 158))
                            158
                            (ite (= (str.at x!1 x!2) (str.from_code 159))
                                 159
                                 a!48))))
           (let ((a!50 (ite (= (str.at x!1 x!2) (str.from_code 156))
                            156
                            (ite (= (str.at x!1 x!2) (str.from_code 157))
                                 157
                                 a!49))))
           (let ((a!51 (ite (= (str.at x!1 x!2) (str.from_code 154))
                            154
                            (ite (= (str.at x!1 x!2) (str.from_code 155))
                                 155
                                 a!50))))
           (let ((a!52 (ite (= (str.at x!1 x!2) (str.from_code 152))
                            152
                            (ite (= (str.at x!1 x!2) (str.from_code 153))
                                 153
                                 a!51))))
           (let ((a!53 (ite (= (str.at x!1 x!2) (str.from_code 150))
                            150
                            (ite (= (str.at x!1 x!2) (str.from_code 151))
                                 151
                                 a!52))))
           (let ((a!54 (ite (= (str.at x!1 x!2) (str.from_code 148))
                            148
                            (ite (= (str.at x!1 x!2) (str.from_code 149))
                                 149
                                 a!53))))
           (let ((a!55 (ite (= (str.at x!1 x!2) (str.from_code 146))
                            146
                            (ite (= (str.at x!1 x!2) (str.from_code 147))
                                 147
                                 a!54))))
           (let ((a!56 (ite (= (str.at x!1 x!2) (str.from_code 144))
                            144
                            (ite (= (str.at x!1 x!2) (str.from_code 145))
                                 145
                                 a!55))))
           (let ((a!57 (ite (= (str.at x!1 x!2) (str.from_code 142))
                            142
                            (ite (= (str.at x!1 x!2) (str.from_code 143))
                                 143
                                 a!56))))
           (let ((a!58 (ite (= (str.at x!1 x!2) (str.from_code 140))
                            140
                            (ite (= (str.at x!1 x!2) (str.from_code 141))
                                 141
                                 a!57))))
           (let ((a!59 (ite (= (str.at x!1 x!2) (str.from_code 138))
                            138
                            (ite (= (str.at x!1 x!2) (str.from_code 139))
                                 139
                                 a!58))))
           (let ((a!60 (ite (= (str.at x!1 x!2) (str.from_code 136))
                            136
                            (ite (= (str.at x!1 x!2) (str.from_code 137))
                                 137
                                 a!59))))
           (let ((a!61 (ite (= (str.at x!1 x!2) (str.from_code 134))
                            134
                            (ite (= (str.at x!1 x!2) (str.from_code 135))
                                 135
                                 a!60))))
           (let ((a!62 (ite (= (str.at x!1 x!2) (str.from_code 132))
                            132
                            (ite (= (str.at x!1 x!2) (str.from_code 133))
                                 133
                                 a!61))))
           (let ((a!63 (ite (= (str.at x!1 x!2) (str.from_code 130))
                            130
                            (ite (= (str.at x!1 x!2) (str.from_code 131))
                                 131
                                 a!62))))
           (let ((a!64 (ite (= (str.at x!1 x!2) (str.from_code 128))
                            128
                            (ite (= (str.at x!1 x!2) (str.from_code 129))
                                 129
                                 a!63))))
           (let ((a!65 (ite (= (str.at x!1 x!2) (str.from_code 126))
                            126
                            (ite (= (str.at x!1 x!2) (str.from_code 127))
                                 127
                                 a!64))))
           (let ((a!66 (ite (= (str.at x!1 x!2) (str.from_code 124))
                            124
                            (ite (= (str.at x!1 x!2) (str.from_code 125))
                                 125
                                 a!65))))
           (let ((a!67 (ite (= (str.at x!1 x!2) (str.from_code 122))
                            122
                            (ite (= (str.at x!1 x!2) (str.from_code 123))
                                 123
                                 a!66))))
           (let ((a!68 (ite (= (str.at x!1 x!2) (str.from_code 120))
                            120
                            (ite (= (str.at x!1 x!2) (str.from_code 121))
                                 121
                                 a!67))))
           (let ((a!69 (ite (= (str.at x!1 x!2) (str.from_code 118))
                            118
                            (ite (= (str.at x!1 x!2) (str.from_code 119))
                                 119
                                 a!68))))
           (let ((a!70 (ite (= (str.at x!1 x!2) (str.from_code 116))
                            116
                            (ite (= (str.at x!1 x!2) (str.from_code 117))
                                 117
                                 a!69))))
           (let ((a!71 (ite (= (str.at x!1 x!2) (str.from_code 114))
                            114
                            (ite (= (str.at x!1 x!2) (str.from_code 115))
                                 115
                                 a!70))))
           (let ((a!72 (ite (= (str.at x!1 x!2) (str.from_code 112))
                            112
                            (ite (= (str.at x!1 x!2) (str.from_code 113))
                                 113
                                 a!71))))
           (let ((a!73 (ite (= (str.at x!1 x!2) (str.from_code 110))
                            110
                            (ite (= (str.at x!1 x!2) (str.from_code 111))
                                 111
                                 a!72))))
           (let ((a!74 (ite (= (str.at x!1 x!2) (str.from_code 108))
                            108
                            (ite (= (str.at x!1 x!2) (str.from_code 109))
                                 109
                                 a!73))))
           (let ((a!75 (ite (= (str.at x!1 x!2) (str.from_code 106))
                            106
                            (ite (= (str.at x!1 x!2) (str.from_code 107))
                                 107
                                 a!74))))
           (let ((a!76 (ite (= (str.at x!1 x!2) (str.from_code 104))
                            104
                            (ite (= (str.at x!1 x!2) (str.from_code 105))
                                 105
                                 a!75))))
           (let ((a!77 (ite (= (str.at x!1 x!2) (str.from_code 102))
                            102
                            (ite (= (str.at x!1 x!2) (str.from_code 103))
                                 103
                                 a!76))))
           (let ((a!78 (ite (= (str.at x!1 x!2) (str.from_code 100))
                            100
                            (ite (= (str.at x!1 x!2) (str.from_code 101))
                                 101
                                 a!77))))
           (let ((a!79 (ite (= (str.at x!1 x!2) (str.from_code 98))
                            98
                            (ite (= (str.at x!1 x!2) (str.from_code 99))
                                 99
                                 a!78))))
           (let ((a!80 (ite (= (str.at x!1 x!2) (str.from_code 96))
                            96
                            (ite (= (str.at x!1 x!2) (str.from_code 97))
                                 97
                                 a!79))))
           (let ((a!81 (ite (= (str.at x!1 x!2) (str.from_code 94))
                            94
                            (ite (= (str.at x!1 x!2) (str.from_code 95))
                                 95
                                 a!80))))
           (let ((a!82 (ite (= (str.at x!1 x!2) (str.from_code 92))
                            92
                            (ite (= (str.at x!1 x!2) (str.from_code 93))
                                 93
                                 a!81))))
           (let ((a!83 (ite (= (str.at x!1 x!2) (str.from_code 90))
                            90
                            (ite (= (str.at x!1 x!2) (str.from_code 91))
                                 91
                                 a!82))))
           (let ((a!84 (ite (= (str.at x!1 x!2) (str.from_code 88))
                            88
                            (ite (= (str.at x!1 x!2) (str.from_code 89))
                                 89
                                 a!83))))
           (let ((a!85 (ite (= (str.at x!1 x!2) (str.from_code 86))
                            86
                            (ite (= (str.at x!1 x!2) (str.from_code 87))
                                 87
                                 a!84))))
           (let ((a!86 (ite (= (str.at x!1 x!2) (str.from_code 84))
                            84
                            (ite (= (str.at x!1 x!2) (str.from_code 85))
                                 85
                                 a!85))))
           (let ((a!87 (ite (= (str.at x!1 x!2) (str.from_code 82))
                            82
                            (ite (= (str.at x!1 x!2) (str.from_code 83))
                                 83
                                 a!86))))
           (let ((a!88 (ite (= (str.at x!1 x!2) (str.from_code 80))
                            80
                            (ite (= (str.at x!1 x!2) (str.from_code 81))
                                 81
                                 a!87))))
           (let ((a!89 (ite (= (str.at x!1 x!2) (str.from_code 78))
                            78
                            (ite (= (str.at x!1 x!2) (str.from_code 79))
                                 79
                                 a!88))))
           (let ((a!90 (ite (= (str.at x!1 x!2) (str.from_code 76))
                            76
                            (ite (= (str.at x!1 x!2) (str.from_code 77))
                                 77
                                 a!89))))
           (let ((a!91 (ite (= (str.at x!1 x!2) (str.from_code 74))
                            74
                            (ite (= (str.at x!1 x!2) (str.from_code 75))
                                 75
                                 a!90))))
           (let ((a!92 (ite (= (str.at x!1 x!2) (str.from_code 72))
                            72
                            (ite (= (str.at x!1 x!2) (str.from_code 73))
                                 73
                                 a!91))))
           (let ((a!93 (ite (= (str.at x!1 x!2) (str.from_code 70))
                            70
                            (ite (= (str.at x!1 x!2) (str.from_code 71))
                                 71
                                 a!92))))
           (let ((a!94 (ite (= (str.at x!1 x!2) (str.from_code 68))
                            68
                            (ite (= (str.at x!1 x!2) (str.from_code 69))
                                 69
                                 a!93))))
           (let ((a!95 (ite (= (str.at x!1 x!2) (str.from_code 66))
                            66
                            (ite (= (str.at x!1 x!2) (str.from_code 67))
                                 67
                                 a!94))))
           (let ((a!96 (ite (= (str.at x!1 x!2) (str.from_code 64))
                            64
                            (ite (= (str.at x!1 x!2) (str.from_code 65))
                                 65
                                 a!95))))
           (let ((a!97 (ite (= (str.at x!1 x!2) (str.from_code 62))
                            62
                            (ite (= (str.at x!1 x!2) (str.from_code 63))
                                 63
                                 a!96))))
           (let ((a!98 (ite (= (str.at x!1 x!2) (str.from_code 60))
                            60
                            (ite (= (str.at x!1 x!2) (str.from_code 61))
                                 61
                                 a!97))))
           (let ((a!99 (ite (= (str.at x!1 x!2) (str.from_code 58))
                            58
                            (ite (= (str.at x!1 x!2) (str.from_code 59))
                                 59
                                 a!98))))
           (let ((a!100 (ite (= (str.at x!1 x!2) (str.from_code 56))
                             56
                             (ite (= (str.at x!1 x!2) (str.from_code 57))
                                  57
                                  a!99))))
           (let ((a!101 (ite (= (str.at x!1 x!2) (str.from_code 54))
                             54
                             (ite (= (str.at x!1 x!2) (str.from_code 55))
                                  55
                                  a!100))))
           (let ((a!102 (ite (= (str.at x!1 x!2) (str.from_code 52))
                             52
                             (ite (= (str.at x!1 x!2) (str.from_code 53))
                                  53
                                  a!101))))
           (let ((a!103 (ite (= (str.at x!1 x!2) (str.from_code 50))
                             50
                             (ite (= (str.at x!1 x!2) (str.from_code 51))
                                  51
                                  a!102))))
           (let ((a!104 (ite (= (str.at x!1 x!2) (str.from_code 48))
                             48
                             (ite (= (str.at x!1 x!2) (str.from_code 49))
                                  49
                                  a!103))))
           (let ((a!105 (ite (= (str.at x!1 x!2) (str.from_code 46))
                             46
                             (ite (= (str.at x!1 x!2) (str.from_code 47))
                                  47
                                  a!104))))
           (let ((a!106 (ite (= (str.at x!1 x!2) (str.from_code 44))
                             44
                             (ite (= (str.at x!1 x!2) (str.from_code 45))
                                  45
                                  a!105))))
           (let ((a!107 (ite (= (str.at x!1 x!2) (str.from_code 42))
                             42
                             (ite (= (str.at x!1 x!2) (str.from_code 43))
                                  43
                                  a!106))))
           (let ((a!108 (ite (= (str.at x!1 x!2) (str.from_code 40))
                             40
                             (ite (= (str.at x!1 x!2) (str.from_code 41))
                                  41
                                  a!107))))
           (let ((a!109 (ite (= (str.at x!1 x!2) (str.from_code 38))
                             38
                             (ite (= (str.at x!1 x!2) (str.from_code 39))
                                  39
                                  a!108))))
           (let ((a!110 (ite (= (str.at x!1 x!2) (str.from_code 36))
                             36
                             (ite (= (str.at x!1 x!2) (str.from_code 37))
                                  37
                                  a!109))))
           (let ((a!111 (ite (= (str.at x!1 x!2) (str.from_code 34))
                             34
                             (ite (= (str.at x!1 x!2) (str.from_code 35))
                                  35
                                  a!110))))
           (let ((a!112 (ite (= (str.at x!1 x!2) (str.from_code 32))
                             32
                             (ite (= (str.at x!1 x!2) (str.from_code 33))
                                  33
                                  a!111))))
           (let ((a!113 (ite (= (str.at x!1 x!2) (str.from_code 30))
                             30
                             (ite (= (str.at x!1 x!2) (str.from_code 31))
                                  31
                                  a!112))))
           (let ((a!114 (ite (= (str.at x!1 x!2) (str.from_code 28))
                             28
                             (ite (= (str.at x!1 x!2) (str.from_code 29))
                                  29
                                  a!113))))
           (let ((a!115 (ite (= (str.at x!1 x!2) (str.from_code 26))
                             26
                             (ite (= (str.at x!1 x!2) (str.from_code 27))
                                  27
                                  a!114))))
           (let ((a!116 (ite (= (str.at x!1 x!2) (str.from_code 24))
                             24
                             (ite (= (str.at x!1 x!2) (str.from_code 25))
                                  25
                                  a!115))))
           (let ((a!117 (ite (= (str.at x!1 x!2) (str.from_code 22))
                             22
                             (ite (= (str.at x!1 x!2) (str.from_code 23))
                                  23
                                  a!116))))
           (let ((a!118 (ite (= (str.at x!1 x!2) (str.from_code 20))
                             20
                             (ite (= (str.at x!1 x!2) (str.from_code 21))
                                  21
                                  a!117))))
           (let ((a!119 (ite (= (str.at x!1 x!2) (str.from_code 18))
                             18
                             (ite (= (str.at x!1 x!2) (str.from_code 19))
                                  19
                                  a!118))))
           (let ((a!120 (ite (= (str.at x!1 x!2) (str.from_code 16))
                             16
                             (ite (= (str.at x!1 x!2) (str.from_code 17))
                                  17
                                  a!119))))
           (let ((a!121 (ite (= (str.at x!1 x!2) (str.from_code 14))
                             14
                             (ite (= (str.at x!1 x!2) (str.from_code 15))
                                  15
                                  a!120))))
           (let ((a!122 (ite (= (str.at x!1 x!2) (str.from_code 12))
                             12
                             (ite (= (str.at x!1 x!2) (str.from_code 13))
                                  13
                                  a!121))))
           (let ((a!123 (ite (= (str.at x!1 x!2) (str.from_code 10))
                             10
                             (ite (= (str.at x!1 x!2) (str.from_code 11))
                                  11
                                  a!122))))
           (let ((a!124 (ite (= (str.at x!1 x!2) (str.from_code 8))
                             8
                             (ite (= (str.at x!1 x!2) (str.from_code 9))
                                  9
                                  a!123))))
           (let ((a!125 (ite (= (str.at x!1 x!2) (str.from_code 6))
                             6
                             (ite (= (str.at x!1 x!2) (str.from_code 7))
                                  7
                                  a!124))))
           (let ((a!126 (ite (= (str.at x!1 x!2) (str.from_code 4))
                             4
                             (ite (= (str.at x!1 x!2) (str.from_code 5))
                                  5
                                  a!125))))
           (let ((a!127 (ite (= (str.at x!1 x!2) (str.from_code 2))
                             2
                             (ite (= (str.at x!1 x!2) (str.from_code 3))
                                  3
                                  a!126))))
             (ite (= (str.at x!1 x!2) (str.from_code 0))
                  0
                  (ite (= (str.at x!1 x!2) (str.from_code 1)) 1 a!127))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)
(get-model)
