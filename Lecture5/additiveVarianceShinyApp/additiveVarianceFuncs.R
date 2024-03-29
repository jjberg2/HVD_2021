getPheno <- function(alpha,d)
    c(-alpha,d,alpha)

getGenoFreqs <- function(p)
    c((1-p)^2,2*p*(1-p),p^2)

getAddVar <- function(p,alpha,d){
    add.var <- 2*p*(1-p)*(alpha+(1-2*p)*d)^2
    return(add.var)
}
getDomVar <- function(p,alpha,d){
    dom.var <- (2*p*(1-p)*d)^2
    return(dom.var)
}


propAddPlot <- function(input,xlims,ylims,xlabel,ylabel){
    my.x <- 1:99/100
    alpha <- 1
    d <- input

    add.vars <- getAddVar(my.x,alpha,d)
    dom.vars <- getDomVar(my.x,alpha,d)

    tot.vars <- add.vars+dom.vars
    prop.add <- add.vars/tot.vars

    special.x <- c(0.01,0.25,0.5,0.75,0.99)
    special.adds <- getAddVar(special.x,alpha,d)
    special.doms <- getDomVar(special.x,alpha,d)

    special.tots <- special.adds+special.doms
    special.props <- special.adds/special.tots
    these <- my.x %in% special.x

    freq.weight.add.vars <- add.vars/(my.x*(1-my.x))
    freq.weight.tot.vars <- tot.vars/(my.x*(1-my.x))

    var.frac <- sum(freq.weight.add.vars)/sum(freq.weight.tot.vars)


    cols <- blue2red(length(tot.vars))
    plot(
        tot.vars,
        prop.add,
        pch=20,
        col=cols,
        bty='n',
        xlim=xlims,
        ylim=ylims,
        xlab=xlabel,
        ylab=ylabel
    )
    points(
        x=special.tots,
        y=special.props,
        pch=21,
        col='black',
        bg=cols[these]
    )
    text(
        x=0.85,
        y=0.41,
        labels='Allele Frequency'
    )
    text(
        x=0.37,
        y=0.17,
        labels="Proportion of variance that is additive when allele"
    )
    text(
        x=0.37,
        y=0.22,
        labels="frequencies follow the neutral frequency spectrum"
    )
    text(
        x=0.6,
        y=0.2,
        labels=paste("= ",round(var.frac,3)),
        cex=1.4
    )
    legend(
        x=0.8,
        y=0.4,
        legend=special.x,
        pch=21,
        pt.bg=cols[these],
        bty='n'
    )
}
