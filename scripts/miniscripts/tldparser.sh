#!/bin/bash
## Used in the Parsing Process,,, a bit extreme, but makes the list accurate

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

## Start the the most popilar
cat $TEMPFILEA | sed '/com$/Id; /ru$/Id; /org$/Id; /net$/Id; /de$/Id; /jp$/Id; /uk$/Id; /br$/Id; /it$/Id; /pl$/Id; /fr$/Id; /in$/Id; /ir$/Id; /au$/Id; /info$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA

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
cat $TEMPFILEA | sed '/nl$/Id; /cn$/Id; /es$/Id; /cz$/Id; /kr$/Id; /ca$/Id; /eu$/Id; /ua$/Id; /gr$/Id; /co$/Id; /ro$/Id; /za$/Id; /ch$/Id; /se$/Id; /tw$/Id; /biz$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/hu$/Id; /vn$/Id; /mx$/Id; /be$/Id; /at$/Id; /tr$/Id; /dk$/Id; /tv$/Id; /ar$/Id; /me$/Id; /sk$/Id; /no$/Id; /us$/Id; /fi$/Id; /cl$/Id; /id$/Id; /io$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/xyz$/Id; /pt$/Id; /by$/Id; /il$/Id; /ie$/Id; /nz$/Id; /kz$/Id; /lt$/Id; /hk$/Id; /cc$/Id; /my$/Id; /sg$/Id; /club$/Id; /top$/Id; /bg$/Id; /рф$/Id; /edu$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/th$/Id; /su$/Id; /pk$/Id; /hr$/Id; /rs$/Id; /pro$/Id; /si$/Id; /lv$/Id; /az$/Id; /pe$/Id; /ae$/Id; /ph$/Id; /download$/Id; /pw$/Id; /ee$/Id; /ng$/Id; /online$/Id; /cat$/Id; /ve$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/th$/Id; /su$/Id; /pk$/Id; /hr$/Id; /rs$/Id; /pro$/Id; /si$/Id; /lv$/Id; /az$/Id; /pe$/Id; /ae$/Id; /ph$/Id; /download$/Id; /pw$/Id; /ee$/Id; /ng$/Id; /online$/Id; /cat$/Id; /ve$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/mobi$/Id; /gov$/Id; /tk$/Id; /sa$/Id; /uz$/Id; /ws$/Id; /asia$/Id; /ma$/Id; /lk$/Id; /site$/Id; /is$/Id; /ge$/Id; /nu$/Id; /lu$/Id; /fm$/Id; /bd$/Id; /xxx$/Id; /ba$/Id; /to$/Id; /am$/Id; /uy$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/ec$/Id; /ke$/Id; /tn$/Id; /website$/Id; /mk$/Id; /do$/Id; /name$/Id; /md$/Id; /mn$/Id; /space$/Id; /link$/Id; /tokyo$/Id; /ml$/Id; /travel$/Id; /ga$/Id; /news$/Id; /eg$/Id; /today$/Id; /np$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/la$/Id; /py$/Id; /bz$/Id; /im$/Id; /al$/Id; /life$/Id; /tech$/Id; /tz$/Id; /kg$/Id; /coop$/Id; /cr$/Id; /gt$/Id; /ly$/Id; /dz$/Id; /bo$/Id; /qa$/Id; /win$/Id; /cf$/Id; /cy$/Id; /jobs$/Id; /ug$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/live$/Id; /guru$/Id; /media$/Id; /click$/Id; /sexy$/Id; /aero$/Id; /li$/Id; /pa$/Id; /ai$/Id; /vc$/Id; /world$/Id; /tj$/Id; /sv$/Id; /ag$/Id; /jo$/Id; /gg$/Id; /ao$/Id; /one$/Id; /rocks$/Id; /af$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/ps$/Id; /kw$/Id; /london$/Id; /ovh$/Id; /mm$/Id; /shop$/Id; /agency$/Id; /bid$/Id; /blog$/Id; /work$/Id; /cm$/Id; /lb$/Id; /press$/Id; /ninja$/Id; /sd$/Id; /gh$/Id; /digital$/Id; /ni$/Id; /cu$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/eus$/Id; /kh$/Id; /nyc$/Id; /om$/Id; /ci$/Id; /video$/Id; /center$/Id; /mt$/Id; /cloud$/Id; /mu$/Id; /re$/Id; /academy$/Id; /moe$/Id; /gq$/Id; /hn$/Id; /so$/Id; /store$/Id; /mo$/Id; /rw$/Id; /st$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/sy$/Id; /global$/Id; /zw$/Id; /bh$/Id; /ac$/Id; /sn$/Id; /pics$/Id; /zone$/Id; /red$/Id; /tips$/Id; /vip$/Id; /host$/Id; /design$/Id; /et$/Id; /sh$/Id; /wiki$/Id; /mz$/Id; /iq$/Id; /ms$/Id; /berlin$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/education$/Id; /trade$/Id; /tt$/Id; /city$/Id; /mg$/Id; /solutions$/Id; /na$/Id; /paris$/Id; /company$/Id; /network$/Id; /cx$/Id; /zm$/Id; /cd$/Id; /stream$/Id; /bw$/Id; /sc$/Id; /technology$/Id; /social$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/fo$/Id; /gs$/Id; /bt$/Id; /plus$/Id; /porn$/Id; /guide$/Id; /pg$/Id; /expert$/Id; /bn$/Id; /tm$/Id; /blue$/Id; /studio$/Id; /wang$/Id; /ad$/Id; /as$/Id; /moscow$/Id; /events$/Id; /party$/Id; /int$/Id; /tools$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/bike$/Id; /marketing$/Id; /gal$/Id; /land$/Id; /lol$/Id; /men$/Id; /mv$/Id; /bzh$/Id; /jm$/Id; /works$/Id; /tc$/Id; /bf$/Id; /directory$/Id; /nc$/Id; /gl$/Id; /pf$/Id; /review$/Id; /cool$/Id; /gratis$/Id; /pub$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/help$/Id; /audio$/Id; /systems$/Id; /email$/Id; /bio$/Id; /gi$/Id; /ht$/Id; /chat$/Id; /bm$/Id; /mil$/Id; /webcam$/Id; /fj$/Id; /sm$/Id; /sx$/Id; /gdn$/Id; /market$/Id; /tl$/Id; /community$/Id; /watch$/Id; /love$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/services$/Id; /sex$/Id; /support$/Id; /cash$/Id; /pink$/Id; /school$/Id; /science$/Id; /tf$/Id; /mr$/Id; /pm$/Id; /photos$/Id; /buzz$/Id; /reviews$/Id; /scot$/Id; /team$/Id; /codes$/Id; /bank$/Id; /date$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/gy$/Id; /mc$/Id; /photo$/Id; /run$/Id; /dj$/Id; /international$/Id; /wtf$/Id; /photography$/Id; /report$/Id; /bet$/Id; /ky$/Id; /money$/Id; /pr$/Id; /gallery$/Id; /games$/Id; /group$/Id; /ink$/Id; /bi$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/ren$/Id; /brussels$/Id; /movie$/Id; /software$/Id; /training$/Id; /careers$/Id; /mw$/Id; /fit$/Id; /istanbul$/Id; /racing$/Id; /church$/Id; /gd$/Id; /je$/Id; /ltd$/Id; /vg$/Id; /camp$/Id; /house$/Id; /taipei$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/kim$/Id; /wien$/Id; /ye$/Id; /black$/Id; /coffee$/Id; /farm$/Id; /okinawa$/Id; /онлайн$/Id; /cafe$/Id; /care$/Id; /deals$/Id; /fun$/Id; /casino$/Id; /nagoya$/Id; /vu$/Id; /бел$/Id; /укр$/Id; /sr$/Id; /style$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/yt$/Id; /cv$/Id; /vision$/Id; /hosting$/Id; /swiss$/Id; /tel$/Id; /direct$/Id; /ngo$/Id; /university$/Id; /business$/Id; /faith$/Id; /loan$/Id; /sl$/Id; /dm$/Id; /domains$/Id; /institute$/Id; /lc$/Id; /museum$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/wales$/Id; /bb$/Id; /energy$/Id; /ooo$/Id; /ventures$/Id; /amsterdam$/Id; /gift$/Id; /dating$/Id; /place$/Id; /tube$/Id; /beer$/Id; /cards$/Id; /fund$/Id; /show$/Id; /uno$/Id; /exchange$/Id; /express$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/foundation$/Id; /hamburg$/Id; /pictures$/Id; /ax$/Id; /nrw$/Id; /poker$/Id; /sz$/Id; /рус$/Id; /bar$/Id; /camera$/Id; /dog$/Id; /earth$/Id; /ls$/Id; /yokohama$/Id; /москва$/Id; /boutique$/Id; /clothing$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/fitness$/Id; /immo$/Id; /jetzt$/Id; /kiwi$/Id; /barcelona$/Id; /delivery$/Id; /ist$/Id; /kitchen$/Id; /menu$/Id; /partners$/Id; /town$/Id; /va$/Id; /bayern$/Id; /koeln$/Id; /parts$/Id; /sale$/Id; /solar$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/tg$/Id; /bj$/Id; /tienda$/Id; /graphics$/Id; /quebec$/Id; /clinic$/Id; /cricket$/Id; /desi$/Id; /fashion$/Id; /law$/Id; /sb$/Id; /taxi$/Id; /toys$/Id; /コム$/Id; /bs$/Id; /engineering$/Id; /moda$/Id; /移动$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/gp$/Id; /restaurant$/Id; /vegas$/Id; /wf$/Id; /xin$/Id; /consulting$/Id; /cw$/Id; /finance$/Id; /gm$/Id; /rip$/Id; /shoes$/Id; /capital$/Id; /film$/Id; /fish$/Id; /game$/Id; /green$/Id; /onl$/Id; /singles$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/best$/Id; /build$/Id; /cg$/Id; /coach$/Id; /ne$/Id; /wedding$/Id; /art$/Id; /estate$/Id; /fyi$/Id; /glass$/Id; /rio$/Id; /tours$/Id; /accountant$/Id; /adult$/Id; /archi$/Id; /football$/Id; /kp$/Id; /kyoto$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/lat$/Id; /legal$/Id; /sydney$/Id; /band$/Id; /bnpparibas$/Id; /computer$/Id; /dance$/Id; /futbol$/Id; /gold$/Id; /pet$/Id; /rentals$/Id; /rest$/Id; /ski$/Id; /tirol$/Id; /yoga$/Id; /cam$/Id; /how$/Id; /pn$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/recipes$/Id; /surf$/Id; /lr$/Id; /repair$/Id; /орг$/Id; /abbott$/Id; /auction$/Id; /cab$/Id; /gop$/Id; /lighting$/Id; /pizza$/Id; /supply$/Id; /vote$/Id; /сайт$/Id; /aw$/Id; /college$/Id; /melbourne$/Id; /osaka$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/rent$/Id; /viajes$/Id; /casa$/Id; /ck$/Id; /cymru$/Id; /exposed$/Id; /golf$/Id; /hm$/Id; /holiday$/Id; /leclerc$/Id; /properties$/Id; /study$/Id; /tax$/Id; /vet$/Id; /alsace$/Id; /credit$/Id; /dental$/Id; /diet$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/family$/Id; /gent$/Id; /haus$/Id; /holdings$/Id; /horse$/Id; /kaufen$/Id; /miami$/Id; /ong$/Id; /realtor$/Id; /ruhr$/Id; /saarland$/Id; /srl$/Id; /한국$/Id; /aq$/Id; /bible$/Id; /capetown$/Id; /ceo$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/corsica$/Id; /insure$/Id; /limited$/Id; /promo$/Id; /theater$/Id; /villas$/Id; /vlaanderen$/Id; /voyage$/Id; /ДЕТИ$/Id; /builders$/Id; /cern$/Id; /cheap$/Id; /discount$/Id; /fishing$/Id; /gmbh$/Id; /jewelry$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/mp$/Id; /mq$/Id; /post$/Id; /productions$/Id; /reisen$/Id; /sener$/Id; /wine$/Id; /中国$/Id; /auto$/Id; /bargains$/Id; /equipment$/Id; /financial$/Id; /garden$/Id; /gifts$/Id; /gn$/Id; /google$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/healthcare$/Id; /hiphop$/Id; /irish$/Id; /joburg$/Id; /ki$/Id; /kn$/Id; /lawyer$/Id; /schule$/Id; /shopping$/Id; /soy$/Id; /supplies$/Id; /tattoo$/Id; /vi$/Id; /みんな$/Id; /army$/Id; /bradesco$/Id; /cars$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/fail$/Id; /frl$/Id; /jcb$/Id; /juegos$/Id; /kred$/Id; /lgbt$/Id; /management$/Id; /mba$/Id; /ryukyu$/Id; /بازار$/Id; /afl$/Id; /associates$/Id; /claims$/Id; /cleaning$/Id; /cologne$/Id; /cooking$/Id; /coupons$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/diamonds$/Id; /fage$/Id; /fans$/Id; /flights$/Id; /forsale$/Id; /furniture$/Id; /gf$/Id; /guitars$/Id; /immobilien$/Id; /investments$/Id; /komatsu$/Id; /krd$/Id; /loans$/Id; /pharmacy$/Id; /shiksha$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/td$/Id; /vodka$/Id; /attorney$/Id; /blackfriday$/Id; /car$/Id; /citic$/Id; /dnp$/Id; /eco$/Id; /gu$/Id; /limo$/Id; /luxury$/Id; /maison$/Id; /praxi$/Id; /property$/Id; /reise$/Id; /vin$/Id; /信息$/Id; /我爱你$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/apartments$/Id; /aws$/Id; /axa$/Id; /barclaycard$/Id; /barclays$/Id; /bingo$/Id; /cancerresearch$/Id; /career$/Id; /christmas$/Id; /country$/Id; /courses$/Id; /enterprises$/Id; /fk$/Id; /florist$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/gives$/Id; /hitachi$/Id; /monash$/Id; /mortgage$/Id; /nr$/Id; /rodeo$/Id; /saxo$/Id; /sucks$/Id; /tatar$/Id; /tickets$/Id; /toray$/Id; /vacations$/Id; /срб$/Id; /شبكة$/Id; /香港$/Id; /닷넷$/Id; /aco$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/audi$/Id; /canon$/Id; /condos$/Id; /construction$/Id; /contractors$/Id; /cruises$/Id; /dhl$/Id; /emerck$/Id; /engineer$/Id; /flowers$/Id; /hiv$/Id; /hockey$/Id; /industries$/Id; /km$/Id; /lidl$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/ltda$/Id; /markets$/Id; /mini$/Id; /neustar$/Id; /nf$/Id; /nico$/Id; /organic$/Id; /pictet$/Id; /pioneer$/Id; /plumbing$/Id; /rehab$/Id; /sandvik$/Id; /scb$/Id; /schmidt$/Id; /sony$/Id; /swatch$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/theatre$/Id; /whoswho$/Id; /yandex$/Id; /қаз$/Id; /قطر$/Id; /भारत$/Id; /বাংলা$/Id; /닷컴$/Id; /abb$/Id; /airforce$/Id; /aquarelle$/Id; /basketball$/Id; /bmw$/Id; /bridgestone$/Id; /catering$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/cfa$/Id; /creditcard$/Id; /crs$/Id; /degree$/Id; /dentist$/Id; /durban$/Id; /dvag$/Id; /edeka$/Id; /erni$/Id; /everbank$/Id; /foo$/Id; /frogans$/Id; /globo$/Id; /goog$/Id; /gw$/Id; /java$/Id; /jll$/Id; /kinder$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/latrobe$/Id; /lease$/Id; /mma$/Id; /mom$/Id; /motorcycles$/Id; /nadex$/Id; /navy$/Id; /ntt$/Id; /physio$/Id; /reit$/Id; /republican$/Id; /rich$/Id; /ricoh$/Id; /salon$/Id; /sarl$/Id; /sbi$/Id; /soccer$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
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
cat $TEMPFILEA | sed '/tennis$/Id; /tires$/Id; /trading$/Id; /trust$/Id; /voting$/Id; /voto$/Id; /weir$/Id; /հայ$/Id; /امارات$/Id; /تونس$/Id; /موقع$/Id; /ไทย$/Id; /公司$/Id; /台灣$/Id; /在线$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
fi

##  unset
unset STOPTLDSEARCH
