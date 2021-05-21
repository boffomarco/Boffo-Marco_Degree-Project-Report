%% forked from https://gits-15.sys.kth.se/giampi/kthlatex kthlatex-0.2rc4 on 2020-02-13
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kththesis}[2018/04/26 KTH Thesis formatting]

\newif\ifinswedish
\DeclareOption{english}{}
\DeclareOption{swedish}{\inswedishtrue}

\newif\ifgfivepaper
\DeclareOption{a4paper}{}
\DeclareOption{g5paper}{\gfivepapertrue}

\newif\ifbachelor
\DeclareOption{bachelor}{\bachelortrue}
\DeclareOption{master}{}

%% Send any unknown option to the report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions\relax

\ifgfivepaper
  \LoadClass[10pt]{report}
\else
  \LoadClass[12pt]{report}
\fi

% to do string comparison
\usepackage{xstring}

% to support units and decimal aligned columns in tables
\usepackage{siunitx}

% Make it possible to conditionally depend on the TeX-engine used
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\newif\ifxeorlua
\ifxetex\xeorluatrue\fi
\ifluatex\xeorluatrue\fi

%% Load other packages

\ifxeorlua
  \RequirePackage{polyglossia}
  \ifinswedish
    \setmainlanguage{swedish}
    \setotherlanguage[variant=us]{english}
    \setotherlanguages{italian}
  \else
    \setmainlanguage[variant=us]{english}
    \setotherlanguages{swedish,italian}
    %\setotherlanguage{swedish}
  \fi
\else
  \RequirePackage[utf8]{inputenc}
  \ifinswedish
    % can replace USenglish with UKenglish if desired
    \RequirePackage[main=swedish,english,italian]{babel}
  \else
    % can replace USenglish with UKenglish if desired
    \RequirePackage[swedish,main=english,italian]{babel}
  \fi
\fi

\ifgfivepaper
\RequirePackage[paperwidth=169mm,paperheight=239mm,twoside,
  top=30mm,bottom=30mm,inner=36mm,outer=18mm,
  headsep=10mm,headheight=5mm]{geometry} % Set paper and contents dimensions
\else
\RequirePackage[a4paper,twoside,
  top=37mm,bottom=50mm,inner=45mm,outer=35mm,
  headsep=15mm,headheight=6mm,footskip=25mm]{geometry} % Set paper and contents dimensions
\fi
\RequirePackage{fancyhdr} % Take control of headers and footers
%\RequirePackage{emptypage} % Supress page numbers on otherwise empty pages

\RequirePackage{pdfpages} % Used to include the preformatted KTH cover pages

\RequirePackage{titlesec} % Redefine the appearance of headers
% === Patch to circumvent a bug in the titlesec package version 2.10.1
\@ifpackagelater{titlesec}{2016/03/21}{%
 % Package titlesec is on version 2.10.2 or higher, nothing to do %
}{%
 % Check if package titlesec is on version 2.10.1 %
 \@ifpackagelater{titlesec}{2016/03/15}{%
  % Package titlesec on version 2.10.1, patch accordingly %
  \RequirePackage{etoolbox}%
  \patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}%
  \patchcmd{\ttlh@hang}{\noindent}{}{}{}%
 }{%
  % Package titlsecon is on version 2.10.0 or lower, nothing to do %
 }%
}
% === End ot titlesec patch

\ifxeorlua
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures={TeX}} % This enables TeX style ligatures such as ---, '', ``, and so on
  \setmainfont{TeX Gyre Termes}  %% Times like font
  \setsansfont{TeX Gyre Heros}   %% Helvetica like font
  \setmonofont{TeX Gyre Cursor}  %% Courier like font
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage{tgtermes}
  \RequirePackage{tgheros}
  \RequirePackage{tgcursor}
\fi

% Set up the header and footer
\fancyhead{}
\fancyhead[RO]{\sffamily\small\leftmark\thinspace|\thinspace\thepage}
\fancyhead[LE]{\sffamily\small\thepage\thinspace|\thinspace\leftmark}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}

% Add 5% extra linespacing
\linespread{1.05}

% Set the proper format for the headers
\titleformat{\chapter}[display]
  {\normalfont\sffamily\huge\bfseries}
  {\chaptertitlename\ \thechapter}{20pt}{\Huge}
\titleformat{\section}
  {\normalfont\sffamily\Large\bfseries}
  {\thesection}{1em}{}
\titleformat{\subsection}
  {\normalfont\sffamily\large\bfseries}
  {\thesubsection}{1em}{}

\renewenvironment{abstract}{\section*{\abstractname}}

% Define commands for setting the user definable parts of the title page

\let\@subtitle\@empty
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\let\@alttitle\@empty
\newcommand{\alttitle}[1]{\def\@alttitle{#1}}
\let\@altsubtitle\@empty
\newcommand{\altsubtitle}[1]{\def\@altsubtitle{#1}}
\let\@hostcompany\@empty
\newcommand{\hostcompany}[1]{\def\@hostcompany{#1}}
\let\@hostorganization\@empty
\newcommand{\hostorganization}[1]{\def\@hostorganization{#1}}

\let\@school\@empty
\newcommand{\school}[1]{\def\@school{#1}}

% First author's information
\let\@authorsLastname\@empty
\newcommand{\authorsLastname}[1]{\def\@authorsLastname{#1}}
\let\@authorsFirstname\@empty
\newcommand{\authorsFirstname}[1]{\def\@authorsFirstname{#1}}
\let\@email\@empty
\newcommand{\email}[1]{\def\@email{#1}}
\let\@kthid\@empty
\newcommand{\kthid}[1]{\def\@kthid{#1}}
\let\@orcid\@empty
\newcommand{\orcid}[1]{\def\@orcid{#1}}
\let\@authorsSchool\@empty
\newcommand{\authorsSchool}[1]{\def\@authorsSchool{#1}}
\let\@authorsDepartment\@empty
\newcommand{\authorsDepartment}[1]{\def\@authorsDepartment{#1}}

% Second author's information
\let\@secondAuthorsLastname\@empty
\newcommand{\secondAuthorsLastname}[1]{\def\@secondAuthorsLastname{#1}}
\let\@secondAuthorsFirstname\@empty
\newcommand{\secondAuthorsFirstname}[1]{\def\@secondAuthorsFirstname{#1}}
\let\@secondemail\@empty
\newcommand{\secondemail}[1]{\def\@secondemail{#1}}
\let\@secondkthid\@empty
\newcommand{\secondkthid}[1]{\def\@secondkthid{#1}}
\let\@secondorcid\@empty
\newcommand{\secondorcid}[1]{\def\@secondorcid{#1}}
\let\@secondAuthorsSchool\@empty
\newcommand{\secondAuthorsSchool}[1]{\def\@secondAuthorsSchool{#1}}
\let\@secondAuthorsDepartment\@empty
\newcommand{\secondAuthorsDepartment}[1]{\def\@secondAuthorsDepartment{#1}}



\let\@supervisorAsLastname\@empty
\newcommand{\supervisorAsLastname}[1]{\def\@supervisorAsLastname{#1}}
\let\@supervisorAsFirstname\@empty
\newcommand{\supervisorAsFirstname}[1]{\def\@supervisorAsFirstname{#1}}
\let\@supervisorAsEmail\@empty
\newcommand{\supervisorAsEmail}[1]{\def\@supervisorAsEmail{#1}}
\let\@supervisorAsKTHID\@empty
\newcommand{\supervisorAsKTHID}[1]{\def\@supervisorAsKTHID{#1}}
\let\@supervisorAsOrganization\@empty
\newcommand{\supervisorAsOrganization}[1]{\def\@supervisorAsOrganization{#1}}
\let\@supervisorAsSchool\@empty
\newcommand{\supervisorAsSchool}[1]{\def\@supervisorAsSchool{#1}}
\let\@supervisorAsDepartment\@empty
\newcommand{\supervisorAsDepartment}[1]{\def\@supervisorAsDepartment{#1}}

\let\@supervisorBsLastname\@empty
\newcommand{\supervisorBsLastname}[1]{\def\@supervisorBsLastname{#1}}
\let\@supervisorBsFirstname\@empty
\newcommand{\supervisorBsFirstname}[1]{\def\@supervisorBsFirstname{#1}}
\let\@supervisorBsEmail\@empty
\newcommand{\supervisorBsEmail}[1]{\def\@supervisorBsEmail{#1}}
\let\@supervisorBsKTHID\@empty
\newcommand{\supervisorBsKTHID}[1]{\def\@supervisorBsKTHID{#1}}
\let\@supervisorBsOrganization\@empty
\newcommand{\supervisorBsOrganization}[1]{\def\@supervisorBsOrganization{#1}}
\let\@supervisorBsSchool\@empty
\newcommand{\supervisorBsSchool}[1]{\def\@supervisorBsSchool{#1}}
\let\@supervisorBsDepartment\@empty
\newcommand{\supervisorBsDepartment}[1]{\def\@supervisorBsDepartment{#1}}


\let\@supervisorCsLastname\@empty
\newcommand{\supervisorCsLastname}[1]{\def\@supervisorCsLastname{#1}}
\let\@supervisorCsFirstname\@empty
\newcommand{\supervisorCsFirstname}[1]{\def\@supervisorCsFirstname{#1}}
\let\@supervisorCsEmail\@empty
\newcommand{\supervisorCsEmail}[1]{\def\@supervisorCsEmail{#1}}
\let\@supervisorCsKTHID\@empty
\newcommand{\supervisorCsKTHID}[1]{\def\@supervisorCsKTHID{#1}}
\let\@supervisorCsOrganization\@empty
\newcommand{\supervisorCsOrganization}[1]{\def\@supervisorCsOrganization{#1}}
\let\@supervisorCsSchool\@empty
\newcommand{\supervisorCsSchool}[1]{\def\@supervisorCsSchool{#1}}
\let\@supervisorCsDepartment\@empty
\newcommand{\supervisorCsDepartment}[1]{\def\@supervisorCsDepartment{#1}}


\let\@examinersLastname\@empty
\newcommand{\examinersLastname}[1]{\def\@examinersLastname{#1}}
\let\@examinersFirstname\@empty
\newcommand{\examinersFirstname}[1]{\def\@examinersFirstname{#1}}
\let\@examinersEmail\@empty
\newcommand{\examinersEmail}[1]{\def\@examinersEmail{#1}}
\let\@examinersKTHID\@empty
\newcommand{\examinersKTHID}[1]{\def\@examinersKTHID{#1}}
\let\@examinersOrganization\@empty
\newcommand{\examinersOrganization}[1]{\def\@examinersOrganization{#1}}
\let\@examinersSchool\@empty
\newcommand{\examinersSchool}[1]{\def\@examinersSchool{#1}}
\let\@examinersDepartment\@empty
\newcommand{\examinersDepartment}[1]{\def\@examinersDepartment{#1}}


\let\@programme\@empty
\newcommand{\programme}[1]{\def\@programme{#1}}
%

%\newcommand{\programcode}[1]{\def\@programcode{#1}}
%\newcommand{\decide}[3]{%
%  \IfStrEq{\@programcode}{#1}{#2}{#3}%
%}

% get all of the information about the school codes and program codes
\input{Input/schools_and_programs.ins}


\newcommand{\MONTH}{%
  \ifinswedish
  \ifcase\the\month
  \or januari% 1
  \or februari% 2
  \or mars% 3
  \or april% 4
  \or maj% 5
  \or juni% 6
  \or juli% 7
  \or augusti% 8
  \or september% 9
  \or oktober% 10
  \or november% 11
  \or december% 12
  \fi
  \else
  \ifcase\the\month
  \or January% 1
  \or February% 2
  \or March% 3
  \or April% 4
  \or May% 5
  \or June% 6
  \or July% 7
  \or August% 8
  \or September% 9
  \or October% 10
  \or November% 11
  \or December% 12
  \fi
\fi
}

% covers are separately made and applied
%\let\@kthcover\@empty
%\newcommand{\kthcover}[1]{\def\@kthcover{#1}}

% Command to print out the standardized title page
\renewcommand{\titlepage}{
\ifgfivepaper
  \newgeometry{top=65mm,bottom=30mm,left=62mm,right=18mm}
\else
  \newgeometry{top=65mm,bottom=30mm,left=50mm,right=35mm}
\fi

\thispagestyle{empty}

\begin{huge}
  \begin{flushleft}
    \noindent\sffamily\bfseries \@title \par
  \end{flushleft}
\end{huge}

\ifx\@subtitle\@empty\relax
\else
\begin{Large}
  \vspace{1ex}
  \begin{flushleft}
    \noindent\sffamily\bfseries \@subtitle \par
  \end{flushleft}
\end{Large}
\fi


\vspace{10mm}
\begin{large}
  \begin{flushleft}
    \sffamily
    \expandafter\MakeUppercase\expandafter\@authorsFirstname\space\@authorsLastname \par
    \ifx\@secondAuthorsLastname\@empty\relax
    \else\vspace{1ex}\expandafter\MakeUppercase\expandafter\@secondAuthorsFirstname\space\@secondAuthorsLastname \par
    \fi
  \end{flushleft}
\end{large}

\vfill

\begin{flushleft}
  \sffamily
  \ifinswedish
    \@programme\\
    \ifx\@date\@empty\relax\else Datum: \@date\vspace{5mm} \fi
    \ifx\@supervisorBsLastname\@empty
    Handledare: \@supervisorAsFirstname\space\@supervisorAsLastname
        \else
    Handledare: \@supervisorAsFirstname\space\@supervisorAsLastname,  \@supervisorBsFirstname\space\@supervisorBsLastname,  \@supervisorCsFirstname\space\@supervisorCsLastname
    \\ \fi
    Examinator: \@examiner\\
    \quad\@examinersSchool\\
    \ifx\@hostcompany\@empty\relax\else Uppdragsgivare: \@hostcompany \\ \fi
    \ifx\@hostorganization\@empty\relax\else Uppdragsgivare: \@hostorganization \\ \fi
    \ifx\@alttitle\empty\relax\else Engelsk titel: %
    \begin{otherlanguage}{english}\sffamily\@alttitle\end{otherlanguage} \fi
    \ifx\@altsubtitle\@empty\relax
    \else
    English subtitle \begin{otherlanguage}{english}\sffamily\@altsubtitle\end{otherlanguage} \\
    \fi
  \else
    \@programme\\
    \ifx\@date\@empty\relax\else Date: \@date\\ \vspace{5mm} \fi
    
    \ifx\@supervisorBsLastname\@empty
    Supervisor: \@supervisorAsFirstname\space\@supervisorAsLastname
        \else
    Supervisors: \@supervisorAsFirstname\space\@supervisorAsLastname,  \@supervisorBsFirstname\space\@supervisorBsLastname,  \@supervisorCsFirstname\space\@supervisorCsLastname
    \\ \fi

    Examiner: \@examinersFirstname\space\@examinersLastname\\
    \quad\@examinersSchool\\
    \ifx\@hostcompany\@empty\relax\else Host company: \@hostcompany \\ \fi
    \ifx\@hostorganization\@empty\relax\else Host organization: \@hostorganization \\ \fi
    \ifx\@alttitle\empty\relax\else Swedish title: %
        \begin{otherlanguage}{swedish}\sffamily\@alttitle\end{otherlanguage}  \\ \fi
    \ifx\@altsubtitle\@empty\relax \else Swedish subtitle: %
        \begin{otherlanguage}{swedish}\sffamily\@altsubtitle\end{otherlanguage} \\ \fi
  \fi
\end{flushleft}
\restoregeometry
\clearpage
}

% Command to print out the standardized document information page
\newcommand{\bookinfopage}{
\ifgfivepaper
  \newgeometry{top=140mm,bottom=30mm,left=12.25mm,right=35mm}
\else
  \newgeometry{top=250mm,bottom=30mm,left=50mm,right=35mm}
\fi
\thispagestyle{empty}
\begin{flushleft}
  \sffamily
  \copyright\enspace\the\year\quad\@authorsFirstname\space\@authorsLastname 
  \ifx\@secondAuthorsLastname\@empty\relax
  \else
    \ifinswedish
      \enspace och\enspace\@secondAuthorsFirstname\space\@secondAuthorsLastname \\
    \else
      \enspace and\enspace\@secondAuthorsFirstname\space\@secondAuthorsLastname \\
    \fi
  \fi
\end{flushleft}
\restoregeometry
}

\newcommand{\acknowlegmentssignature}{
  \begin{flushleft}
    Stockholm, \MONTH\enspace\the\year\\
    \@authorsFirstname\space\@authorsLastname
    \ifx\@secondAuthorsLastname\@empty\relax
    \else
       \ifinswedish
       \enspace och\enspace\@secondAuthorsFirstname\space\@secondAuthorsLastname \\
       \else
       \enspace and\enspace\@secondAuthorsFirstname\space\@secondAuthorsLastname \\
       \fi
    \fi
  \end{flushleft}
\cleardoublepage
}

\newcommand{\frontmatter}{
  \pagenumbering{roman}
  \setcounter{page}{1}
}

\newcommand{\mainmatter}{
  \cleardoublepage
  \pagenumbering{arabic}
}

% {
%    "Author1":{
%	"Last name": "Maguire Jr.",
%	"First name": "Gerald Q.",
%	"Local User Id": "u1d13i2c",
%	"Research group": "CCS",
%	"E-mail": "maguire@kth.se",
%	"organisation": {"L1": "School of Information and Communication Technology (ICT)",
%			 "L2": "Communication Systems, CoS"
%			}
%    },
%    "Author2":{
%	"Last name": "Noz",
%	"First name": "Marilyn E.",
%	"E-mail": "men@bogus.org",
%	"Other organisation": "NYU"
%    },
%
%    "Cooperation":{
%	"Partner_name": "ABBBBA"
%    },
%    "Title":{
%	"Main title": "This is a long title in English",
%	"Subtitle": "This is an even longer subtitle in English",
%	"Language": "eng"	
%    },
%    "Alternative title":{
%	"Main title": "Detta är en lång titel på svenska",
%	"Subtitle": "Detta är en ännu längre undertexter på svenska",
%	"Language": "swe"
%    },
%    "Degree":{
%	"Level": "Independent thesis Basic level (degree of Bachelor)",
%	"University credits": "15 HE credits",
%	"Educational program": "Bachelor of Science in Engineering - Computer Engineering",
%	"Subject_course": "Communications Systems"
%    },
%    "Content category":{
%    },
%    "Other information":{
%	"Year": "2019",
%	"Number of pages": "xiii,72"
%    },
%    "Series":{
%	"Title of series": "TRITA-ICT-EX",
%	"No. in series": "2019:00"
%    },
%    "Other series":{
%	"Title of series": "",
%	"ISSN": "",
%	"EISSN": "",
%	"No. in series": ""
%    },
%    "Identifiers":{
%	"ISRN": "",
%	"DOI": "",
%	"DOI_Free_full_text": "",
%	"URL": "",
%	"URL label": "",
%	"URL_Free_full_text": ""
%    },
%    "National subject category":{
%	"L1": "Engineering and Technology",
%	"L2": "Electrical Engineering, Electronic Engineering, Information Engineering",
%	"L3": "Communication Systems"
%    },
%    "Part of project":{
%    },
%    "Part of other project":{
%	"Project_name": ""
%    },
%    "Keywords1":{
%	"Keywords": "Fiddle,Fee,Foo,Fum",
%	"Language": "eng"
%    },
%    "Keywords2":{
%	"Keywords": "Faddle,Fåå,Fää,Fööm",
%	"Language": "swe"
%    },
%    "Abstract1":{
%	"Abstract":	"<p>This is a abstract for an non existant thesis about <sup>18</sup>F<sup>-</sup></p>",
%	"Language": "eng"
%    },
%    "Abstract2":{
%	"Abstract":	"<p>Detta är ett abstrakt för en icke-existerande avhandling om <sup>18</sup>F<sup>-</sup></p>",
%	"Language": "swe"
%    },
%    "Supervisor1":{
%	"Last name": "Västberg",
%	"First name": "Anders",
%	"Academic title": "universitetslektor",
%	"Local User Id": "u1ft3a12",
%	"Research group": "RS",
%	"ORCiD": "0000-0002-4226-9652",
%	"E-mail": "vastberg@kth.se",
%	"organisation": {"L1": "School of Information and Communication Technology (ICT)",
%			 "L2": "Communication Systems, CoS",
%			 "L3": "Radio Systems Laboratory (RS Lab)"}
%    },
%    "Supervisor2":{
%	"Last name": "Normal",
%	"First name": "A. B.",
%	"E-mail": "ABNormal@example.org",
%	"Other organisation": "Famous Anvils"
%    },
%    "Examiner1":{
%	"Last name": "Maguire Jr.",
%	"First name": "Gerald Q.",
%	"Academic title": "professor",
%	"Local User Id": "u1d13i2c",
%	"ORCiD": "0000-0002-6066-746X",
%	"Research group": "CCS",
%	"E-mail": "maguire@kth.se",
%	"organisation": {"L1": "School of Information and Communication Technology (ICT)",
%			 "L2": "Communication Systems, CoS",
%			 "L3": "Radio Systems Laboratory (RS Lab)"}
%    },
%    "Presentation":{
%	"Date": "2019-07-25 4:31",
%	"Language": "eng",
%	"Room": "Seminar room Grimeton at COM",
%	"Address": "Kistagången 16, East, Floor 4, Elevator B",
%	"City": "Kista"
%    },
%    "Note" :{
%	"Note": "<p><span style='color: red;'>A completely bogus entry for testing with Puppeteer using diva5.js</span></p>"
%    },
%    "File" :{
%	"Filename": "/home/maguire/Diva/z2.pdf",
%	"Accept full text": "true"
%    }
%
%}

\newcommand{\divainfo}[2]{
\thispagestyle{empty}
    \sffamily\tiny
    \begin{flushleft}
    \{\\
        "Author1": \{ \\
        \ifx\@authorsLastname\@empty\relax
            \else
            \hspace{1cm}"Last name": "\@authorsLastname",\\
        \fi
        \ifx\@authorsFirstname\@empty\relax
            \else
            \hspace{1cm}"First name": "\@authorsFirstname",\\
        \fi
        \ifx\@kthid\@empty\relax
            \else
            \hspace{1cm}"Local User Id": "\@kthid",\\
        \fi
        \ifx\@email\@empty\relax
            \else
            \hspace{1cm}"E-mail": "\@email",\\
        \fi
        \ifx\@orcid\@empty\relax
            \else
            \hspace{1cm}"ORCiD": "\@orcid",\\
        \fi
        \ifx\@authorsSchool\@empty\relax
            \else
            \hspace{1cm}"organisation": \{"L1": "\@authorsSchool",\\
            \ifx\@authorsDepartment\@empty\relax
            \else
            \hspace{3cm}"L2": "\@authorsDepartment"
            \fi
			 \hspace{2.5cm}\}\\
		\fi
       \hspace{0.9cm}\},\\
    \ifx\@secondAuthorsLastname\@empty\relax
    \else
        "Author2": \{\\
                \ifx\@secondAuthorsLastname\@empty\relax
            \else
            \hspace{1cm}"Last name": "\@secondAuthorsLastname",\\
        \fi
        \ifx\@secondAuthorsFirstname\@empty\relax
            \else
            \hspace{1cm}"First name": "\@secondAuthorsFirstname",\\
        \fi
        \ifx\@secondkthid\@empty\relax
            \else
            \hspace{1cm}"Local User Id": "\@secondkthid",\\
        \fi
        \ifx\@secondemail\@empty\relax
            \else
            \hspace{1cm}"E-mail": "\@secondemail",\\
        \fi
        \ifx\@secondorcid\@empty\relax
            \else
            \hspace{1cm}"ORCiD": "\@secondorcid",\\
        \fi
        \ifx\@secondAuthorsSchool\@empty\relax
            \else
            \hspace{1cm}"organisation": \{"L1": "\@secondAuthorsSchool",\\
            \ifx\@secondAuthorsDepartment\@empty\relax
            \else
            \hspace{3cm}"L2": "\@secondAuthorsDepartment"
            \fi
			 \hspace{2.5cm}\}\\
		\fi
       \hspace{0.9cm}\},\\
    \fi
       "Degree": \{"Educational program": "\@programme"\},\\
       "Title": \{\\
            \hspace{1cm}"Main title": "\@title",\\
            \ifx\@subtitle\@empty\relax
            \else
            \hspace{1cm}"Subtitle": "\@subtitle",\\
            \fi
        \ifinswedish
            \hspace{1cm}"Language": "swe"
        \else
            \hspace{1cm}"Language": "eng"
        \fi
       \},\\
    "Alternative title": \{\\
	\hspace{1cm}"Main title": "\@alttitle",\\
        \ifx\@altsubtitle\@empty\relax
            \else
            \hspace{1cm}"Subtitle": "\@altsubtitle",\\
        \fi
        \ifinswedish
            \hspace{1cm}"Language": "eng"\\
        \else
            \hspace{1cm}"Language": "swe"\\
        \fi
    \},\\
    \ifx\@supervisorAsLastname\@empty\relax
        \else
    "Supervisor1": \{\\
            \hspace{1.5cm}"Last name": "\@supervisorAsLastname",\\
        \ifx\@supervisorAsFirstname\@empty\relax
            \else
            \hspace{1.5cm}"First name": "\@supervisorAsFirstname",\\
        \fi
        \ifx\@supervisorAsKTHID\@empty\relax
            \else
            \hspace{1.5cm}"Local User Id": "\@supervisorAsKTHID",\\
        \fi
        \ifx\@supervisorAsEmail\@empty\relax
            \else
            \hspace{1.5cm}"E-mail": "\@supervisorAsEmail",\\
        \fi
        \ifx\@supervisorAsOrganization\@empty
            \ifx\@supervisorAsSchool\@empty\relax
                \else
                \hspace{1.5cm}"organisation": \{"L1": "\@supervisorAsSchool",\\
                \ifx\@supervisorAsDepartment\@empty\relax
                \else
                \hspace{3cm}"L2": "\@supervisorAsDepartment"
                \fi
		    	\}\\
		    \fi
            \else
            \hspace{1.5cm}"Other organisation": "\@supervisorAsOrganization"\}\\
        \fi
       \hspace{1.2cm}\},\\
    \fi
    \ifx\@supervisorBsLastname\@empty\relax
        \else
    "Supervisor2": \{\\
            \hspace{1.5cm}"Last name": "\@supervisorBsLastname",\\
        \ifx\@supervisorBsFirstname\@empty\relax
            \else
            \hspace{1.5cm}"First name": "\@supervisorBsFirstname",\\
        \fi
        \ifx\@supervisorBsKTHID\@empty\relax
            \else
            \hspace{1.5cm}"Local User Id": "\@supervisorBsKTHID",\\
        \fi
        \ifx\@supervisorBsEmail\@empty\relax
            \else
            \hspace{1.5cm}"E-mail": "\@supervisorBsEmail",\\
        \fi
        \ifx\@supervisorBsOrganization\@empty
            \ifx\@supervisorBsSchool\@empty\relax
                \else
                \hspace{1.5cm}"organisation": \{"L1": "\@supervisorBsSchool",\\
                \ifx\@supervisorBsDepartment\@empty\relax
                \else
                \hspace{3cm}"L2": "\@supervisorBsDepartment"
                \fi
		    	\}\\
		    \fi
            \else
            \hspace{1.5cm}"Other organisation": "\@supervisorBsOrganization"\}\\
        \fi
       \hspace{1.2cm}\},\\
    \fi
    \ifx\@supervisorCsLastname\@empty\relax
        \else
    "Supervisor3": \{\\
            \hspace{1.5cm}"Last name": "\@supervisorCsLastname",\\
        \ifx\@supervisorCsFirstname\@empty\relax
            \else
            \hspace{1.5cm}"First name": "\@supervisorCsFirstname",\\
        \fi
        \ifx\@supervisorCsKTHID\@empty\relax
            \else
            \hspace{1.5cm}"Local User Id": "\@supervisorCsKTHID",\\
        \fi
        \ifx\@supervisorCsEmail\@empty\relax
            \else
            \hspace{1.5cm}"E-mail": "\@supervisorCsEmail",\\
        \fi
        \ifx\@supervisorCsOrganization\@empty
            \ifx\@supervisorCsSchool\@empty\relax
                \else
                \hspace{1.5cm}"organisation": \{"L1": "\@supervisorCsSchool",\\
                \ifx\@supervisorCsDepartment\@empty\relax
                \else
                \hspace{3cm}"L2": "\@supervisorCsDepartment"
                \fi
		    	\}\\
		    \fi
            \else
            \hspace{1.5cm}"Other organisation": "\@supervisorCsOrganization"\}\\
        \fi
       \hspace{1.2cm}\},\\
    \fi
    \ifx\@examinersLastname\@empty\relax
        \else
    "Examiner1": \{\\
            \hspace{1.5cm}"Last name": "\@examinersLastname",\\
        \ifx\@examinersFirstname\@empty\relax
            \else
            \hspace{1.5cm}"First name": "\@examinersFirstname",\\
        \fi
        \ifx\@examinersKTHID\@empty\relax
            \else
            \hspace{1.5cm}"Local User Id": "\@examinersKTHID",\\
        \fi
        \ifx\@examinersEmail\@empty\relax
            \else
            \hspace{1.5cm}"E-mail": "\@examinersEmail",\\
        \fi
        \ifx\@examinersOrganization\@empty
            \ifx\@examinersSchool\@empty\relax
                \else
                \hspace{1.5cm}"organisation": \{"L1": "\@examinersSchool",\\
                \ifx\@examinersDepartment\@empty\relax
                \else
                \hspace{3cm}"L2": "\@examinersDepartment"
                \fi
		    	\}\\
		    \fi
            \else
            \hspace{1.5cm}"Other organisation": "\@examinersOrganization"\}\\
        \fi

       \hspace{1.2cm}\},\\
    \fi
    \ifx\@hostcompany\@empty\relax\else
    "Cooperation": \{ "Partner\_name": "\@hostcompany"\},\\
    \fi
    \ifx\@hostorganization\@empty\relax\else "Host organization": "\@hostorganization"\\\fi
    "Other information": \{\\
      "Year": "\the\year",
      "Number of pages": \char`\"\pageref{#1},\pageref{#2}\char`\"
    \}\\
   \}
    \end{flushleft}
\clearpage
}


\endinput
