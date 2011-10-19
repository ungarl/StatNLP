# To change this template, choose Tools | Templates
# and open the template in the editor.

module TOEFL

  QuestionsToBeKilled = []
#  QuestionsToBeKilled = [2, 3, 32, 36, 37, 41, 44, 54, 61, 64, 78, 80] #for the top 100,000 unigram list

  SynonymQuestions = [
#    1.	enormously
#    a.	appropriately
#    b.	uniquely
#    c.	tremendously*
#    d.	decidedly
    {
      :target => 'enormously',
      :alternatives => %w(appropriately uniquely tremendously decidedly),
      :correct_answer => 'tremendously'
    },
#    2.	provisions
#    a.	stipulations*
#    b.	interrelations
#    c.	jurisdictions
#    d.	interpretations
    {
      :target => 'provisions',
      :alternatives => %w(stipulations interrelations jurisdictions interpretations),
      :correct_answer => 'stipulations'
    },
#      3.	haphazardly
#      a.	dangerously
#      b.	densely
#      c.	randomly*
#      d.	linearly
    {
      :target => 'haphazardly',
      :alternatives => %w(dangerously densely randomly linearly),
      :correct_answer => 'randomly'
    },
#      4.	prominent
#      a.	battered
#      b.	ancient
#      c.	mysterious
#      d.	conspicuous*
    {
      :target => 'prominent',
      :alternatives => %w(battered ancient mysterious conspicuous),
      :correct_answer => 'conspicuous'
    },
#      5.	zenith
#      a.	completion
#      b.	pinnacle*
#      c.	outset
#      d.	decline
    {
      :target => 'zenith',
      :alternatives => %w(completion pinnacle outset decline),
      :correct_answer => 'pinnacle'
    },
#      6.	flawed
#      a.	tiny
#      b.	imperfect*
#      c.	lustrous
#      d.	crude
    {
      :target => 'flawed',
      :alternatives => %w(tiny imperfect lustrous crude),
      :correct_answer => 'imperfect'
    },
#      7.	urgently
#      a.	typically
#      b.	conceivably
#      c.	tentatively
#      d.	desperately*
    {
      :target => 'urgently',
      :alternatives => %w(typically conceivably tentatively desperately),
      :correct_answer => 'desperately'
    },
#      8.	consumed
#      a.	bred
#      b.	caught
#      c.	eaten*
#      d.	supplied
    {
      :target => 'consumed',
      :alternatives => %w(bred caught eaten supplied),
      :correct_answer => 'eaten'
    },
#      9.	advent
#      a.	coming*
#      b.	arrest
#      c.	financing
#      d.	stability
    {
      :target => 'advent',
      :alternatives => %w(coming arrest financing stability),
      :correct_answer => 'coming'
    },
#      10.	concisely
#      a.	powerfully
#      b.	positively
#      c.	freely
#      d.	succinctly*
    {
      :target => 'concisely',
      :alternatives => %w(powerfully positively freely succinctly),
      :correct_answer => 'succinctly'
    },
#      11.	salutes
#      a.	information
#      b.	ceremonies
#      c.	greetings*
#      d.	privileges
    {
      :target => 'salutes',
      :alternatives => %w(information ceremonies greetings privileges),
      :correct_answer => 'greetings'
    },
#      12.	solitary
#      a.	alert
#      b.	restless
#      c.	alone*
#      d.	fearless
    {
      :target => 'solitary',
      :alternatives => %w(alert restless alone fearless),
      :correct_answer => 'alone'
    },
#      13.	hasten
#      a.	permit
#      b.	determine
#      c.	accelerate*
#      d.	accompany
    {
      :target => 'hasten',
      :alternatives => %w(permit determine accelerate accompany),
      :correct_answer => 'accelerate'
    },
#      14.	perseverance
#      a.	endurance*
#      b.	skill
#      c.	generosity
#      d.	disturbance
    {
      :target => 'perseverance',
      :alternatives => %w(endurance skill generosity disturbance),
      :correct_answer => 'endurance'
    },
#      15.	fanciful
#      a.	familiar
#      b.	imaginative*
#      c.	apparent
#      d.	logical
    {
      :target => 'fanciful',
      :alternatives => %w(familiar imaginative apparent logical),
      :correct_answer => 'imaginative'
    },
#      16.	showed
#      a.	demonstrated*
#      b.	published
#      c.	repeated
#      d.	postponed
    {
      :target => 'showed',
      :alternatives => %w(demonstrated published repeated postponed),
      :correct_answer => 'demonstrated'
    },
#      17.	constantly
#      a.	instantly
#      b.	continually*
#      c.	rapidly
#      d.	accidentally
    {
      :target => 'constantly',
      :alternatives => %w(instantly continually rapidly accidentally),
      :correct_answer => 'continually'
    },
#      18.	issues
#      a.	training
#      b.	salaries
#      c.	subjects*
#      d.	benefits
    {
      :target => 'issues',
      :alternatives => %w(training salaries subjects benefits),
      :correct_answer => 'subjects'
    },
#      19.	furnish
#      a.	supply*
#      b.	impress
#      c.	protect
#      d.	advise
    {
      :target => 'furnish',
      :alternatives => %w(supply impress protect advise),
      :correct_answer => 'supply'
    },
#      20.	costly
#      a.	expensive*
#      b.	beautiful
#      c.	popular
#      d.	complicated
    {
      :target => 'costly',
      :alternatives => %w(expensive beautiful popular complicated),
      :correct_answer => 'expensive'
    },
#      21.	recognized
#      a.	successful
#      b.	depicted
#      c.	acknowledged*
#      d.	welcomed
    {
      :target => 'recognized',
      :alternatives => %w(successful depicted acknowledged welcomed),
      :correct_answer => 'acknowledged'
    },
#      22.	spot
#      a.	climate
#      b.	latitude
#      c.	sea
#      d.	location*
    {
      :target => 'spot',
      :alternatives => %w(climate latitude sea location),
      :correct_answer => 'location'
    },
#      23.	make
#      a.	earn*
#      b.	print
#      c.	trade
#      d.	borrow
    {
      :target => 'make',
      :alternatives => %w(earn print trade borrow),
      :correct_answer => 'earn'
    },
#      24.	often
#      a.	definitely
#      b.	frequently*
#      c.	chemically
#      d.	hardly
    {
      :target => 'often',
      :alternatives => %w(definitely frequently chemically hardly),
      :correct_answer => 'frequently'
    },
#      25.	easygoing
#      a.	frontier
#      b.	boring
#      c.	farming
#      d.	relaxed*
    {
      :target => 'easygoing',
      :alternatives => %w(frontier boring farming relaxed),
      :correct_answer => 'relaxed'
    },
#      26.	debate
#      a.	war
#      b.	argument*
#      c.	election
#      d.	competition
    {
      :target => 'debate',
      :alternatives => %w(war argument election competition),
      :correct_answer => 'argument'
    },
#      27.	narrow
#      a.	clear
#      b.	freezing
#      c.	thin*
#      d.	poisonous
    {
      :target => 'narrow',
      :alternatives => %w(clear freezing thin poisonous),
      :correct_answer => 'thin'
    },
#      28.	arranged
#      a.	planned*
#      b.	explained
#      c.	studied
#      d.	discarded
    {
      :target => 'arranged',
      :alternatives => %w(planned explained studied discarded),
      :correct_answer => 'planned'
    },
#      29.	infinite
#      a.	limitless*
#      b.	relative
#      c.	unusual
#      d.	structural
    {
      :target => 'infinite',
      :alternatives => %w(limitless relative unusual structural),
      :correct_answer => 'limitless'
    },
#      30.	showy
#      a.	striking*
#      b.	prickly
#      c.	entertaining
#      d.	incidental
    {
      :target => 'showy',
      :alternatives => %w(striking prickly entertaining incidental),
      :correct_answer => 'striking'
    },
#      31.	levied
#      a.	imposed*
#      b.	believed
#      c.	requested
#      d.	correlated
    {
      :target => 'levied',
      :alternatives => %w(imposed believed requested correlated),
      :correct_answer => 'imposed'
    },
#      32.	deftly
#      a.	skillfully*
#      b.	prudently
#      c.	occasionally
#      d.	humorously
    {
      :target => 'deftly',
      :alternatives => %w(skillfully prudently occasionally humorously),
      :correct_answer => 'skillfully'
    },
#      33.	distribute
#      a.	commercialize
#      b.	circulate*
#      c.	research
#      d.	acknowledge
    {
      :target => 'distribute',
      :alternatives => %w(commercialize circulate research acknowledge),
      :correct_answer => 'circulate'
    },
#      34.	discrepancies
#      a.	weights
#      b.	deposits
#      c.	wavelengths
#      d.	differences*
    {
      :target => 'discrepancies',
      :alternatives => %w(weights deposits wavelengths differences),
      :correct_answer => 'differences'
    },
#      35.	prolific
#      a.	productive*
#      b.	serious
#      c.	capable
#      d.	promising
    {
      :target => 'prolific',
      :alternatives => %w(productive serious capable promising),
      :correct_answer => 'productive'
    },
#      36.	unmatched
#      a.	unrecognized
#      b.	unequaled*
#      c.	alienated
#      d.	emulated
    {
      :target => 'unmatched',
      :alternatives => %w(unrecognized unequaled alienated emulated),
      :correct_answer => 'unequaled'
    },
#      37.	peculiarly
#      a.	partly
#      b.	uniquely*
#      c.	patriotically
#      d.	suspiciously
    {
      :target => 'peculiarly',
      :alternatives => %w(partly uniquely patriotically suspiciously),
      :correct_answer => 'uniquely'
    },
#      38.	hue
#      a.	glare
#      b.	contrast
#      c.	color*
#      d.	scent
    {
      :target => 'hue',
      :alternatives => %w(glare contrast color scent),
      :correct_answer => 'color'
    },
#      39.	hind
#      a.	curved
#      b.	muscular
#      c.	hairy
#      d.	rear*
    {
      :target => 'hind',
      :alternatives => %w(curved muscular hairy rear),
      :correct_answer => 'rear'
    },
#      40.	highlight
#      a.	alter
#      b.	imitate
#      c.	accentuate*
#      d.	restore
    {
      :target => 'highlight',
      :alternatives => %w(alter imitate accentuate restore),
      :correct_answer => 'accentuate'
    },
#      41.	hastily
#      a.	hurriedly*
#      b.	shrewdly
#      c.	habitually
#      d.	chronologically
    {
      :target => 'hastily',
      :alternatives => %w(hurriedly shrewdly habitually chronologically),
      :correct_answer => 'hurriedly'
    },
#      42.	temperate
#      a.	cold
#      b.	mild*
#      c.	short
#      d.	windy
    {
      :target => 'temperate',
      :alternatives => %w(cold mild short windy),
      :correct_answer => 'mild'
    },
#      43.	grin
#      a.	exercise
#      b.	rest
#      c.	joke
#      d.	smile*
    {
      :target => 'grin',
      :alternatives => %w(exercise rest joke smile),
      :correct_answer => 'smile'
    },
#      44.	verbally
#      a.	orally*
#      b.	overtly
#      c.	fittingly
#      d.	verbosely
    {
      :target => 'verbally',
      :alternatives => %w(orally overtly fittingly verbosely),
      :correct_answer => 'orally'
    },
#      45.	physician
#      a.	chemist
#      b.	pharmacist
#      c.	nurse
#      d.	doctor*
    {
      :target => 'physician',
      :alternatives => %w(chemist pharmacist nurse doctor),
      :correct_answer => 'doctor'
    },
#      46.	essentially
#      a.	possibly
#      b.	eagerly
#      c.	basically*
#      d.	ordinarily
    {
      :target => 'essentially',
      :alternatives => %w(possibly eagerly basically ordinarily),
      :correct_answer => 'basically'
    },
#      47.	keen
#      a.	useful
#      b.	simple
#      c.	famous
#      d.	sharp*
    {
      :target => 'keen',
      :alternatives => %w(useful simple famous sharp),
      :correct_answer => 'sharp'
    },
#      48.	situated
#      a.	rotating
#      b.	isolated
#      c.	emptying
#      d.	positioned*
    {
      :target => 'situated',
      :alternatives => %w(rotating isolated emptying positioned),
      :correct_answer => 'positioned'
    },
#      49.	principal
#      a.	most
#      b.	numerous
#      c.	major*
#      d.	exceptional
    {
      :target => 'principal',
      :alternatives => %w(most numerous major exceptional),
      :correct_answer => 'major'
    },
#      50.	slowly
#      a.	rarely
#      b.	gradually*
#      c.	effectively
#      d.	continuously
    {
      :target => 'slowly',
      :alternatives => %w(rarely gradually effectively continuously),
      :correct_answer => 'gradually'
    },
#      51.	built
#      a.	constructed*
#      b.	proposed
#      c.	financed
#      d.	organized
    {
      :target => 'built',
      :alternatives => %w(constructed proposed financed organized),
      :correct_answer => 'constructed'
    },
#      52.	tasks
#      a.	customers
#      b.	materials
#      c.	shops
#      d.	jobs*
    {
      :target => 'tasks',
      :alternatives => %w(customers materials shops jobs),
      :correct_answer => 'jobs'
    },
#      53.	unlikely
#      a.	improbable*
#      b.	disagreeable
#      c.	different
#      d.	unpopular
    {
      :target => 'unlikely',
      :alternatives => %w(improbable disagreeable different unpopular),
      :correct_answer => 'improbable'
    },
#      54.	halfheartedly
#      a.	customarily
#      b.	bipartisanly
#      c.	apathetically*
#      d.	unconventionally
    {
      :target => 'halfheartedly',
      :alternatives => %w(customarily bipartisanly apathetically unconventionally),
      :correct_answer => 'apathetically'
    },
#      55.	annals
#      a.	homes
#      b.	trails
#      c.	chronicles*
#      d.	songs
    {
      :target => 'annals',
      :alternatives => %w(homes trails chronicles songs),
      :correct_answer => 'chronicles'
    },
#      56.	wildly
#      a.	distinctively
#      b.	mysteriously
#      c.	abruptly
#      d.	furiously*
    {
      :target => 'wildly',
      :alternatives => %w(distinctively mysteriously abruptly furiously),
      :correct_answer => 'furiously'
    },
#      57.	hailed
#      a.	judged
#      b.	acclaimed*
#      c.	remembered
#      d.	addressed
    {
      :target => 'hailed',
      :alternatives => %w(judged acclaimed remembered addressed),
      :correct_answer => 'acclaimed'
    },
#      58.	command
#      a.	observation
#      b.	love
#      c.	awareness
#      d.	mastery*
    {
      :target => 'command',
      :alternatives => %w(observation love awareness mastery),
      :correct_answer => 'mastery'
    },
#      59.	concocted
#      a.	devised*
#      b.	cleaned
#      c.	requested
#      d.	supervised
    {
      :target => 'concocted',
      :alternatives => %w(devised cleaned requested supervised),
      :correct_answer => 'devised'
    },
#      60.	prospective
#      a.	particular
#      b.	prudent
#      c.	potential*
#      d.	prominent
    {
      :target => 'prospective',
      :alternatives => %w(particular prudent potential prominent),
      :correct_answer => 'potential'
    },
#      61.	generally
#      a.	descriptively
#      b.	broadly*
#      c.	controversially
#      d.	accurately
    {
      :target => 'generally',
      :alternatives => %w(descriptively broadly controversially accurately),
      :correct_answer => 'broadly'
    },
#      62.	sustained
#      a.	prolonged*
#      b.	refined
#      c.	lowered
#      d.	analyzed
    {
      :target => 'sustained',
      :alternatives => %w(prolonged refined lowered analyzed),
      :correct_answer => 'prolonged'
    },
#      63.	perilous
#      a.	binding
#      b.	exciting
#      c.	offensive
#      d.	dangerous*
    {
      :target => 'perilous',
      :alternatives => %w(binding exciting offensive dangerous),
      :correct_answer => 'dangerous'
    },
#      64.	tranquillity
#      a.	peacefulness*
#      b.	harshness
#      c.	weariness
#      d.	happiness
    {
      :target => 'tranquillity',
      :alternatives => %w(peacefulness harshness weariness happiness),
      :correct_answer => 'peacefulness'
    },
#      65.	dissipate
#      a.	disperse*
#      b.	isolate
#      c.	disguise
#      d.	photograph
    {
      :target => 'dissipate',
      :alternatives => %w(disperse isolate disguise photograph),
      :correct_answer => 'disperse'
    },
#      66.	primarily
#      a.	occasionally
#      b.	cautiously
#      c.	consistently
#      d.	chiefly*
    {
      :target => 'primarily',
      :alternatives => %w(occasionally cautiously consistently chiefly),
      :correct_answer => 'chiefly'
    },
#      67.	colloquial
#      a.	recorded
#      b.	misunderstood
#      c.	incorrect
#      d.	conversational*
    {
      :target => 'colloquial',
      :alternatives => %w(recorded misunderstood incorrect conversational),
      :correct_answer => 'conversational'
    },
#      68.	resolved
#      a.	publicized
#      b.	forgotten
#      c.	settled*
#      d.	examined
    {
      :target => 'resolved',
      :alternatives => %w(publicized forgotten settled examined),
      :correct_answer => 'settled'
    },
#      69.	feasible
#      a.	permitted
#      b.	possible*
#      c.	equitable
#      d.	evident
    {
      :target => 'feasible',
      :alternatives => %w(permitted possible equitable evident),
      :correct_answer => 'possible'
    },
#      70.	expeditiously
#      a.	frequently
#      b.	actually
#      c.	rapidly*
#      d.	repeatedly
    {
      :target => 'expeditiously',
      :alternatives => %w(frequently actually rapidly repeatedly),
      :correct_answer => 'rapidly'
    },
#      71.	percentage
#      a.	volume
#      b.	sample
#      c.	proportion*
#      d.	profit
    {
      :target => 'percentage',
      :alternatives => %w(volume sample proportion profit),
      :correct_answer => 'proportion'
    },
#      72.	terminated
#      a.	ended*
#      b.	posed
#      c.	postponed
#      d.	evaluated
    {
      :target => 'terminated',
      :alternatives => %w(ended posed postponed evaluated),
      :correct_answer => 'ended'
    },
#      73.	uniform
#      a.	hard
#      b.	complex
#      c.	alike*
#      d.	sharp
    {
      :target => 'uniform',
      :alternatives => %w(hard complex alike sharp),
      :correct_answer => 'alike'
    },
#      74.	figure
#      a.	list
#      b.	solve*
#      c.	divide
#      d.	express
    {
      :target => 'figure',
      :alternatives => %w(list solve divide express),
      :correct_answer => 'solve'
    },
#      75.	sufficient
#      a.	recent
#      b.	physiological
#      c.	enough*
#      d.	valuable
    {
      :target => 'sufficient',
      :alternatives => %w(recent physiological enough valuable),
      :correct_answer => 'enough'
    },
#      76.	fashion
#      a.	ration
#      b.	fathom
#      c.	craze
#      d.	manner*
    {
      :target => 'fashion',
      :alternatives => %w(ration fathom craze manner),
      :correct_answer => 'manner'
    },
#      77.	marketed
#      a.	frozen
#      b.	sold*
#      c.	sweetened
#      d.	diluted
    {
      :target => 'marketed',
      :alternatives => %w(frozen sold sweetened diluted),
      :correct_answer => 'sold'
    },
#      78.	bigger
#      a.	steadier
#      b.	closer
#      c.	larger*
#      d.	better
    {
      :target => 'bigger',
      :alternatives => %w(steadier closer larger better),
      :correct_answer => 'larger'
    },
#      79.	roots
#      a.	origins*
#      b.	rituals
#      c.	cure
#      d.	function
    {
      :target => 'roots',
      :alternatives => %w(origins rituals cure function),
      :correct_answer => 'origins'
    },
#      80.	normally
#      a.	haltingly
#      b.	ordinarily*
#      c.	permanently
#      d.	periodically
    {
      :target => 'normally',
      :alternatives => %w(haltingly ordinarily permanently periodically),
      :correct_answer => 'ordinarily'
    }
  ]

  NumAnswerChoices = SynonymQuestions.first[:alternatives].length #they all have the same number of answer choices
  NumSynonymQuestions = SynonymQuestions.length - QuestionsToBeKilled.length
end

CHOICES = %w(ch1 ch2 ch3 ch4).join(',')
File.open("toefl.csv", "w") do |f|
  f.puts("target,#{CHOICES},answer")
  TOEFL::SynonymQuestions.each do |qu|
    f.puts("#{qu[:target]},#{qu[:alternatives].join(',')},#{qu[:correct_answer]}")
  end
end
