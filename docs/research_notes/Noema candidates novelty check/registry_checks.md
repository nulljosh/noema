# Prior work on automated consistency checks of ClinicalTrials.gov posted results

Scope: whether anyone has published arithmetic consistency checks on ClinicalTrials.gov (CT.gov) results (SD vs SE mislabelling, impossible baseline SDs, CI vs p-value sign slips), or a registry-wide check like them. Searches run October 2026 via web search and PubMed E-utilities. Every citation below was seen in a search result, fetch, or PubMed record. Items marked "unverified" were seen only as secondary summaries or were not retrieved and should not be cited without checking.

Bottom line: no registry-wide arithmetic audit of CT.gov results turned up. None of the three observations has a direct precedent in what I found. The nearest work is (a) NLM's own description of its QC process, which does not list the checks, (b) a 2021 automated metadata validation of CT.gov that explicitly excludes statistical values, and (c) general SD/SEM misuse literature that is not about registries.

## 1. Has anyone audited CT.gov results for internal arithmetic consistency?

### Takeaway
No. The closest prior work is NLM staff describing manual QC categories, and a 2021 SHACL metadata validation that covers value types and cardinalities only. Neither tests dispersion labels against CI widths, baseline SD feasibility, or CI vs p-value signs.

### Cited Findings
- Dobbins, Cox, Tse, Williams, Zarin (NLM), Peer Review Congress abstract "Characterizing Major Issues in ClinicalTrials.gov Results Submissions." 358 initial results submissions reviewed over four weeks in mid-2015; 240 had major issues. In a 215-submission convenience subsample, the top major issues were invalid or inconsistent units of measure (86, 40%), insufficient scale information (55, 26%), internal inconsistency (52, 24%), and unclear baseline or outcome measure (44, 20%). Internal inconsistency is described as a manual staff finding. The abstract says results "are validated using 3 components": structured data elements, automated system-based checks, and manual staff review, and gives no detail on the automated checks. Year is not printed on the page; data are from 2015 (year of presentation likely 2017, inferred, not confirmed). — [Peer Review Congress](https://peerreviewcongress.org/abstract/characterizing-major-issues-in-clinicaltrials-gov-results-submissions/)
- Keuchel D, Spicher N (2021), "Automatic Detection of Metadata Errors in a Registry of Clinical Studies Using Shapes Constraint Language (SHACL) Graphs," Studies in Health Technology and Informatics 281:372–376, DOI 10.3233/SHTI210183. Fifteen SHACL rule instances applied to all 355,862 CT.gov studies (snapshot 27 Oct 2020). Rules cover value type, controlled-value sets and cardinality. Reports missing values, out-of-set values and wrong cardinalities; approximately 5% of studies contain one or more such errors since 2015. The abstract states no rule concerns statistical values, dispersion, CIs or p-values. — [DOI](https://ebooks.iospress.nl/doi/10.3233/SHTI210183)
- NLM QC framing (secondary): PRS training material lists four review areas: logic and internal consistency, apparent validity, meaningful entries, formatting. Major comments (must fix) include "discrepancies between data in different parts of the record." Secondary sources only; the official QC criteria PDFs were not retrieved. — [PRS Overview (UCI copy)](https://research.uci.edu/wp-content/uploads/PRS-Overview-and-Resource-Orientation.pdf); [UCSF common errors](https://compliance.ucsf.edu/sites/compliance.ucsf.edu/files/2026-08/ClinicalTrials.gov_PRS_Protocol_Registration_Common_Errors.docx)
- Statistical-reporting screen in another literature (not registry): Nuijten MB et al. (2016), "The prevalence of statistical reporting errors in psychology (1985-2013)," Behavior Research Methods 48(4):1205–1226, PMID 26497820, DOI 10.3758/s13428-015-0664-2. statcheck recomputes p-values from reported test statistics and df. This is the methodological template for observation 3 (recomputing a p-value from reported values), but it does not treat CIs and does not run on registries. — [PubMed 26497820](https://pubmed.ncbi.nlm.nih.gov/26497820/)
- GRIM/SPRITE: the GRIM test (Brown and Heathers, 2016) checks whether a reported mean of N integers is attainable; SPRITE (Heathers and colleagues, PeerJ preprint) reconstructs candidate integer datasets from mean, SD, n and scale bounds. I found no application of GRIM or SPRITE to CT.gov results or to trial-reported means. Sources seen: [GRIM test (Wikipedia)](https://en.wikipedia.org/wiki/GRIM_test); [SPRITE preprint](https://peerj.com/preprints/26968); [rsprite2 manual](https://cran.r-project.org/web/packages/rsprite2/refman/rsprite2.html). The original GRIM paper's journal and DOI were not confirmed by search and are not cited here.
- Carlisle JB (2017), "Data fabrication and other reasons for non-random sampling in 5087 randomised, controlled trials in anaesthetic and general medical journals," Anaesthesia 72(8):944–952, PMID 28580651, DOI 10.1111/anae.13938. Tests whether baseline means and SDs in RCT tables are implausibly similar across arms (p-value distributions). Operates on journal publications, not CT.gov, and does not test SD feasibility against pooled arms or CI vs p-value. Nearest in spirit to observation 2. — [PubMed 28580651](https://pubmed.ncbi.nlm.nih.gov/28580651/)

### Inferences
- The 2021 SHACL work and the 2017 NLM abstract together suggest that NLM's automated checks are structural (types, sets, cardinalities), with statistical consistency handled by human reviewers. That is inference from the abstracts only; the check list itself is not public in what I found.
- Observation 3 (sign slip vs p-value) is a statcheck-type recomputation applied to a registry. I found no registry precedent.
- Observation 2 (Total-column SD infeasible for any pooling) is a pooled-variance feasibility test. The method is general; I found no application to CT.gov.

### Gaps
- The official NLM Results QC criteria PDFs and the full PRS validation rule list were not retrieved. The results-definitions page at https://clinicaltrials.gov/policy/results-definitions returned only glossary chrome when fetched.
- Not searched in depth: Data Colada, Retraction Watch, medRxiv, arXiv for statistical audits of CT.gov, Google Scholar. Only a limited set of queries was run.
- No statcheck-like or GRIM-like paper specifically on trial registries was found.

## 2. SEM vs SD misuse rates and registry vs publication discrepancy studies

### Takeaway
SD/SEM confusion in published papers is well documented (Nagele 2003 and several field surveys). Registry-vs-publication studies exist (Hartung 2014, Riveros 2013, Talebi 2020), but none tests arithmetic within the registry record. Nothing found on SD/SEM mislabelling inside CT.gov.

### Cited Findings
- Nagele P (2003), "Misuse of standard error of the mean (SEM) when reporting variability of a sample. A critical evaluation of four anaesthesia journals," British Journal of Anaesthesia 90(4):514–516, PMID 12644429, DOI 10.1093/bja/aeg087. Manual review of four anaesthesia journals (2001) for SEM used as a descriptive statistic. Rate figures not verified (full text not retrieved). — [PubMed 12644429](https://pubmed.ncbi.nlm.nih.gov/12644429/) (metadata confirmed via MEDLINE record)
- Cardiovascular survey (three journals, 2012 articles), "High Incorrect Use of the Standard Error of the Mean (SEM) in Original Articles in Three Cardiovascular Journals Evaluated for 2012," PMC4212967 (PLoS ONE, 2014 per DOAJ listing; authors not verified here). 441 articles, 64% (282) with at least one incorrect SEM use; 74% of basic-science vs 10% of clinical studies (from search snippet). — [PMC4212967](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4212967/)
- Manual medicine journals review, "Reporting the standard error of the mean: a critical analysis of three journals in manual medicine," PMC12135273 (authors and year not verified). Summary claims inappropriate use in 14–64% of articles across medical journals; its own sample 1.4%. — [PMC12135273](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC12135273/)
- BMJ note (Altman and Bland, 2005): the "±" notation does not say whether SD or SE is meant; per the BMJ item, 12 of 88 articles in a 2002 review failed to say which was reported. Figures from search snippet only. — [BMJ 331:903](https://www.bmj.com/cgi/reprint/331/7521/903)
- Hartung DM, Zarin D, Guise JM, McDonagh M, Paynter R, Helfand M (2014), "Reporting discrepancies between the ClinicalTrials.gov results database and peer-reviewed publications," Annals of Internal Medicine 160(7):477–483, PMID 24687070, DOI 10.7326/M13-0480. 110 trials (10% random sample of phase 3/4 trials finished before 2009 with two or more groups). Most frequent discrepancy: number of secondary outcome measures (80%). Primary outcome value inconsistent in 22 (20%). Thirty-eight trials inconsistent on SAE counts; 33 of those (87%) had more SAEs on CT.gov. Compares registry with publication, not internal registry arithmetic. — [PubMed 24687070](https://pubmed.ncbi.nlm.nih.gov/24687070/)
- Becker JE, Ross JS (2014), letter, Annals of Internal Medicine 161(10):760, PMID 25402518, DOI 10.7326/L14-5022. PubMed title is identical to Hartung 2014, so this is most likely a response letter to that paper. I saw the metadata only, not the letter text. — [PubMed 25402518](https://pubmed.ncbi.nlm.nih.gov/25402518/)
- Riveros C, Dechartres A, Perrodeau E, Haneef R, Boutron I, Ravaud P (2013), "Timing and completeness of trial results posted at ClinicalTrials.gov and published in journals," PLoS Medicine 10(12):e1001566, PMID 24311990, DOI 10.1371/journal.pmed.1001566. Timing and completeness of posting versus publication; not arithmetic. Metadata confirmed via MEDLINE record. — [PubMed 24311990](https://pubmed.ncbi.nlm.nih.gov/24311990/)
- Talebi R, Redberg RF, Ross JS (2020), "Consistency of trial reporting between ClinicalTrials.gov and corresponding publications: one decade after FDAAA," Trials 21:675, PMID 32703252, DOI 10.1186/s13063-020-04603-9. 94 phase III trials with results in both sources (2016–2017 publications). 74% of trials had at least one discrepancy; primary efficacy endpoint concordant in 74%, discordant 21%. Not arithmetic. — [PMC7376878](https://pmc.ncbi.nlm.nih.gov/articles/PMC7376878/)
- Tang et al. (2015), BMC Medicine 13:189 (serious adverse events, registry vs publication): per a secondary blog summary, 44 of 139 trials with publications (32%) had mismatched per-group SAE counts. Primary paper not retrieved; PMID not verified. Cited only as a pointer. — [Publication Plan summary](https://thepublicationplan.com/2015/08/14/comparison-of-serious-adverse-events-posted-at-clinicaltrials-gov-and-published-in-corresponding-journal-articles/)

### Inferences
- Registry-vs-publication studies compare two sources. Observations 1 to 3 need only the registry record, so they are a different test and would not be covered by these papers.
- The SD/SEM literature shows the confusion is common in papers. Nothing shows it has been measured on CT.gov, where the dispersion type is a structured field (see section 3). That gap is the main place for observation 1 to stand out.

### Gaps
- Not verified: the Carlisle-style literature on SD/SEM in RCT tables beyond Carlisle 2017; Ko et al. (ob/gyn SEM study, 2014) and Wullschleger et al. (cardiovascular, PMC4212967) authors were not confirmed.
- Tang 2015 primary paper not retrieved.
- Search for SD/SEM misuse in registries returned nothing.

## 3. Does the PRS data-entry system validate these?

### Takeaway
Dispersion type is a structured dropdown (Standard Deviation, Standard Error, IQR, full range, NA) and is available in the API. I found no public statement that PRS checks CI-inside-estimate, CI-vs-p-value, or SD feasibility. The NLM abstract indicates only that automated checks exist. The official check list was not retrieved.

### Cited Findings
- The CT.gov API exposes outcome dispersion as `resultsSection.outcomeMeasuresModule.outcomeMeasures.dispersionType`; AACT documents the same mapping. — [AACT documentation](https://aact.ctti-clinicaltrials.org/documentation/281) (seen in search result only)
- An arXiv paper on ClinicalTrialsHub lists the API `dispersionType` enum including Standard Error, Standard Deviation, Interquartile Range, Full Range, Not Applicable and several CI levels. Secondary description, not the NLM definition page. — [arXiv 2512.08193](https://arxiv.org/pdf/2512.08193)
- CT.gov data-entry templates for baseline characteristics list dispersion options including Standard Deviation, Inter-Quartile Range and Full Range. Seen in a search excerpt, not read in full. — [DataEntryTable_BaselineSpecificCharForm.pdf](https://cdn.clinicaltrials.gov/documents/results_table_layout/DataEntryTable_BaselineSpecificCharForm.pdf)
- Dobbins et al. (above) say automated checks exist, and that internal inconsistency is found by staff. — [Peer Review Congress](https://peerreviewcongress.org/abstract/characterizing-major-issues-in-clinicaltrials-gov-results-submissions/)

### Inferences
- The dispersion field is a dropdown with no stated validation of the CI-width rule. Whether PRS flags an SD-labelled dispersion whose CI implies SE is unknown. Observation 1 suggests it does not flag this, but that is an inference from the 304 + 63 cases in our data, not from the PRS rules.
- The 2015 NLM abstract shows staff catch internal inconsistency at review, so some of these errors may be caught and corrected in PRS before posting. Our observations are from the posted record, so they show the QC missed these cases or they were not checked.

### Gaps
- Official NLM Results QC criteria and PRS validation rule list not retrieved. Next step: fetch the results definitions anchor (OutcomeMeasureDispersType) and the QC criteria PDF from the PRS training pages, which the search surfaced but I did not open.
- No author or NLM document was found stating that PRS tests CI vs estimate, CI vs p-value, or pooled-SD feasibility.

## Searches that returned nothing relevant
- "standard error mislabeled as standard deviation clinical trial registry": no registry-specific hit.
- "GRIM test SPRITE registry trial reported means": GRIM and SPRITE found, no registry application.
- "ClinicalTrials.gov results data errors automated consistency check": only the NLM and SHACL items above.

## Verified citation list (metadata seen in MEDLINE or DOI pages)
- Nagele 2003, PMID 12644429, DOI 10.1093/bja/aeg087
- Hartung 2014, PMID 24687070, DOI 10.7326/M13-0480
- Becker and Ross 2014 (letter), PMID 25402518, DOI 10.7326/L14-5022
- Riveros 2013, PMID 24311990, DOI 10.1371/journal.pmed.1001566
- Talebi, Redberg, Ross 2020, PMID 32703252, DOI 10.1186/s13063-020-04603-9
- Carlisle 2017, PMID 28580651, DOI 10.1111/anae.13938
- Nuijten et al. 2016, PMID 26497820, DOI 10.3758/s13428-015-0664-2
- Keuchel and Spicher 2021, DOI 10.3233/SHTI210183
- Dobbins et al., Peer Review Congress abstract (URL only, year unconfirmed)

Not cited because unverified: Brown and Heathers GRIM paper DOI, SPRITE authors, statcheck-on-registry work, Tang 2015 PMID, Ko 2014 and Wullschleger 2014 author lists.
