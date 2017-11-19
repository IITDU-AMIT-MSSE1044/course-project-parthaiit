# Vulnerability Identification and Classification Via Text Mining Bug Databases

## paper work 
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

In order to successfully capture all the information in a set of N documents, the term frequency of all M unique words in the set of N documents must be used. Thus the syntactical information of N documents with M unique words can be expressed using a N x M matrix. In this paper the methodology was tested on Linux bug reports that were reported to the Redhat Bugzilla bug database within the time period from January 2006 to April 2011, and Linux kernel vulnerabilities that were reported in the MITRE CVE database during the same time period. In order to test the presented vulnerability classification methodology, a set of Redhat Linux bugs, containing two classes: regular bugs and HIBs were constructed. The regular bug class contained 6000 randomly selected bugs reported from January 2006 to April 2011 that were not identified as vulnerabilities on the other hand. From these data they build two train file for two types of bug. 

After creating term document matrix a classifier(Decision Tree) was introduced to classify a given bug as an HIB or regular bug.The classification was performed using 10-fold cross validation. Classification results are shown in terms of True Positives (TP) and True Negatives (TN).

## My work
I mostly do the same thing that base paper does. But I enhance the regular bug over the time. That means they take 6000 bug from 2006 to 2011. But I take 3453 bug from 1999 to 2017. On the other hand I add different result representation method like precision, recall, f-measure.

## Data
This data is used in this paper. But for the time constrains we take 3453 regular bug and 3999 CVE related bug. Link form where I collect data is given bellow

