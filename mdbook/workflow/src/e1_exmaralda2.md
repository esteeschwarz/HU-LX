# EXMARALDA workflow
#### general
- info/download: [EXMARALDA Partitur Editor][1]   
assuming you have successfully installed exmaralda on your system here follow some instructions on how to work with it.    
you cannot open the .exb (exmaralda format) directly from the HU box, you have to download and open them in the partitureditor.   
#### transcription
## preliminary
- open the original .pdf you want to transcribe and the partitur editor. best is to have a parallel view of the .pdf and the partitur in horizontal split
- in the editor choose *\<file\>:\<new\>*
	- opens a blank document with 1 tier which is labelel  [X]
- edit the speakertable to relabel the tier:

![][image-1]

![][image-2]

- edit the transcript metadata

![][image-3]

![][image-4]

- here you insert the speaker abbreviation as label from the .pdf (e.g. MIM), the language used in the transcript and the L1/L2 if named in the questionaire
- NEXT: add a comment tier for annotation

![][image-5]

![][image-6]

## transcribe the text from the .pdf:
- click into a segment
- type the text
	- at the end of one unit (which is still to define: either sentence, word or syntactic unit) insert a \<space:leerzeichen:whitespace\> to signal the chat processor, that this is a segment. when you done with one segment and the end of available empty segments of the transcription tier is reached, one new segment is opened when you hit \<return:enter\> and you can type in the next unit.

![][image-7]

- save your transcription, it will save it as .exb

#### export:
you can export the transcription to various formats to e.g. view it in a texteditor. try the CHAT export. for further explanation see section on export [here.][2]

![][image-8]

**important** if you chose to transcribe the text segmented per token (word) i.e. you have one segment/token choose here \<based on HIAT segmentation\> as option in the dialogue, not CHAT segmentation. this will combine all tokens between sentence final characters (?|.|!) to one sentence/line in the exported output.
![][image-9]

use a .txt extension for the file instead of the .cha extension, this will open the exported file automatically in a texteditor like this:

![][image-10]



[1]:	https://exmaralda.org/de/partitur-editor-de/
[2]:	e1_exmaralda.md

[image-1]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_1.png
[image-2]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_2.png
[image-3]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_2a.png
[image-4]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_2b.png
[image-5]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_3.png
[image-6]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_3b.png
[image-7]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_4.png
[image-8]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_5a.png
[image-9]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_5b.png
[image-10]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_6.png