# Vulnerability Identification and Classification Via Text Mining Bug Databases

 
Vulnerabilities in software have always been an important security focus. For a complex software system identifying software vulnerabilities is becoming increasingly important. As control and monitoring systems become dependent on complex software, discovering these software vulnerabilities as early as possible is extremely important.Early identification of vulnerabilities will minimize the time in which the vulnerabilities expose the systems to attack. There are some bug that are identified as regular bug and has been made public. long afterthat these bugs are only identified as vulnerabilities. This kind of bug is known a Hidden Impact Bugs (HIBs). THis can be a security threat for that software system. Because these software bugs are disclosed to the public via bug databases and bug fixes, before being  identified as having a high security impact and being labeled as vulnerabilities. It was also shown in that the percentage of HIBs
has increased in recent years. Thus, a methodology that identifies these HIBs as they are reported to bug databases will reduce the time 
critical systems are exposed to these vulnerabilities.It was also shown in that the percentage of HIBs has increased in recent years. 
 
This paper presents a software vulnerability identification methodology using HIBs, that utilizes the textual description of the bugs
that were reported to publically available bug databases. The presented methodology take place followingly
1) extract syntactical information of bug reports
2) compress the information for easier manipulation 
3) use this information to generate a feature vector which is used for classification.

Firstly from the bug description they tokenize each bug description that means they take every word as  a token. After tokenization every upper case word convert to corrosponding lower case word and remove specialcharacter.Furthermore, frequently occurring words in English
language, known as stop words, are also removed from the bag-of-words representation For reduce redandency they combine similarwords like synonyms. This process minimize the size of feature vector that is used to identify  Hidden Impact Bugs (HIBs). After doing that  They convert every to their base word. This process is called stemming. 

The final preprocesing step is identifying the most frequently used keyword in the bug description. This is done by counting the number of documents each keyword set appears in, and selecting the keyword sets which appear most often in documents. Typically keyword sets that appear in less than P% of the documents are discarded. The percentages P for selecting the keywords appearing most frequently in bug reports were set at PSDESC = 1% and PLDESC = 3%.

In order to successfully capture all the information in a set of N documents, the term frequency of all M unique words in the set of N documents must be used. Thus the syntactical information of N documents with M unique words can be expressed using a N x M matrix.

