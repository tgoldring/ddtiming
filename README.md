# ddtiming

  ddtiming is a Stata command that implements a decomposition of a difference-in-differences (DD) estimator with variation in treatment timing, based on [Goodman-Bacon (2021)](https://doi.org/10.1016/j.jeconom.2021.03.014). The two-way fixed effects DD model is a weighted average of all possible two-group/two period DD estimators. The command generates a scatterplot of 2x2 DD estimates and their associated weights.

## Caution
ddtiming is not under active development. Stata users should instead use [bacondecomp](https://ideas.repec.org/c/boc/bocode/s458676.html), a more recent implementation of the Bacon decomposition in Stata.

## R Users
An R package called [bacondecomp](https://cran.r-project.org/web/packages/bacondecomp/index.html) is available to perform the decomposition.

## Installation
Type the following command:

    net install ddtiming, from(https://github.com/tgoldring/ddtiming)

## Example - No-Fault Divorce Laws
ddtiming can replicate the example in Goodman-Bacon (2021). Download and load a dataset with the timing of no-fault divorce laws and female suicide rates (Stevenson & Wolfers, 2006):

    net get ddtiming, from(https://github.com/tgoldring/ddtiming)

    use nofault_divorce.dta

For comparison, estimate a two-way fixed effects DD model of female suicide on no-fault divorce reforms:

    areg asmrs treat i.year, a(state) vce(robust)

Apply the DD decomposition theorem in Goodman-Bacon (2021) to the two-way fixed effects DD model:

    ddtiming asmrs treat, i(state) t(year)

Stata will produce DD estimates, the associated weights, and a scatterplot of the estimates. The scatterplot replicates Fig. 6 in Goodman-Bacon (2021). Additionally, we can add options to the command to modify the look of the scatterplot:

    ddtiming asmrs treat, i(state) t(year) ddline(lwidth(thick)) ///
    ylabel(-30(10)30) legend(order(3 4 1 2)) savegraph(nfd.jpg) ///
    savedata(nfd) replace

This command demonstrates the use of ddtiming's options (ddline, savegraph, savedata, and twoway options ylabel and legend). For descriptions of all options and additional help, type

    help ddtiming

## Citation
Please cite ddtiming as:

Goldring, T. (2019). *ddtiming: Stata module to perform a Goodman-Bacon decomposition of difference-in-differences estimation.* https://github.com/tgoldring/ddtiming

## References
Goodman-Bacon, A. (2021). [Difference-in-differences with variation in treatment timing](https://doi.org/10.1016/j.jeconom.2021.03.014). *Journal of Econometrics, 225*(2), 254-277.

Stevenson, B., & Wolfers, J. (2006). [Bargaining in the Shadow of the Law: Divorce Laws and Family Distress](https://doi.org/10.1093/qje/121.1.267). *The Quarterly Journal of Economics, 121*(1): 267-288.