# Romantic Circles TEI Repository

This repository collects (most of) the TEI files that underlie *Romantic Circles*'s content. We've designed this repository to make it easy for interested researchers to query the TEI directly, aggregate it into interesting corpuses, and generally use it for a range of digital humanities projects.

Our work to expose and make these resources useful is very much underway! For now, here's how we've organized this repo, and what you can expect to find here:

- The `editions`, `pedagogies-commons`, and `praxis` folders house the TEI themselves. These are organized by year. Not all content on *RC* is TEI-ed, and you can mostly expect to find content from 2013 on in this repo.
- The `_xslt` folder houses the stylesheets we use to locally transform TEI into HTML, which we then deploy to our Drupal site.

## Building Your Own Corpuses

Right now, you can build your own TEI corpus in much the same way that we at *RC* do. Doing so requires 1) a text editor so you can write your own "parts" files for the TEI you're interested in and 2) the ability to download and run a program called `xalan-c` on the command line.

### 1. Building a Parts File

First, `git clone` the repository to your local machine. Then, identify (in whatever manner suits you) the TEI files you're interested in merging into a corpus. Let's say we want to build a corpus file from all of the RC Praxis articles that mention Mary Shelley. We might run a program like `ack` over the Praxis folder...

```
ack "Mary Shelley" /praxis
```

and get the following list of files:

```
2010/fandom/praxis.fandom.2010.tuite.xml
2011/frictions/abstracts.xml
2011/thelwall/esterhammer.xml
2012/biopolitics/guyer.xml
2012/disaster/about.xml
2012/disaster/khalip.xml
2012/disaster/morton.xml
2013/mellor_interview/bibliography.xml
2013/mellor_interview/eberle_intro.xml
2013/mellor_interview/excerpt1.xml
2013/mellor_interview/excerpt4.xml
2013/mellor_interview/excerpt5.xml
2013/mellor_interview/transcript_all.xml
2014/antiquarianism/AntiquarianismCorpus.xml
2014/antiquarianism/praxis.antiquarianism.2014.campbell.xml
2014/visualities/praxis.visualities.2014.about.xml
2015/gothic_shelley/praxis.gothic_shelley.2015.brookshire.xml
2015/gothic_shelley/praxis.gothic_shelley.2015.hogle.xml
2015/gothic_shelley/praxis.gothic_shelley.2015.intro.xml
2015/gothic_shelley/praxis.gothic_shelley.2015.rajan.xml
2016/eastasia/praxis.2016.eastasia.intro.xml
2016/multi-media/praxis.2016.multi-media.rejack.xml
2017/negative/praxis.2017.negative.collings.xml
2017/negative/praxis.2017.negative.mazur.xml
```

We can then produce a `parts.xml` file using the following format:

```
<?xml version="1.0" encoding="UTF-8"?>
<Edition xmlns:tei="http://www.tei-c.org/ns/1.0">
  <part code="URL"/>
  <part code="URL"/>
  ...
  <part code="URL"/>
</Edition>
```

You can find this example file in `_examples`. Depending on where in the directory you run the merge program, you might have to fiddle around with the URLs a bit.

### 2. Merging the TEI files

You'll need to download a program called `xalan-c`. If you're on a Linux machine, use the package manager of your choice. On a Mac, we recommend Homebrew.

```
brew install xalan-c
```

Then it's as easy as running

```
xalan maryShelleyParts.xml _xslt/mergetoCorpus.xsl
```

(`mergetoCorpus.xsl` is the file we use to merge corpuses for site deployment. It's pretty barebones and we're working on more robust .xsl files!)
