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

- here you insert the speaker abbreviation as label from the .pdf (e.g. MIM), the language used in the transcript and the L1/L2 if named in the questionaire
- edit the transcript metadata:

![][image-3]

![][image-4]

**actualisation:** to manage the transcript metadata you can import the file \<LLDM\_metadata-template.exb\> from the box according to the following:

![][image-5]

![][image-6]

![][image-7]

![][image-8]

- then fill in the values of the template attributes with the corresponding values of the transcript. 
- NEXT: add a comment tier for annotation

![][image-9]

![][image-10]

## transcribe the text from the .pdf:
- click into a segment
- type the text
	- at the end of one unit (which is still to define: either sentence, word or syntactic unit) insert a \<space:leerzeichen:whitespace\> to signal the chat processor, that this is a segment. when you done with one segment and the end of available empty segments of the transcription tier is reached, one new segment is opened when you hit \<return:enter\> and you can type in the next unit.

![][image-11]

if you need to insert an empty segment in the middle of the transcript (because you forgot to transcribe a word e.g.) you can split an event which creates an empty segment.

![][image-12]

![][image-13]

you can also write the whole sentence into on segment an then split like above the segments where you want by positioning your cursor at the right position. the new segment will be created exactly where your cursor is, that would be after the whitespace between 2 words if you place it there. if there was a word after the whitespace, then that would be the content of the next segment (including every word which followed, you have to repeat the step for each word in the sentence.)   
the reverse operation (combining segments) is also possible; mark the segments you want to combine (like cells in an excel table, not with SHIFT-hold, but by moving over them mouse-clicked) and choose \<event:merge\>.

- save your transcription, it will be saved as .exb

#### export:
you can export the transcription to various formats to e.g. view it in a texteditor.   try the CHAT export. for further explanation see section on export [here.][2]

![][image-14]

**important** if you chose to transcribe the text segmented per token (word) i.e. you have one segment/token choose here \<based on HIAT segmentation\> as option in the dialogue, not CHAT segmentation. this will combine all tokens between sentence final characters (?|.|!) to one sentence/line in the exported output.
![][image-15]

use a .txt extension for the file instead of the .cha extension, this will open the exported file automatically in a texteditor like this:

![][image-16]



[1]:	https://exmaralda.org/de/partitur-editor-de/
[2]:	e1_exmaralda.md

[image-1]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_1.png
[image-2]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_2.png
[image-3]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_2a.png
[image-4]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_2b.png
[image-5]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_7a.png
[image-6]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_7b.png
[image-7]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_7c.png
[image-8]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_7d.png
[image-9]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_3.png
[image-10]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_3b.png
[image-11]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_4.png
[image-12]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_4bb.png
[image-13]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_4cc.png
[image-14]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_5a.png
[image-15]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_5b.png
[image-16]:	https://ada-sub.dh-index.org/school/pr/2023-04-15/ses_wrapup/src/exm_2_6.png