# Summary

- [content](a_intro.md)
- [SES Database](c_sesdb01.md)
	- [columns explained](d_sesdb002.md)
	- [possibilities](e_sesdb003.md)
- [anonymize interview audios](f_audacity.md)
- [Sketch Engine](g_pageske0.md)
	- [log in to Sketch Engine](h_page001.md)
	- [create new corpus](i_page003.md)
	- [import texts](j_page004.md)
	- [compile corpus](k_page005.md)
- [ANNIS framework](l_annis01.md)
- [BERLANGDEV workflow](m_berlangdev01.md)
- [BERLANGDEV media status](n_ses-status.md)
- [SES findings](o_findings00.md)
	- [001](p_findings01.md)
	- [002](q_findings02.md)
	- [003](r_findings03.md)
	- [accountability](s_sesdb004.md)
	- [distribution analysis](t_sesdist001.md)

# content
- SketchEngine import corpus
- explanations to the SES database
- ANNIS framework
- audacity how to anonymise interview audio
- BERLANGDEV workflow
- class findings
#### info:
please find [here](https://box.fu-berlin.de/s/tJNBadWwD5b3fJM) a .docx version of the pages. you can also use the \<print\> button on the top right side to generate an uptodate printed version.
to make sure you are viewing the most recent version of the wrap up, you can refresh this pages by visiting: [https://pinghook.dh-index.org?page=ses-wrapup](https://pinghook.dh-index.org?page=ses-wrapup)

# SES Database
open the database *SES\_database\_by\_tokens.xlsx* in excel or numbers (the database is about 26MByte, on a Mac choose rather Excel, the processing will be faster than in Numbers).  
in general you would prefer e.g. [OpenRefine](https://openrefine.org/docs/manual/installing) instead of excel or numbers for best working with the table.

to filter the table rows for specific tokens, speakers etc:
- open *Daten \> Filter*
- click the dropdown arrow in the column you want to filter in, e.g. p\_speaker
- deselect the „select all“ button (click on it; by default its selected with a häkchen)
	- now there should be no häkchen in any square/button
- select e.g. the speaker you want to filter for / häkchen setzen
- apply filter 
- you can apply several filters at once to limit concordance to language of interview or age or whatever limitation you want
- if you want to filter in the token column, you can put in/search for a free text token and then select what matches your search
- if you want to turn filters off you have to be again in the dropdown filter option of the column and remove the filter there, \> *filter entfernen*

## columns explained

| column             | explanation                                                                                                         | example                                                                                                 |
| :----------------- | :------------------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------ |
| p\_interview       | transcript                                                                                                          | GCA                                                                                                     |
| p\_speaker         | speaker                                                                                                             | \#GCA                                                                                                   |
| p\_token           | token                                                                                                               | Mach                                                                                                    |
| p\_lemma\_SkE      | sketch engine lemma                                                                                                 | machen-v                                                                                                |
| p\_lemma           | only the lemma                                                                                                      | machen                                                                                                  |
| p\_turn            | turn, sentence                                                                                                      | \#GCA  : 43 Mach ich die Arbeit die Schule c\_NPV .                                                     |
| p\_turn\_preceding | the preceding turn                                                                                                  | \#INT  : 42 (  activities\_after\_school  ) was machst du nach der Schule  , wenn du nicht hier bist  ? |
| p\_transcriptLine  | transcript line of the token                                                                                        | 43                                                                                                      |
| m\_feature\_eval   | empty evaluation column for your researches. you can use this as a selector for finding by turning it TRUE or FALSE | FALSCH                                                                                                  |
| m\_free\_col       | empty evaluation column for your researches. you can use this as a selector for finding by turning it TRUE or FALSE | 0                                                                                                       |
| t\_tag\_SkE        | full german RFTag. the following columns seperate this tag into the single items                                    | VIMP.Full.2.Sg                                                                                          |
| t\_PoS\_ok         | selector to switch if the tag is correct                                                                            | 1                                                                                                       |
| t\_PoS             | PartOfSpeech                                                                                                        | VIMP                                                                                                    |
| t\_category        | NA                                                                                                                  | Full                                                                                                    |
| t\_funct           | NA                                                                                                                  | -                                                                                                       |
| t\_case            | NA                                                                                                                  | -                                                                                                       |
| t\_pers            | NA                                                                                                                  | 2                                                                                                       |
| t\_num             | NA                                                                                                                  | Sg                                                                                                      |
| t\_gender          | NA                                                                                                                  | -                                                                                                       |
| t\_tense           | NA                                                                                                                  | -                                                                                                       |
| t\_mode            | NA                                                                                                                  | -                                                                                                       |
| part\_L1           | participant L1                                                                                                      | G                                                                                                       |
| part\_sex          | participant sex                                                                                                     | f                                                                                                       |
| part\_age          | participant age                                                                                                     | 8                                                                                                       |
| part\_CoB          | participant contry of birth                                                                                         | Greece                                                                                                  |
| part\_YiG          | participant years in germany                                                                                        | 0.5                                                                                                     |
| part\_YoSH         | particiant years of school in heritage country                                                                      | 0                                                                                                       |
| part\_LPM          | participant language proficiency mother                                                                             | kann deutsch                                                                                            |
| part\_LPF          | participant language proficiency father                                                                             | kann deutsch                                                                                            |
| part\_LUM          | participant language use mother                                                                                     | greek                                                                                                   |
| part\_LUF          | participant language use father                                                                                     | greek                                                                                                   |
| part\_LUS          | participant language use siblings                                                                                   | greek                                                                                                   |
| part\_LUFR         | participant language use friends                                                                                    | N.A.                                                                                                    |
| c\_NSM             | nonstandard semantics                                                                                               | 0                                                                                                       |
| c\_PAU             | pause                                                                                                               | 0                                                                                                       |
| c\_NPV             | nonstandard possessive                                                                                              | 1                                                                                                       |
| c\_NNS             | nonstandard not specified                                                                                           | 0                                                                                                       |
| c\_NPR             | nonstandard preposition                                                                                             | 0                                                                                                       |
| c\_NAG             | nonstandard agreement                                                                                               | 0                                                                                                       |
| c\_0MD             | zero modal                                                                                                          | 0                                                                                                       |
| c\_0SU             | zero subject                                                                                                        | 0                                                                                                       |
| c\_NWO             | nonstandard word order                                                                                              | 0                                                                                                       |
| c\_0OB             | zero object                                                                                                         | 0                                                                                                       |
| c\_0PR             | zero preposition                                                                                                    | 0                                                                                                       |
| c\_COM             | comment                                                                                                             | 0                                                                                                       |
| c\_NCM             | nonstandard comparison                                                                                              | 0                                                                                                       |
| c\_0AR             | zero article                                                                                                        | 0                                                                                                       |
| c\_NVP             | nonstandard VP                                                                                                      | 0                                                                                                       |
| c\_0VP             | zero VP                                                                                                             | 0                                                                                                       |
| c\_NGN             | nonstandard gender                                                                                                  | 0                                                                                                       |
| c\_0AU             | zero auxiliary                                                                                                      | 0                                                                                                       |
| c\_0CP             | zero copula                                                                                                         | 0                                                                                                       |
| c\_NEX             | nonstandard existential                                                                                             | 0                                                                                                       |
| c\_NRL             | nonstandard relative                                                                                                | 0                                                                                                       |
| c\_NAR             | nonstandard article                                                                                                 | 0                                                                                                       |
| c\_NMD             | nonstandard modal                                                                                                   | 0                                                                                                       |
| c\_0PT             | zero predicate                                                                                                      | 0                                                                                                       |
| c\_NPE             | nonstandard person                                                                                                  | 0                                                                                                       |
| c\_0RF             | zero reflexive                                                                                                      | 0                                                                                                       |
| c\_NIO             | nonstandard i.o.                                                                                                    | 0                                                                                                       |
| c\_NPS             | nonstandard person                                                                                                  | 0                                                                                                       |
| c\_0PN             | zero plural/numeral                                                                                                 | 0                                                                                                       |
| c\_NPO             | nonstandard pronoun                                                                                                 | 0                                                                                                       |
| c\_0RL             | zero relative                                                                                                       | 0                                                                                                       |
| c\_0EX             | zero existential                                                                                                    | 0                                                                                                       |
| c\_NNN             | nonstandard not specified                                                                                           | 0                                                                                                       |
| c\_NCP             | nonstandard copula                                                                                                  | 0                                                                                                       |
| c\_0RP             | zero reflexive pronoun                                                                                              | 0                                                                                                       |
| c\_0PD             | zero predicate                                                                                                      | 0                                                                                                       |
| c\_NVC             | nonstandard vocab                                                                                                   | 0                                                                                                       |
| c\_NEA             | nonstandard extra article                                                                                           | 0                                                                                                       |
| c\_NCN             | nonstandard conditional                                                                                             | 0                                                                                                       |

## summary
as you see in above table, theres a lot of possible filtering options working with the SES database.  
you can do simple queries for token, lemma or PoS tag or refine your query applying filters to metadata or coded features as well.

# how to anonymize/combine audios using audacity
#### prerequisites
- download and install [audacity](https://audacityteam.org)
- if you will using headphones to listen, make sure to FIRST plug in the headphones and THEN start audacity. that will enable your core audio to use the headphones as standard output.
#### 1. anonymise
- first download audiofiles to anonymize from the HU box. folder: [SES audio cut/renamed](https://box.hu-berlin.de/smart-link/04099902-f842-4a14-985c-5e9ec29d917a/). note: the file will probably (depending on your operating system) pop up/open automatically in your default media player application after download. close that application.
- in audacity import audio from downloads folder:
- *[datei] \> [öffnen] \> datei in downloads auswählen \> [öffnen] *
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2020.47.01.png)

- listen to the audio and find occurences of clear names
- the example here shows the workflow for two instances
- generally zoom in before *[play] *to be able to follow the moving cursor position. 
- if you want to stop playing, hit the [pause] button instead of the [stop] button. that will prevent the cursor from returning to 0-position.
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2020.48.40.png)

- e.g first instance at roughly  `0:09`
- ausschnitt vergröszern to specify location:
- mark location with pointer (*click \> move right \> release click*)
- *[ansicht] \> [zoom] \> [heranzoomen] [cmd+1]*
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2020.48.40.png)

![the white field shows the selected (markierte) range in the audio](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2020.57.50.png)

- repeat/narrow mark location with pointer (*click \> move right \> release click*)
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2020.58.25.png)

- insert BEEP sound over location:
- *[erzeugen] \> [klang]*
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2020.58.45.png)

![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2020.59.35.png)

- change amplitude dB to `0,2`
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2020.59.51.png)

- voila. first sinuscurve inserted.

- repeat for every instance.
- second instance at `11:53`
- zoom in
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.03.20.png)

![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.03.32.png)

![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.03.42.png)

![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.11.51.png)

#### 2. combine
how to copy content of 2nd & 3rd audio after end of 1st
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.14.12.png)

- click into wave of 2nd audio
- select complete wave:
- *[auswählen] \> [alles] [cmd-A]*
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.14.26.png)

- copy selected wave
- *[bearbeiten] \> [kopieren] [cmd-C]*
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.14.42.png)![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.15.08.png)

- now change to wave of 1st audio
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.15.34.png)![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.16.11.png)

- hover cursor over end of the track
- click. should appear one yellow line
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.16.43.png)

- insert the audio you copied before:
- *[bearbeiten] \> [einfügen] [cmd-V]*
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.17.30.png)

now second audio should appear after first audio.
- repeat for every audio which is to be added (e.g. 3rd, 4th audio)
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.18.41.png)![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.18.54.png)![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.19.07.png)![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.19.22.png)![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.20.19.png)![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.20.40.png)

#### 3. export mp3
![](https://ada-sub.dh-index.org/school/pr/2022-07-15/Bildschirmfoto%202022-07-13%20um%2021.21.33.png)

- select complete wave
- eport audio to file:
- *[datei]\>[exportieren]\>[als mp3 exportieren]*
- choose filename (renamed kid!) according to scheme of anonymised & combined
- choose *constant bitrate* for (export bitrate) at 128kbps (its more compressed then to lesser size)
- upload to HU box anonymised, combined.
#### 4. have bit fun.

# Sketch Engine
this is a short tutorial of how to import texts to [Sketch Engine](https://auth.sketchengine.eu/#login) to create a corpus of your own. you can then do researches in this corpus via the SketchEngine exploration tools.

## log in to Sketch Engine
open the Sketch Engine login page via: [https://auth.sketchengine.eu/#login](https://auth.sketchengine.eu/#login) and choose your affiliated institution. you can also create your own account or log in via google.

![login1](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/mdb-01-001.png)
![login2](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/mdb-01-002.png)

## create new corpus
1. in the dashboard click \>manage corpus\<

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/mdb-01-003.png)

2. select \>new corpus\<

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/mdb-01-004.png)

## import texts

1. give your corpus a name and provide a description. choose the language of your corpus:

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/./mdb-01-005.png)

2. import your texts. these can be single files of the supported format (.txt, .pdf. etc.) or a .zip file of these. if you want to import the SES transcripts, choose the `version without header for sketchengine` that you will find in the HU-BOX.


![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/./mdb-01-006.png)

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/./mdb-01-007.png)

3. the upload takes some time. if the texts have been uploaded successfully, you see your upload summary and wordcount.

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/./mdb-01-008.png)

## compile corpus
start the compilation of your corpus. this will tag the texts with PartOfSpeech-tags and lemmatize the words. more information on the used (for german) tagset you find [here](https://www.sketchengine.eu/German-rftagger-part-of-speech-tagset/).

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/mdb-01-009.png)

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/mdb-01-010.png)

your corpus is now ready to be explored. find all information to the query language and further guides in the [Sketch Engine Help](https://www.sketchengine.eu/German-rftagger-part-of-speech-tagset/) 

# ANNIS framework
find your way through: [https://corpus-tools.org/annis/](https://corpus-tools.org/annis/), install ANNIS on your system and try to import the zipped ANNIS SES corpus you find in the HU-box. \> folder: `sketch engine Work`, namescheme of latest zip: `[datestamp]_SES_annis_tagged_corpus.zip `
## SES sample procedure to create ANNIS corpus
**the following is just for documentation of the process; you wont have to follow these steps, just follow above instructions to install ANNIS on your system and import the zipped corpus.**
- upload files in HU box folder `version without header for SketchEngine upload` to SketchEngine \> *create new corpus*
-  *expert compiler settings* \> adapt `docscheme` to \> `sesCPT` 
	- with that done you can already explore the SES corpus in the SketchEngine GUI using the built in CQL (corpus query language) commands.
- download corpus (vertical)
	- corpus is now a database of token, PoS, lemma; tagged according to the *GermanRF tagset*[^1] used by SketchEngine
- process database in: [conc-essai.R](https://github.com/esteeschwarz/HU-LX/blob/main/scripts/conc_essai.R)
	- splits PoS tag (scheme: `x.x.x.x.x`) into seperate columns defining classes of PoS tags
	- writes single .xlsx files for each kid into folder
	- ANNIS preprocessing: 
		- [pepper](https://corpus-tools.org/pepper/): `xls > treetagger format` from .xlsx files folder. [parameter file](https://github.com/esteeschwarz/HU-LX/blob/main/scripts/r-conxl1.pepper)
		- pepper: `treetagger > annis graph format` from treetagger files folder. [parameter file](https://github.com/esteeschwarz/HU-LX/blob/main/scripts/r-conxl2.pepper)
		- zip annis graph files
- upload annis.zip to ANNIS localhost server
## ANNIS ready to use installation:
please find here: [link follows](#) an ANNIS server installation with the SES corpus ready to use. (! 20230904: the link is not yet freely available, use the link shared in moodle if you dont want to use your own local installation !)

# BERLANGDEV
this part will include workflow description of how to upload content to BERLANGDEV and edit metadata.
#### shortfast overview of basic workflow:
- login to [BERLANGDEV](https://rs.cms.hu-berlin.de/berlangdev/pages/collection_manage.php)
- click \<upload\>
- upload dialogue opens.

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/berlang_re_type.png)

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/berlang_res_coll.png)

- you can skip everything except: 
	- top \> ressourcentyp: choose type of ressource to upload
	- bottom \> zur kollektion hinzufügen: choose collection to which to upload resource
	- you can upload several resources at once and edit metadata afterwards
- when the resource appears in the collection view, click on it (opens it)
- go to \<edit metadata/metadaten bearbeiten\>

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/berlang_ed_meta.png)

- add ID of related resource to insert metadata (e.g. any ID of another resource of the same kid)

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/berlang_copy_meta.png)

- IMPORTANT: make sure to edit the metadata (which contains now just a copy of the other resource from where you copied it) and adapt it to your resource. theres few entries which you will have to change tout cas:

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/berlang_res_name.png)

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/berlang_res_filename.png)

- check for: interview language, which my differ depending from which resource you copied the metadata.
- make sure filename points to your resource and name depicts the correct resource in the overview.
- if you had uploaded several trials of the same resource which will have lead to an automatically generated number at the end of the description, please remove any earlier of your upload trials and change the displayname of the final resource according to the scheme, without any trailing numbers or additions may derive from your computers filesystem.
- finally: connect all related resource, i.e. add all resource IDs of the same kid into the bottom field \<verwandte resourcen\>

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/berlang_rel_res.png)


# SES: BERLANGDEV media status

| id  | child | CHAT | sanscodes | pdf | audio |
| --: | :---- | ---: | --------: | --: | ----: |
| 1   | GCA   | 1    | 1         | 1   | 1     |
| 2   | GCB   | 1    | 1         | 1   | 1     |
| 3   | GCC   | 1    | 1         | 1   | 1     |
| 4   | GCD   | 1    | 1         | 1   | 1     |
| 5   | GCE   | 1    | 1         | 1   | 1     |
| 6   | GCF   | 1    | 1         | 1   | 1     |
| 7   | GCG   | 1    | 1         | 1   | 1     |
| 8   | GDA   | 1    | 1         | 1   | 1     |
| 9   | GDB   | 1    | 1         | 1   | 0     |
| 10  | GDC   | 1    | 1         | 1   | 1     |
| 11  | GDD   | 1    | 1         | 1   | 1     |
| 12  | GDE   | 1    | 1         | 1   | 0     |
| 13  | GDF   | 1    | 1         | 1   | 1     |
| 14  | TAA   | 1    | 1         | 1   | 1     |
| 15  | TAB   | 1    | 1         | 1   | 0     |
| 16  | TAC   | 1    | 1         | 1   | 0     |
| 17  | TAD   | 1    | 1         | 1   | 1     |
| 18  | TAE   | 1    | 1         | 1   | 1     |
| 19  | TAF   | 1    | 1         | 1   | 1     |
| 20  | TAG   | 1    | 1         | 1   | 1     |
| 21  | TAH   | 1    | 1         | 1   | 1     |
| 22  | TAI   | 1    | 1         | 1   | 1     |
| 23  | TBB   | 1    | 1         | 1   | 1     |
| 24  | TBC   | 1    | 1         | 1   | 1     |
| 25  | TBD   | 1    | 1         | 1   | 1     |
| 26  | TBE   | 1    | 1         | 1   | 1     |
| 27  | TBF   | 1    | 1         | 1   | 1     |
| 28  | TBG   | 1    | 1         | 1   | 1     |
| 29  | TBH   | 1    | 1         | 1   | 1     |
| 30  | TBI   | 1    | 1         | 1   | 1     |
| 31  | TBK   | 1    | 1         | 1   | 1     |
| 32  | TBL   | 1    | 1         | 1   | 1     |
| 33  | TBM   | 1    | 1         | 1   | 1     |
| 34  | TBN   | 1    | 1         | 1   | 1     |
| 35  | TBO   | 1    | 1         | 1   | 1     |
| 36  | TBP   | 1    | 1         | 1   | 1     |
| 37  | TBQ   | 1    | 1         | 1   | 1     |
| 38  | TBR   | 1    | 1         | 1   | 1     |
| 39  | TBS   | 1    | 1         | 1   | 1     |
| 40  | TBT   | 1    | 1         | 1   | 1     |
| 41  | TBU   | 1    | 1         | 1   | 1     |
| 42  | TBV   | 1    | 1         | 1   | 1     |

# SES class findings
brief overview of student findings exploring the corpus

## class findings

| Student            | Child.Code | Age | Prepositions                                                              | Articles | Conjunctions | Paraphrase.with.verb | Hesitation.phenomena..Pauses..repeated.articles                           |
| :----------------- | :--------- | :-- | :------------------------------------------------------------------------ | :------- | :----------- | :------------------- | :------------------------------------------------------------------------ |
| Griechische Kinder | NA         | NA  | NA                                                                        | NA       | NA           | NA                   | NA                                                                        |
| Laura              | GCC        | 9   | auf: 3, an: 1, in: 7, nach: 1, zu: 7 - zun: 1, hinter:0, neben:0, vor:1   | NA       | NA           | NA                   | Viele Pausen, häufiges Zögern                                             |
| NA                 | GDC        | 8   | auf: 12, an:1, in 19 anstatt im:1, nach:5, zu:1, hinter:0, neben:0, vor:1 | NA       | NA           | NA                   | viele Pausen                                                              |
| NA                 | GCG        | 9   | NA                                                                        | NA       | NA           | NA                   | überlegt oft kurz, wenn sie nicht genau weiß, was sie zunächst sagen wird |
| NA                 | GDD        | 9   | NA                                                                        | NA       | NA           | NA                   | NA                                                                        |
| Türkische Kinder   | NA         | NA  | NA                                                                        | NA       | NA           | NA                   | NA                                                                        |
| Laura              | TAC        | 12  | auf: 16, an: 2, in: 6, nach: 4, zu: 7, hinter: 0, neben: 2, vor: 1        | NA       | NA           | NA                   | wenig Pausen oder Zögern                                                  |
| NA                 | TBF        | 12  | NA                                                                        | NA       | NA           | NA                   | NA                                                                        |
| NA                 | TAI        | 13  | auf: 8, an: 1, in: 12, nach: 5, zu: 3, hinter: 1, neben: 3, vor: 1        | NA       | NA           | NA                   | Viele Pausen, häufiges Zögern                                             |
| NA                 | TBB        | 14  | NA                                                                        | NA       | NA           | NA                   | NA                                                                        |

## class findings

| Student            | Child.Code | Age | Prepositions | Noticing                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Self.correction..content.or.form.                                                                                                                                                                                                                                                                                                                              | Interviewer                                                                                                                                                                                                                                                                                                                                                                                                                                               | More.information                   |
| :----------------- | :--------- | :-- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------- |
| Griechische Kinder | NA         | NA  | NA           | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | NA                                                                                                                                                                                                                                                                                                                                                             | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                        | NA                                 |
| Katharina          | GDA        | 11  | NA           | 0016 bis 0022 (answers INT not transcripted)//GDA:   Hier, das Maedchen und ein Jung basteln einen Schneemann. Das Maedchen macht ein Mohrruebe fuer Nase. Und hier gibt sie...@ 'ne...@ 'ne Stock 90 obj i.o..                   //INT: was ist das?                                                         //GDA:  Das hier?  hm                                                        //INT: was macht man damit?                                                 //GDA:  Machen sauber. //INT: Genau, n Besen./[später:] und nicht den Besen/--\>Bedeutungsverhandlung: gemeinsam Semantik umschreiben und erfassen; dann Vorschlag, der aufgegriffen wird/ | 0194 [Drachen] wenn es ganz gut Luft ist, Luft gib's, dann... /0237 Hier fragt ein Frau...@ den Schna- Schaffner wo geht da, der Zug                                                                                                                                                                                                                           | lacht viel, macht Späße, fragt freundlich nach, stimmt, genau/Recasts/0096 (answer not transcripted) Er faellt sich um. Hmh, fällt runter. (Übergeneralisierung reflexive Verben)/0104 (answer not transcripted) [der Junge] fangt. Ja, fängt.  /0181 (answer not transcripted) Soll ich sagen, wohin sie gehört? Ja, dann ist da noch irgendwas, was dazu gehört./0182 (answer not transcripted) Hier sind so Kristall. Eis. Ja genau, Eis. Eiskristalle | NA                                 |
| Türkische Kinder   | NA         | NA  | NA           | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | NA                                                                                                                                                                                                                                                                                                                                                             | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                        | NA                                 |
| Katharina          | TAF        | 13  | NA           | Zeile 0059 (Chat file) Kopf/--\> Noticing, Pause + direkter Vorschlag – lernt direkt etwas neues/0091 (Chat) Besen/--\> Vorschlag, der direkt übernommen wird./0103 0104 (Chat) Mohrrübe/                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | Sie setzt sich im einen Wagen und der Maedchen zieht sie- zieht er. (0068)/Ja, wenn du kein Fahrer- Fahrkarte hast, dann musst du wieder aussteigen. (0163)/weil, er traegt viel schwerer und er traegt (…) langs- ne bisschen leichter (0131) /da finden die- da find der Junge sein Vater und Mutter (0179)/--\> Umstrukturierung Syntax auch für L1 typisch | Interviewer sagt v.a. ok, gut, hmh, prima, alles ist erlaubt, lacht, ermutigt bei langen Pausen, weiterzumachen//Nachfrage Zeile 0038 (Chat) Irrenhaus//Recast 0146 (answer from INT not transcipted)//der Apfel gehoert die Aepfeln. Und warum gehören die beiden zusammen?                                                                                                                                                                              | Viele und lange, ungefüllte Pausen |
| NA                 | TBV        | 14  | NA           | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | NA                                                                                                                                                                                                                                                                                                                                                             | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                        | NA                                 |
| NA                 | TBE        | 13  | NA           | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | NA                                                                                                                                                                                                                                                                                                                                                             | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                        | NA                                 |
| NA                 | TBF        | 12  | NA           | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | NA                                                                                                                                                                                                                                                                                                                                                             | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                        | NA                                 |
| NA                 | TBM        | 13  | NA           | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | NA                                                                                                                                                                                                                                                                                                                                                             | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                        | NA                                 |
| NA                 | TBN        | 14  | NA           | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | NA                                                                                                                                                                                                                                                                                                                                                             | NA                                                                                                                                                                                                                                                                                                                                                                                                                                                        | NA                                 |

## class findings

| Student            | Child.Code | Age | Prepositions                                                                          | Articles                                               | Conjunctions                        | Hesitation.phenomena..Pauses..repeated.articles | Self.correction..content.or.form.                      |
| :----------------- | :--------- | :-- | :------------------------------------------------------------------------------------ | :----------------------------------------------------- | :---------------------------------- | :---------------------------------------------- | :----------------------------------------------------- |
| Griechische Kinder | NA         | NA  | NA                                                                                    | NA                                                     | NA                                  | NA                                              | NA                                                     |
| Miriam             | GCA        | 8   | auf: 3/an: 1 -\> am: 1/in: 31/nach: 4/zu: 3/hinter: 1/neben:/vor: 0                   | Reduced forms ///n: 1 -\> ein/einen                    | und: 95/dann: 11/danach: 0/weil: 1  | Viele Pausen, häufiges Zögern                   | Wenig Selbstkorrekturen                                |
| NA                 | GCE        | 11  | auf: 0/an: 0/in: 0/nach: 0/zu: 0/hinter: 0/neben: 0/vor: 0                            | Reduced forms ///                                      | und: 180/dann: 25/danach: 2/weil: 3 | Wenig Pausen oder Zögern                        | Mehr Selbstkorrekturen                                 |
| NA                 | GDE        | 10  | auf: 31/an: 0/in: 49 -\> inzu: 1/nach: 5/zu: 26 -\> inzu: 1/hinter: 3/neben: 2/vor: 3 | Reduced forms ///n: 4 -\> ein/einen//ne: 5 -\> eine//s | und: 57/dann: 13/danach: 1/weil: 9  | Seit 10 Jahren in Deutschland/Keine Audio-Datei | NA                                                     |
| NA                 | GDF        | 11  | auf: 10/an: 0/in: 25/nach: 6/zu: 15/hinter: 2/neben: 2/vor: 2                         | Reduced forms /                                        | Und/Und dann/danach/weil            | Wenig Pausen oder Zögern                        | Bewusste Selbstkorrekturen                             |
| Türkische Kinder   | NA         | NA  | NA                                                                                    | NA                                                     | NA                                  | NA                                              | NA                                                     |
| Miriam             | TAA        | 13  | auf: 16/an: 2/in: 6/nach: 4/zu: 7/hinter: 0/neben: 2/vor: 1                           | Reduced forms /                                        | Und/Und dann/danach/weil            | Wenig Pausen oder Zögern                        | Inhaltliche Selbstkorrekturen, weniger grammatikalisch |
| NA                 | TAD        | 14  | auf: 2 -\> aufm: 1/an: 0/in: 5 -\> inne: 1/nach: 2/zu: 6/hinter: 1/neben: 2/vor: 0    | Reduced forms /                                        | Und/Und dann/danach/weil            | Viele Pausen, häufiges Zögern                   | Wenig Selbstkorrekturen                                |
| NA                 | TBC        | 14  | auf: 14/an: 6/in: 9/nach: 2/zu: 16/hinter: 3 -\> hinterher: 1/neben: 4/vor: 0         | Reduced forms /                                        | Und/Und dann/danach/weil            | Viele Pausen, häufiges Zögern                   | Wenig Selbstkorrekturen                                |
| NA                 | TBD        | 13  | auf: 14/an: 0/in: 18/nach: 6/zu: 7/hinter: 0/neben: 1 -\> daneben: 1/vor: 2           | Reduced forms /                                        | Und/Und dann/danach/weil            | Wenig Pausen oder Zögern                        | Wenig Selbstkorrekturen                                |
| Carol              | test-ok    | NA  | NA                                                                                    | NA                                                     | NA                                  | NA                                              | NA                                                     |

## principle of accountability [^2]
roughly: the number of occurences of one (coded nonstandard) feature over the number of total instances of the feature (including standard + nonstandard realisations). e.g.:

| token  | instances | standard       | nonstandard                | normalised                 |
| ------ | --------- | -------------- | -------------------------- | -------------------------- |
| schnee | 54        | 33             | 21                         | 38.8888889                 |
|        |           |                |                            |                            |
|        | all       | coded "FALSCH" | coded "1" (feature = TRUE) | percent (D2/B2\\\\\\\*100) |

workflow:

![filter out #INT speaker](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/sesdb004-INT.png)

![filter after token schnee](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/sesdb004-schnee.png)

![analyse turn (manually)](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/sesdb004-schnee2.png)

![set evaluation column to 1=TRUE if nonstandard occurence (context)](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/sesdb004-schnee3.png)

1. filter out #INT speaker
2. filter after token [schnee]
3. analyse turn and define wether standard or nonstandard feature
4. set evaluation column to 1=TRUE for nonstandard occurences
5. sum up number of total instances
6. sum up number of positives (nonstandard realisation)
7. compute number of negatives (standard)
8. compute percentage


## SES distribution analysis
the following is the output table of the multivariate analysis of a frequency table of all feature codes over all target childs.  
the frequency table was exported from an ANNIS installation of the SES corpus. the query for getting the proper results is:  
`codetag = /c_.*/ & int = /T.*|G.*/ & #1 . #2`
this outputs all occuring codes over the transcripts and associates them to the speaker, either T=any turkish or G=any greek. with that you get a frequency table looking like this (exerpt):

| featurecode | child | count |
| ----------- | ----- | ----- |
| NPR         | GCA   | 16    |
| COM         | TBR   | 16    |
| COM         | TAA   | 15    |
| 0AR         | TBL   | 14    |
| NPR         | TBT   | 14    |
| 0AR         | GCB   | 14    |
| COM         | TBL   | 14    |
| 0AR         | GDA   | 13    |
| COM         | TBM   | 13    |
| NNS         | TBQ   | 13    |
| 0AR         | TBS   | 13    |
| COM         | GCA   | 13    |
| NPR         | TBU   | 12    |
| NPR         | GCC   | 12    |
| 0AR         | TBT   | 12    |
| COM         | TBU   | 12    |
| 0AR         | TBU   | 11    |
| NNS         | GCB   | 11    |

visualised:
![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/coded%20features%20over%20corpus.png)

![](https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/coded%20features%20over%20kids.png)


#### small significance testing:
script source: [https://github.com/esteeschwarz/HU-LX/blob/main/scripts/distribution-analysis.R](https://github.com/esteeschwarz/HU-LX/blob/main/scripts/distribution-analysis.R)  

the applied lmer (linear mixed effects regression model) [^3] formula is:  
`count ~ feature + (1 | L1)`  
in words: *we posited a main effect of feature  and random effects of L1*.
with this assumption a significance of `p < 0.05` was tested at 0AR (zero article), i.e. the coding of this feature (here) depends significant on the L1 use of the target child.   **IMPORTANT:** this does not allow general statements about the relation of 0AR feature and L1 since the transcript corpus was not coded/annotated until every instance of each feature.
#### lmer coefficients

|             |          |            |     |         |                          |     |     |
| ----------- | -------- | ---------- | --- | ------- | ------------------------ | :-- | :-- |
|             | Estimate | Std. Error | df  | t value | Pr ( \\\\\\\\\\\\\\\> t) |     |     |
| feature0AR  | 5,324    | 2,778      | 333 | 1,916   | 0,056                    |     |     |
| featureNPR  | 4,286    | 2,786      | 333 | 1,538   | 0,125                    |     |     |
| featureNAG  | 3,353    | 2,817      | 333 | 1,19    | 0,235                    |     |     |
| featureNNS  | 2,8      | 2,792      | 333 | 1,003   | 0,317                    |     |     |
| feature0SU  | 2,571    | 2,777      | 333 | 0,926   | 0,355                    |     |     |
| featureNGN  | 1,893    | 2,786      | 333 | 0,679   | 0,497                    |     |     |
| featureNPE  | 2        | 2,957      | 333 | 0,676   | 0,499                    |     |     |
| feature0PR  | 1,682    | 2,799      | 333 | 0,601   | 0,548                    |     |     |
| feature0OB  | 1,261    | 2,797      | 333 | 0,451   | 0,652                    |     |     |
| featureNSM  | 1,167    | 2,794      | 333 | 0,418   | 0,677                    |     |     |
| featureNWO  | 1,067    | 2,828      | 333 | 0,377   | 0,706                    |     |     |
| (Intercept) | 1        | 2,738      | 333 | 0,365   | 0,715                    |     |     |
| feature0EX  | 1        | 3,353      | 333 | 0,298   | 0,766                    |     |     |
| feature0MD  | 1        | 3,872      | 333 | 0,258   | 0,796                    |     |     |
| featureNPO  | 1        | 3,872      | 333 | 0,258   | 0,796                    |     |     |
| featureNVP  | 0,667    | 2,957      | 333 | 0,225   | 0,822                    |     |     |
| featureNEX  | 0,6      | 2,999      | 333 | 0,2     | 0,842                    |     |     |
| feature0RF  | 0,5      | 3,353      | 333 | 0,149   | 0,882                    |     |     |
| featureNCM  | 0,429    | 2,927      | 333 | 0,146   | 0,884                    |     |     |
| feature0CP  | 0,375    | 2,822      | 333 | 0,133   | 0,894                    |     |     |
| feature0AU  | 0,333    | 2,957      | 333 | 0,113   | 0,91                     |     |     |
| feature0VP  | 0,308    | 2,841      | 333 | 0,108   | 0,914                    |     |     |
| featureNRL  | 0,267    | 2,828      | 333 | 0,094   | 0,925                    |     |     |
| featureNPV  | 0,091    | 2,86       | 333 | 0,032   | 0,975                    |     |     |
| feature0AP  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| feature0EL  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| feature0PD  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| feature0PN  | 0        | 3,061      | 333 | 0       | 1                        |     |     |
| feature0PT  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| feature0RL  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| feature0RP  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNAR  | 0        | 2,927      | 333 | 0       | 1                        |     |     |
| featureNAU  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNCA  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNCJ  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNCN  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNCP  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNEA  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNIO  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNMD  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNNN  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNPN  | 0        | 3,872      | 333 | 0       | 1                        |     |     |
| featureNPS  | 0        | 2,957      | 333 | 0       | 1                        |     |     |
| featureNVC  | 0        | 3,872      | 333 | 0       | 1                        |     |     |


[^1]:	https://www.sketchengine.eu/German-rftagger-part-of-speech-tagset/

[^2]:	Labov, William. Sociolinguistic Patterns / William Labov. 1. publ. Oxford: Blackwell, 1972. Print.

[^3]:	Bates u. a., „Fitting Linear Mixed-Effects Models Using lme4“. 2015. [doi: 10.18637/jss.v067.i01](10.18637/jss.v067.i01)