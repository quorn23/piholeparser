#!/bin/bash
## Used in the Parsing Process,,, a bit extreme, but makes the list accurate

## Start the the most popilar
sed -i '/com$/d; /ru$/d; /org$/d; /net$/d; /de$/d; /jp$/d; /uk$/d; /br$/d; /it$/d; /pl$/d; /fr$/d; /in$/d; /ir$/d; /au$/d; /info$/d' $TEMPFILEA

#########################################
## If still contents in file, continue ##
#########################################
HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/nl$/d; /cn$/d; /es$/d; /cz$/d; /kr$/d; /ca$/d; /eu$/d; /ua$/d; /gr$/d; /co$/d; /ro$/d; /za$/d; /ch$/d; /se$/d; /tw$/d; /biz$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/hu$/d; /vn$/d; /mx$/d; /be$/d; /at$/d; /tr$/d; /dk$/d; /tv$/d; /ar$/d; /me$/d; /sk$/d; /no$/d; /us$/d; /fi$/d; /cl$/d; /id$/d; /io$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/xyz$/d; /pt$/d; /by$/d; /il$/d; /ie$/d; /nz$/d; /kz$/d; /lt$/d; /hk$/d; /cc$/d; /my$/d; /sg$/d; /club$/d; /top$/d; /bg$/d; /рф$/d; /edu$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/th$/d; /su$/d; /pk$/d; /hr$/d; /rs$/d; /pro$/d; /si$/d; /lv$/d; /az$/d; /pe$/d; /ae$/d; /ph$/d; /download$/d; /pw$/d; /ee$/d; /ng$/d; /online$/d; /cat$/d; /ve$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/th$/d; /su$/d; /pk$/d; /hr$/d; /rs$/d; /pro$/d; /si$/d; /lv$/d; /az$/d; /pe$/d; /ae$/d; /ph$/d; /download$/d; /pw$/d; /ee$/d; /ng$/d; /online$/d; /cat$/d; /ve$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/mobi$/d; /gov$/d; /tk$/d; /sa$/d; /uz$/d; /ws$/d; /asia$/d; /ma$/d; /lk$/d; /site$/d; /is$/d; /ge$/d; /nu$/d; /lu$/d; /fm$/d; /bd$/d; /xxx$/d; /ba$/d; /to$/d; /am$/d; /uy$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/ec$/d; /ke$/d; /tn$/d; /website$/d; /mk$/d; /do$/d; /name$/d; /md$/d; /mn$/d; /space$/d; /link$/d; /tokyo$/d; /ml$/d; /travel$/d; /ga$/d; /news$/d; /eg$/d; /today$/d; /np$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/la$/d; /py$/d; /bz$/d; /im$/d; /al$/d; /life$/d; /tech$/d; /tz$/d; /kg$/d; /coop$/d; /cr$/d; /gt$/d; /ly$/d; /dz$/d; /bo$/d; /qa$/d; /win$/d; /cf$/d; /cy$/d; /jobs$/d; /ug$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/live$/d; /guru$/d; /media$/d; /click$/d; /sexy$/d; /aero$/d; /li$/d; /pa$/d; /ai$/d; /vc$/d; /world$/d; /tj$/d; /sv$/d; /ag$/d; /jo$/d; /gg$/d; /ao$/d; /one$/d; /rocks$/d; /af$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/ps$/d; /kw$/d; /london$/d; /ovh$/d; /mm$/d; /shop$/d; /agency$/d; /bid$/d; /blog$/d; /work$/d; /cm$/d; /lb$/d; /press$/d; /ninja$/d; /sd$/d; /gh$/d; /digital$/d; /ni$/d; /cu$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/eus$/d; /kh$/d; /nyc$/d; /om$/d; /ci$/d; /video$/d; /center$/d; /mt$/d; /cloud$/d; /mu$/d; /re$/d; /academy$/d; /moe$/d; /gq$/d; /hn$/d; /so$/d; /store$/d; /mo$/d; /rw$/d; /st$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/sy$/d; /global$/d; /zw$/d; /bh$/d; /ac$/d; /sn$/d; /pics$/d; /zone$/d; /red$/d; /tips$/d; /vip$/d; /host$/d; /design$/d; /et$/d; /sh$/d; /wiki$/d; /mz$/d; /iq$/d; /ms$/d; /berlin$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/education$/d; /trade$/d; /tt$/d; /city$/d; /mg$/d; /solutions$/d; /na$/d; /paris$/d; /company$/d; /network$/d; /cx$/d; /zm$/d; /cd$/d; /stream$/d; /bw$/d; /sc$/d; /technology$/d; /social$/d $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/fo$/d; /gs$/d; /bt$/d; /plus$/d; /porn$/d; /guide$/d; /pg$/d; /expert$/d; /bn$/d; /tm$/d; /blue$/d; /studio$/d; /wang$/d; /ad$/d; /as$/d; /moscow$/d; /events$/d; /party$/d; /int$/d; /tools$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/bike$/d; /marketing$/d; /gal$/d; /land$/d; /lol$/d; /men$/d; /mv$/d; /bzh$/d; /jm$/d; /works$/d; /tc$/d; /bf$/d; /directory$/d; /nc$/d; /gl$/d; /pf$/d; /review$/d; /cool$/d; /gratis$/d; /pub$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/help$/d; /audio$/d; /systems$/d; /email$/d; /bio$/d; /gi$/d; /ht$/d; /chat$/d; /bm$/d; /mil$/d; /webcam$/d; /fj$/d; /sm$/d; /sx$/d; /gdn$/d; /market$/d; /tl$/d; /community$/d; /watch$/d; /love$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/services$/d; /sex$/d; /support$/d; /cash$/d; /pink$/d; /school$/d; /science$/d; /tf$/d; /mr$/d; /pm$/d; /photos$/d; /buzz$/d; /reviews$/d; /scot$/d; /team$/d; /codes$/d; /bank$/d; /date$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/gy$/d; /mc$/d; /photo$/d; /run$/d; /dj$/d; /international$/d; /wtf$/d; /photography$/d; /report$/d; /bet$/d; /ky$/d; /money$/d; /pr$/d; /gallery$/d; /games$/d; /group$/d; /ink$/d; /bi$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/ren$/d; /brussels$/d; /movie$/d; /software$/d; /training$/d; /careers$/d; /mw$/d; /fit$/d; /istanbul$/d; /racing$/d; /church$/d; /gd$/d; /je$/d; /ltd$/d; /vg$/d; /camp$/d; /house$/d; /taipei$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/kim$/d; /wien$/d; /ye$/d; /black$/d; /coffee$/d; /farm$/d; /okinawa$/d; /онлайн$/d; /cafe$/d; /care$/d; /deals$/d; /fun$/d; /casino$/d; /nagoya$/d; /vu$/d; /бел$/d; /укр$/d; /sr$/d; /style$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/yt$/d; /cv$/d; /vision$/d; /hosting$/d; /swiss$/d; /tel$/d; /direct$/d; /ngo$/d; /university$/d; /business$/d; /faith$/d; /loan$/d; /sl$/d; /dm$/d; /domains$/d; /institute$/d; /lc$/d; /museum$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/wales$/d; /bb$/d; /energy$/d; /ooo$/d; /ventures$/d; /amsterdam$/d; /gift$/d; /dating$/d; /place$/d; /tube$/d; /beer$/d; /cards$/d; /fund$/d; /show$/d; /uno$/d; /exchange$/d; /express$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/foundation$/d; /hamburg$/d; /pictures$/d; /ax$/d; /nrw$/d; /poker$/d; /sz$/d; /рус$/d; /bar$/d; /camera$/d; /dog$/d; /earth$/d; /ls$/d; /yokohama$/d; /москва$/d; /boutique$/d; /clothing$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/fitness$/d; /immo$/d; /jetzt$/d; /kiwi$/d; /barcelona$/d; /delivery$/d; /ist$/d; /kitchen$/d; /menu$/d; /partners$/d; /town$/d; /va$/d; /bayern$/d; /koeln$/d; /parts$/d; /sale$/d; /solar$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/tg$/d; /bj$/d; /tienda$/d; /graphics$/d; /quebec$/d; /clinic$/d; /cricket$/d; /desi$/d; /fashion$/d; /law$/d; /sb$/d; /taxi$/d; /toys$/d; /コム$/d; /bs$/d; /engineering$/d; /moda$/d; /移动$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/gp$/d; /restaurant$/d; /vegas$/d; /wf$/d; /xin$/d; /consulting$/d; /cw$/d; /finance$/d; /gm$/d; /rip$/d; /shoes$/d; /capital$/d; /film$/d; /fish$/d; /game$/d; /green$/d; /onl$/d; /singles$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/best$/d; /build$/d; /cg$/d; /coach$/d; /ne$/d; /wedding$/d; /art$/d; /estate$/d; /fyi$/d; /glass$/d; /rio$/d; /tours$/d; /accountant$/d; /adult$/d; /archi$/d; /football$/d; /kp$/d; /kyoto$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/lat$/d; /legal$/d; /sydney$/d; /band$/d; /bnpparibas$/d; /computer$/d; /dance$/d; /futbol$/d; /gold$/d; /pet$/d; /rentals$/d; /rest$/d; /ski$/d; /tirol$/d; /yoga$/d; /cam$/d; /how$/d; /pn$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/recipes$/d; /surf$/d; /lr$/d; /repair$/d; /орг$/d; /abbott$/d; /auction$/d; /cab$/d; /gop$/d; /lighting$/d; /pizza$/d; /supply$/d; /vote$/d; /сайт$/d; /aw$/d; /college$/d; /melbourne$/d; /osaka$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/rent$/d; /viajes$/d; /casa$/d; /ck$/d; /cymru$/d; /exposed$/d; /golf$/d; /hm$/d; /holiday$/d; /leclerc$/d; /properties$/d; /study$/d; /tax$/d; /vet$/d; /alsace$/d; /credit$/d; /dental$/d; /diet$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/family$/d; /gent$/d; /haus$/d; /holdings$/d; /horse$/d; /kaufen$/d; /miami$/d; /ong$/d; /realtor$/d; /ruhr$/d; /saarland$/d; /srl$/d; /한국$/d; /aq$/d; /bible$/d; /capetown$/d; /ceo$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/corsica$/d; /insure$/d; /limited$/d; /promo$/d; /theater$/d; /villas$/d; /vlaanderen$/d; /voyage$/d; /ДЕТИ$/d; /builders$/d; /cern$/d; /cheap$/d; /discount$/d; /fishing$/d; /gmbh$/d; /jewelry$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/mp$/d; /mq$/d; /post$/d; /productions$/d; /reisen$/d; /sener$/d; /wine$/d; /中国$/d; /auto$/d; /bargains$/d; /equipment$/d; /financial$/d; /garden$/d; /gifts$/d; /gn$/d; /google$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/healthcare$/d; /hiphop$/d; /irish$/d; /joburg$/d; /ki$/d; /kn$/d; /lawyer$/d; /schule$/d; /shopping$/d; /soy$/d; /supplies$/d; /tattoo$/d; /vi$/d; /みんな$/d; /army$/d; /bradesco$/d; /cars$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/fail$/d; /frl$/d; /jcb$/d; /juegos$/d; /kred$/d; /lgbt$/d; /management$/d; /mba$/d; /ryukyu$/d; /بازار$/d; /afl$/d; /associates$/d; /claims$/d; /cleaning$/d; /cologne$/d; /cooking$/d; /coupons$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/diamonds$/d; /fage$/d; /fans$/d; /flights$/d; /forsale$/d; /furniture$/d; /gf$/d; /guitars$/d; /immobilien$/d; /investments$/d; /komatsu$/d; /krd$/d; /loans$/d; /pharmacy$/d; /shiksha$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/td$/d; /vodka$/d; /attorney$/d; /blackfriday$/d; /car$/d; /citic$/d; /dnp$/d; /eco$/d; /gu$/d; /limo$/d; /luxury$/d; /maison$/d; /praxi$/d; /property$/d; /reise$/d; /vin$/d; /信息$/d; /我爱你$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/apartments$/d; /aws$/d; /axa$/d; /barclaycard$/d; /barclays$/d; /bingo$/d; /cancerresearch$/d; /career$/d; /christmas$/d; /country$/d; /courses$/d; /enterprises$/d; /fk$/d; /florist$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/gives$/d; /hitachi$/d; /monash$/d; /mortgage$/d; /nr$/d; /rodeo$/d; /saxo$/d; /sucks$/d; /tatar$/d; /tickets$/d; /toray$/d; /vacations$/d; /срб$/d; /شبكة$/d; /香港$/d; /닷넷$/d; /aco$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/audi$/d; /canon$/d; /condos$/d; /construction$/d; /contractors$/d; /cruises$/d; /dhl$/d; /emerck$/d; /engineer$/d; /flowers$/d; /hiv$/d; /hockey$/d; /industries$/d; /km$/d; /lidl$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/ltda$/d; /markets$/d; /mini$/d; /neustar$/d; /nf$/d; /nico$/d; /organic$/d; /pictet$/d; /pioneer$/d; /plumbing$/d; /rehab$/d; /sandvik$/d; /scb$/d; /schmidt$/d; /sony$/d; /swatch$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/theatre$/d; /whoswho$/d; /yandex$/d; /қаз$/d; /قطر$/d; /भारत$/d; /বাংলা$/d; /닷컴$/d; /abb$/d; /airforce$/d; /aquarelle$/d; /basketball$/d; /bmw$/d; /bridgestone$/d; /catering$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/cfa$/d; /creditcard$/d; /crs$/d; /degree$/d; /dentist$/d; /durban$/d; /dvag$/d; /edeka$/d; /erni$/d; /everbank$/d; /foo$/d; /frogans$/d; /globo$/d; /goog$/d; /gw$/d; /java$/d; /jll$/d; /kinder$/d;' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/latrobe$/d; /lease$/d; /mma$/d; /mom$/d; /motorcycles$/d; /nadex$/d; /navy$/d; /ntt$/d; /physio$/d; /reit$/d; /republican$/d; /rich$/d; /ricoh$/d; /salon$/d; /sarl$/d; /sbi$/d; /soccer$/d' $TEMPFILEA
fi

HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
sed -i '/tennis$/d; /tires$/d; /trading$/d; /trust$/d; /voting$/d; /voto$/d; /weir$/d; /հայ$/d; /امارات$/d; /تونس$/d; /موقع$/d; /ไทย$/d; /公司$/d; /台灣$/d; /在线$/d' $TEMPFILEA
fi

##  unset
unset STOPTLDSEARCH
