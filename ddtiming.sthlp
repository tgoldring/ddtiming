{smcl}
{* *! version 0.1  11nov2018}{...}
{viewerjumpto "Syntax" "ddtiming##syntax"}{...}
{viewerjumpto "Description" "ddtiming##description"}{...}
{viewerjumpto "Options" "ddtiming##options"}{...}
{viewerjumpto "Examples" "ddtiming##examples"}{...}
{viewerjumpto "Saved results" "ddtiming##saved_results"}{...}
{title:Title}

{phang}
{bf:ddtiming} {hline 2} Difference-in-differences estimation with variation in treatment timing


{marker syntax}{title:Syntax}

{p 8 17 2}
{cmd:ddtiming}
{varlist} {ifin}
[{cmd:,} {it:options}]

{pstd}
where {it:varlist} is
{p_end}
		{it:outcome treatment_indicator}

{synoptset 30 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt i(panelvar)}}specify panel variable{p_end}
{synopt:{opt t(timevar)}}specify time variable{p_end}

{syntab:Graph Style}
{synopt:{opt m:symbols(symbolstylelist)}}ordered list of symbols{p_end}
{synopt:{opt mc:olors(colorstylelist)}}ordered list of colors for the markers{p_end}
{synopt:{opt msiz:es(markersizestylelist)}}ordered list of sizes for the markers{p_end}
{synopt:{opt ddl:ine(linesuboptions)}}suboptions to control look of line showing overall diff-in-diff estimate{p_end}
{synopt:{opt nol:ine}}removes line showing overall diff-in-diff estimate{p_end}
{synopt:{it:{help twoway_options}}}{help title options:titles}, {help legend option:legends}, {help axis options:axes}, added {help added line options:lines} and {help added text options:text},
	{help region options:regions}, {help name option:name}, {help aspect option:aspect ratio}, etc.{p_end}

{syntab:Save Output}
{synopt:{opt savegraph(filename)}}save graph to file; format automatically detected from extension [ex: .gph .jpg .png]{p_end}
{synopt:{opt savedata(filename)}}save {it:filename}.csv containing scatterpoint data, and {it:filename}.do to process dta into graph{p_end}
{synopt:{opt replace}}overwrite existing files{p_end}
{synoptline}


{marker description}{...}
{title:Description}

{pstd}
{cmd:ddtiming} implements a decomposition of a difference-in-differences (DD)
estimator with variation in treatment timing, based on Goodman-Bacon (2018). The
two-way fixed effects DD model is a weighted average of all possible
two-group/two period DD estimators. The command generates a scatterplot of 2x2
difference-in-difference estimates and their associated weights.

{pstd}
{cmd:ddtiming} shows up to four types of two-group/two period comparisons, 
which differ by comparison group: (1) A group treated later serves as the comparison
group for an earlier treatment group; (2) A group treated earlier serves as the 
comparison group for a later treatment group; (3) A group which never receives the 
treatment serves as the comparison group; and (4) A group treated prior to the 
start of the analysis serves as the comparison group.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt i(panelvar)} identifies the panels. This option must be specified.

{phang}
{opt t(timevar)} identifies the times within panels. This option must be specified.

{dlgtab:Graph Style}

{phang}
{opt msymbols(symbolstylelist)} specifies an ordered list of symbols for each
DD comparison type.

{phang}
{opt mcolors(colorstylelist)} specifies an ordered list of colors for each
DD comparison type.

{phang}
{opt msizes(markersizestylelist)} specifies an ordered list of sizes for each 
DD comparison type.

{phang}
{opt ddline(linesuboptions)} allows added line suboptions to be passed to the 
line that shows the (overall) two-way fixed effects DD estimate.

{phang}
{opt noline} removes the added line showing the (overall) two-way fixed effects
DD estimate.

{phang}{it:{help twoway_options}}:

{pmore}Any unrecognized options added to {cmd:ddtiming} are appended to the end 
of the twoway command which generates the scatter plot.

{pmore}These can be used to control the graph {help title options:titles},
{help legend option:legends}, {help axis options:axes}, 
added {help added line options:lines} and {help added text options:text},
{help region options:regions}, {help name option:name}, 
{help aspect option:aspect ratio}, etc.

{dlgtab:Save Output}

{phang}{opt savegraph(filename)} saves the graph to a file.  The format is 
automatically detected from the extension specified [ex: {bf:.gph .jpg .png}],
and either {cmd:graph save} or {cmd:graph export} is run.  If no file 
extension is specified {bf:.gph} is assumed.

{phang}{opt savedata(filename)} saves {it:filename}{bf:.csv} containing the 
scatterpoint data, and {it:filename}{bf:.do} which
loads the scatterpoint data, labels the variables, and plots the graph.

{phang}{opt replace} specifies that files be overwritten if they already exist.


{marker examples}{...}
{title:Examples}

{pstd}Load data that replicates Stevenson and Wolfers' (2006) analysis of 
no-fault divorce reforms and female suicide.{p_end}
{phang2}. {stata use nofault_divorce.dta}{p_end}

{pstd}Estimate a two-way fixed effect DD model of female suicide on no-fault 
divorce reforms.{p_end}
{phang2}. {stata areg asmrs treat i.year, a(state) robust}{p_end}

{pstd}Apply the DD decomposition theorem in Goodman-Bacon (2018) to the two-way
fixed effects DD model.{p_end}
{phang2}. {stata ddtiming asmrs treat, i(state) t(year)}{p_end}

{pstd}Adjust graph options.{p_end}
{phang2}. {stata ddtiming asmrs treat, i(state) t(year) ddline(lwidth(thick)) legend(order(3 4 1 2)) ylabel(-30(10)30)}{p_end}


{marker saved_results}{...}
{title:Saved Results}


{pstd}
{cmd:ddtiming} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(dd)}}difference-in-difference estimate{p_end}
{synopt:{cmd:e(dd_avg_e)}}average DD estimate: Earlier T vs. later C{p_end}
{synopt:{cmd:e(dd_avg_l)}}average DD estimate: Later T vs. earlier C{p_end}
{synopt:{cmd:e(dd_avg_u)}}average DD estimate: T vs. never treated {it:(if comparison exists)}{p_end}
{synopt:{cmd:e(dd_avg_a)}}average DD estimate: T vs. already treated {it:(if comparison exists)}{p_end}
{synopt:{cmd:e(wt_sum_e)}}comparison type weight: Earlier T vs. later C{p_end}
{synopt:{cmd:e(wt_sum_l)}}comparison type weight: Later T vs. earlier C{p_end}
{synopt:{cmd:e(wt_sum_u)}}comparison type weight: T vs. never treated {it:(if comparison exists)}{p_end}
{synopt:{cmd:e(wt_sum_a)}}comparison type weight: T vs. already treated {it:(if comparison exists)}{p_end}


{marker references}{...}
{title:References}

{pstd}Goodman-Bacon, Andrew. 2018.
{browse "https://s3.amazonaws.com/vu-my/wp-content/uploads/sites/2318/2018/09/10091642/ddtiming_9_5_2018.pdf":"Differences-in-differences with variation in treatment timing"}.
{it:Working paper}.{p_end}

{pstd}Stevenson, Betsey and Justin Wolfers. 2006. {browse "https://doi.org/10.1093/qje/121.1.267":"Bargaining in the Shadow of the Law: Divorce Laws and Family Distress"}. {it:The Quarterly Journal of Economics} 121(1):267-288.{p_end}


{marker author}{...}
{title:Author}

{pstd}Thomas Goldring{p_end}
{pstd}thomasgoldring@gmail.com{p_end}
