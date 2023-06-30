# *The project is not yet finished, as corrections will be made in the following month mainly in the paper after deliberation with the defense jury*

# *Eutyches Grammaticus, but glossed*


<img width="620" alt="Screenshot 2023-05-28 at 23 33 53" src="https://github.com/malamatenia/Eutyches/assets/92155767/adbacf6f-2072-4e9d-84ac-86f8ef360b00">


# **Navigating through the repository**

## Folder names

| Folder Name | Description |
| ----------- |  ---- |
| .github/workflows | Contains implementation of chocomufin and htrvx yml files for our dataset|
| BambergMsc30 | Contains all the files data-GT-notebooks-graphs pertaining to the Bamberg Msc 30 witness |
| Lat14087 | Contains all the files data-GT-notebooks-graphs pertaining to the Lat14087 witness |
| Lat7499 | Contains all the files data-GT-notebooks-graphs pertaining to the Lat7499 witness |
| VLO41 | Contains all the files data-GT-notebooks-graphs pertaining to the VLO41 witness |
| comparative_mss_analysis | contains the graphs and notebook for the comparative analysis of the witnesses|
| kraken-YALTAi |  contains the results and the test-set for the YALTAi and kraken models. The models themselves can be dowloaded here :  https://drive.google.com/drive/folders/16K4tPTaZvcc-rYqEFlUAoHX9vtaYLfnF?usp=share_link  |
| pipeline_diagrams |  General diagrams concerning the pipeline and methodology |
| rendu |  The pdf and .tex file of the Master2 dissertation |
 
The rest of the repository contains the ```table.csv``` for the chocomufin character control.


# **Introduction**

Eutychès was a Latin Grammarian, active in mid 6th century AD Constantinople, disciple of Priscianus Caesariensis. His contribution to the field of grammar consist mainly on a treatise called *De uerbo*, adressed to his *diligentissimum discipulorum* Craterus.The *ars* elaborates on the criteria for the classification of the conjugation of verbs, in short if the genitif of *dico* is *dicas* or *dicis*. Itself a rather arid development of principles that do not escape the general rule, nevertheless thanks to *De uerbo* 141 citations of classical authors have been passed down to us -some passages being otherwise lost-, mostly early Augustean poets. Adding to this, exhaustive lists of examples of verbs and derived nouns make integral part of the treatise, that have been recycled from posterior Grammatici.

*De uerbo* was last edited in the end of the 19th century by Heinrich Keil in his fifth (out of seven) tome of the *Grammatici Latini*,alongside an enormous corpus of *artes* dating from the 4th to the 7th century. This monumental edition, lack of methodological rigour and exhaustive paleographical research, is for the most part outdated, leaving a substantial amount of grammatical works in need of critical editions, including Eutychès' own contribution.

The manuscript tradition of the work, as reported by the excellent work of Colette Jeudy, is rather modest,as it is comprised of 32 manuscripts transmitting partially on entierly the text, and span from the end of the 8th to the 11th centudy AD. *De uerbo* enjoyed a fulgurant posterity, that inspired two medieval scholars, namely Sedulius Scottus and Remigius of Auxerre to make a commentary rendition out of it, attesting to its importance in the educational milieu. 

The typology of the manuscripts comes with two interesting features that pose at the same time the biggest difficulty for perspective editors (and, as we suppose, for Keil). Firstly, as many other works on grammar, actively used in the "medieval classroom" for the teaching of Latin, lists of examples are incorporated in the narrative between bits of theory, forming columns or/and tabular boards, a mise-en-page apt for the memorisation of these exceptions. At first this feature may not seem as a big of a deal, but a thorough examination of these tables and of the posterior works that use them indicate that it yields important information for the understanding of the manuscript tradition (see especially Conduché 2019 "La mise en page d'Eutychès"). Secondly, several witnesses are richely annotated with multiple layers of interlinear and marginal notes, the progressive accumulation of wich finds its *climax* in Remigius of Auxerre's commentary. Gloses in grammatical manuscripts have only recently (better late than ever!) started to interest editors  (see Monella/Rosselini for Priscian and Evina Steinovà for Isidore of Seville's Etymologies)most of them making use of digital tools. And that is because a typology as complex as that of grammatical glossed manuscripts cannot be easily handled and, better, be utilized for research purposes without the flexibility, absence of spatial contraints and ability of to handle of big and multilayered data that ditigal tools offer.

This project adhere to this renewal of tools and methods for the edition of grammatical texts in order to make full use of the precious information present in the manuscript tradition. Our case study for the first year of the Master's program in Digital Humanities in the marvelous codex *Vossianus Latinus* O. 41, a real life specimen of a grammar manualu sed in class. Written by 4 hands and annotated by another 4 (and some more for corrections), and containing ordered -or not- lists of examples find their way into doctrinal discussion it constitutes an exemplar case study for a diachronic survey of the different "annotation campaigns" as well as an attempt to modelise its heterogenous layout structure. A telling example from folio 5r: 

<p align="center">
  <img width="500" height="700" src="https://user-images.githubusercontent.com/92155767/170118764-169a3d76-01af-41a6-8ee3-392c578cce0a.jpg" >
</p>

# **A wild pipeline appears!**

The following graph concisely describes the pipeline ( that clearly has optimization potential!) that was developped and implemented for the M1 dissertation. Limitations and improvements (in frech) are discussed in the final chapter.

<p align="center">
  <img width="600" height="700" src="https://user-images.githubusercontent.com/92155767/169708060-5867a67e-90d9-4618-8ebd-f00358ad3227.png">
</p>



# **Quality control**

We decided, following HTR-United workflows, to proceed with the implementation of chocomufin for the control of the special characters and and HTRVX for the proper implementation of SegmOnto. Chocomufin is a software-workflow developped by Clérice Thubault and Pinche Ariane that creates a table of the characters (```table.csv```) that exist in the ground truth for both documents, and checks, with every push and pull request that the .xml documents found in the folders are conforming to this particular table. HTRVX, developped -surprise!- also by Thibault Clérice, is an excellent tool that reports back on SegmOnto non-compliant ALTO files,containing blank/non attributed lines/unbound lines in zones/non detectable extra expty zones created on eScriptorium and particularly helped with the some gazillion lines that we had to manually annotate :)



## **To-do for the M2 (done!)** 

- [x] Augment the dataset with at least 1-2 glossed witnessed
- [x] Train a Segmentation model and hope for the best
- [x] Think through a less time-consuming and more accurate method for lemma taging, already during the transcription (Annotations option on eScriptorium?)
- [x] Find a way to provide basic XML-TEI tags for identified lemmas and glosses
- [x] Extract the csv content directly from the XML files.
- [ ] Do not panic over the amount of work that needs to be done

