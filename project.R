library(tidyverse)
library(ggcorrplot)
library(MASS)
library(leaps)
load("project_data.RData")
head(lse)

# changing the dataset to dataframe 
d <- as.data.frame(lse)

# correlation 
d <- d[, -(1:4)]
l<- cor(d)
lol <- round(l, 3)
part1 <- ggcorrplot(lol, hc.order = TRUE, type = "lower",
                    lab = TRUE)+labs(title = "Correlation Matrix between Closing stock prices")
part1

# regression 
mult_mod <- lm(BA~STJ+AHT+GVC+CCH+ANTO, data= d)
summary(mult_mod)
plot(mult_mod)

# the ANOVA table 
anova(mult_mod)

# an extended version of the aonova table 
dfR <- nrow(d) - length(coef(mult_mod))
dfM <- length(coef(mult_mod))-1
dfT <- nrow(d) - 1
RSS <- sum(resid(mult_mod)^2)
TSS <- sum((d$BA - mean(d$BA))^2)
MSS <- TSS - RSS
MSR <- RSS/dfR
MSM <- MSS/dfM
F <- MSM/MSR

# goodness of the fit of the model
l <- d
l <- l[, -(3:5)]
l <- l[,-(4:5)]
l <- l[,-(6:22)]

reg <- function(x, y, col) abline(lm(y~x), col=col) 

panel.lm =  function (x, y, col = par("col"), bg = NA, pch = par("pch"), 
                      cex = 1, col.smooth = "red", span = 2/3, iter = 3, ...)  {
  points(x, y, pch = pch, col = col, bg = bg, cex = cex)
  ok <- is.finite(x) & is.finite(y)
  if (any(ok)) reg(x[ok], y[ok], col.smooth)
}

pairs(l[1:6], panel = panel.lm,
      cex = 1.5, pch = 19, col = adjustcolor(4, .4), cex.labels = 2, 
      font.labels = 2)

# new model normalizaing the data 
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x))) } 
D <- normalize(d)
View(D)

# plot each independent against the  dependent 

# stj

mod3 <- lm(BA~STJ, data = D)
plot(mod3)
abline(mod3)

# RB 
mod4 <- lm(BA~RB, data = D)
plot(mod4)
abline(mod4)

# min
mod5 <- lm(BA~MIN, data = D)
plot(mod5)
abline(mod5)

# PRU
mod6 <- lm(BA~PRU, data = D)
plot(mod6)
abline(mod6)

# cch 
mod7 <- lm(BA~CCH, data = D)
plot(mod7)
abline(mod7)

# EXPN 
mod8 <- lm(BA~EXPN, data = D)
plot(mod8)
abline(mod8)

# VOD
mod9 <- lm(BA~VOD, data = D)
plot(mod9)
abline(mod9)

#GVC 
mod10 <- lm(BA~GVC, data = D)
plot(mod10)
abline(mod10)

# AHT 
mod11 <- lm(BA~AHT, data = D)
plot(mod11)
abline(mod11)

# cpg
mod12 <- lm(BA~CPG, data = D)
plot(mod12)
abline(mod12)

#CCL
mod13 <- lm(BA~CCL, data = D)
plot(mod13)
abline(mod13)

# RR
mod14<- lm(BA~RR, data = D)
plot(mod14)
abline(mod14)

# DLG 
mod15 <- lm(BA~DLG, data = D)
plot(mod15)
abline(mod15)

#tui 
mod16 <- lm(BA~TUI, data = D)
plot(mod16)
abline(mod16)

#lloy

mod17 <- lm(BA~LLOY, data = D)
plot(mod17)
abline(mod17)

#RMV 
mod18 <- lm(BA~RMV, data = D)
plot(mod18)
abline(mod18)

# sse 
mod19 <- lm(BA~SSE, data = D)
plot(mod19)
abline(mod19)

# sdr 
mod20 <-lm(BA~SDR, data = D)
plot(mod20)
abline(mod20)

#smt 
mod21 <- lm(BA~SMT, data = D)
plot(mod21)
abline(mod21)

# ezj 
mod22 <- lm(BA~EZJ, data = D)
plot(mod22)
abline(mod22)

# NMC 
mod23 <- lm(BA~NMC, data = D)
plot(mod23)
abline(mod23)

# BATS
mod24 <- lm(BA~BATS, data = D)
plot(mod24)
abline(mod24)

#spx
mod25 <- lm(BA~SPX, data = D)
plot(mod25)
abline(mod25)

# TSco
mod26 <- lm(BA~TSCO, data = D)
plot(mod26)
abline(mod26)

# CNA 
mod27 <- lm(BA~CNA, data = D)
plot(mod27)
abline(mod27)

# RTO 

mod28 <- lm(BA~RTO, data = D)
plot(mod28)
abline(mod28)

#ANTO 
mod29 <- lm(BA~ANTO, data = D)
plot(mod29)
abline(mod29)


# transform based on curvness of turkey rule

#take sse 3

D$SSE1 <- log(D$SSE)
D$SSE2 <- D$SSE^(2)
D$SSE3 <- D$SSE^(3)


lm5 <- lm(BA~SSE1, data = D)
lm6 <- lm(BA~SSE2, data = D)
lm7 <- lm(BA~SSE3, data = D)
lm8 <- lm(BA~SSE, data = D)

summary(lm5)
summary(lm6)
summary(lm7)
summary(lm8)


plot(lm5, which = c(1,2), ask = F)
plot(lm6, which = c(1,2), ask = F)
plot(lm7, which = c(1,2), ask = F)


# 2 IS A GOOD TRANSFORMATION
D$MIN1 <- log(D$MIN)
D$MIN2 <- D$MIN^(2)
D$MIN3 <- D$MIN^(3)

lm9 <- lm(BA~MIN1, data = D)
lm10 <- lm(BA~MIN2, data = D)
lm11 <- lm(BA~MIN3, data = D)
lm12 <- lm(BA~MIN, data = D)

summary(lm9)
summary(lm10)
summary(lm11)
summary(lm12)


plot(lm9, which = c(1,2), ask = F)
plot(lm10, which = c(1,2), ask = F)
plot(lm11, which = c(1,2), ask = F)

# we keep the normal cch
D$CCH1 <- log(D$CCH)
D$CCH2 <- D$CCH^(2)
D$CCH3 <- D$CCH^(3)


lm13 <- lm(BA~CCH1, data = D)
lm14 <- lm(BA~CCH2, data = D)
lm15 <- lm(BA~CCH3, data = D)
lm16 <- lm(BA~SSE, data = D)

summary(lm13)
summary(lm14)
summary(lm15)
summary(lm16)

plot(lm13, which = c(1,2), ask = F)
plot(lm14, which = c(1,2), ask = F)
plot(lm15, which = c(1,2), ask = F)

# cna 3 THE BEST MODEL  
D$CNA1 <- log(D$CCH)
D$CNA2 <- D$CNA^(2)
D$CNA3 <- D$CNA^(3)

lm17 <- lm(BA~CNA1, data = D)
lm18 <- lm(BA~CNA2, data = D)
lm19 <- lm(BA~CNA3, data = D)
lm20 <- lm(BA~CNA, data = D)



summary(lm17)
summary(lm18)
summary(lm19)
summary(lm20)

plot(lm17, which = c(1,2), ask = F)
plot(lm18, which = c(1,2), ask = F)
plot(lm19, which = c(1,2), ask = F)
# AHT 
# WE THE NORMAL AHT 

D$AHT1 <- log(D$AHT)
D$AHT2 <- D$AHT^(-0.5)

lm21 <- lm(BA~AHT1, data = D)
lm22 <- lm(BA~AHT2, data = D)
lm23 <- lm(BA~AHT, data = D)

summary(lm21)
summary(lm22)
summary(lm23)


plot(lm21, which = c(1,2), ask = F)
plot(lm22, which = c(1,2), ask = F)
plot(lm23, which = c(1,2), ask = F)

#rto 

D$RTO1 <- log(D$RTO)
D$RTO2 <- D$RTO^(2)
D$RTO3 <- D$RTO^(-2)

lm24 <- lm(BA~RTO1, data = D)
lm25 <- lm(BA~RTO2, data = D)
lm26 <- lm(BA~RTO3, data = D)
lm27 <- lm(BA~RTO, data = D)



summary(lm24)
summary(lm25)
summary(lm26)
summary(lm27)


plot(lm24, which = c(1,2), ask = F)
plot(lm25, which = c(1,2), ask = F)
plot(lm26, which = c(1,2), ask = F)

##leaps



leap.mod <- leaps(D[,-ncol(D)], housing$BA,
method="adjr2", nbest=5, names=names(D)[-ncol(D)])



result.tab <- data.frame(adjr2=leap.mod$adjr2,
                         size=leap.mod$size,
                         leap.mod$which,
                         row.names=NULL)

head(leaps_results.tab)


# base r plot
plot(adjr2~size, data=result.tab)

##after 15 small change in adjusted r2
## 15 variables
leaps_results.tab %>%
  filter(size== 15)


## 17 variables
leaps_results.tab %>%
  filter(size== 17)

## 22 variables
leaps_results.tab %>%
  filter(size== 22)



# fit the chosen models
leaps_l1 <- lm(formula = BA ~  STJ + RB + PRU + CCH + VOD + 
                 GVC + CPG + DLG + SDR + NMC +SPX + TSCO + RTO + logAHT , data = lse_leaps)

leaps_l2 <- lm(formula = BA ~  STJ + RB + PRU + CCH + EXPN + VOD +
                 GVC + CPG + DLG + SDR + NMC +SPX + TSCO + RTO + logAHT + LLOY, data = lse_leaps)

leaps_l3 <- lm(formula = BA ~  STJ+RB+PRU+CCH+ EXPN+VOD+GVC+CPG+DLG+  
                LLOY+RMV+SDR+SMT+EZJ+NMC+BATS+SPX+TSCO+RTO+MIN3+logAHT, data = lse_leaps)
summary(leaps_l1)
summary(leaps_l2)
summary(leaps_l3)


# variable selection (backwards)
dep <- lm(BA~ ., data=D)


# use backward selection
drop1(dep, test = "F")
dep2 <- lm(BA~STJ + RB + MIN2 + VOD + CPG+ DLG + SDR + SMT +NMC+ BATS + 
            SSE3 + CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, data=D)
drop1(dep2, scope = ~ STJ + RB + MIN2 + VOD + CPG+ DLG + SDR + SMT +NMC+ BATS + 
        SSE3 + CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, test = "F")
dep3 <- lm(BA~ STJ + MIN2 + VOD + CPG+ DLG + SDR + SMT +NMC+ BATS + 
             SSE3 + CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, data=D)
drop1(dep3, scope= ~ STJ + MIN2 + VOD + CPG+ DLG + SDR + SMT +NMC+ BATS + 
           SSE3 + CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, test = "F")
dep4 <- lm(BA~ STJ + MIN2 + VOD + CPG+ DLG  +NMC+ BATS + 
             SSE3 + CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, data=D)
drop1(dep4,scope= ~ STJ + MIN2 + VOD + CPG+ DLG  +NMC+ BATS + 
        SSE3 + CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, test = "F" )
dep5<- lm(BA~ STJ + MIN2 + VOD + CPG+ DLG + NMC + BATS + 
            CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, data=D)
drop1(dep5,scope= ~ STJ + MIN2 + VOD + CPG+ DLG  +NMC+ BATS + 
        CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, test = "F")
dep6 <-lm(BA~ STJ + VOD + CPG+ DLG + NMC + BATS + 
            CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, data=D) 
drop1(dep6,scope= ~ STJ + VOD + CPG+ DLG  +NMC+ BATS + 
        CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, test = "F")

## variable selection
#forward

# fit the full model
m1 <- lm(BA ~ 1, data=D)

add1(m1, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m2 <- lm(BA ~ STJ, data=D)

add1(m2, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m3 <- lm(BA ~ STJ + DLG, data=D)

add1(m3, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m4 <- lm(BA ~ STJ + DLG + BATS, data=D)

add1(m4, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m5 <- lm(BA ~ STJ + DLG + BATS + VOD, data=D)

add1(m5, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m6 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO, data=D)

add1(m6, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m7 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC, data=D)

add1(m7, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m8 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG, data=D)

add1(m8, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m9 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX, data=D)

add1(m9, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m10 <-  lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + log(AHT), data=D)

add1(m10, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + log(AHT) + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m11 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3, data=D)

add1(m11, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + log(AHT) + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m12 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB, data=D)
add1(m12, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + log(AHT) + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m13 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU, data=D)

add1(m13, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + log(AHT) + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m14 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO, data=D)

add1(m14, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + log(AHT) + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m15 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH, data=D)

add1(m15, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m16 <-lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR, data=D)

add1(m16, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m17 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT, data=D)

add1(m17, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m18 <-lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV, data=D)

add1(m18, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m19 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV +LLOY, data=D)

add1(m19, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m20 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV +LLOY + EXPN, data=D)

add1(m20, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m21 <-lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV +LLOY + EXPN +NMC, data=D)

add1(m21, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m22 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV +LLOY + EXPN +NMC +EZJ, data=D)

add1(m22, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m23 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV +LLOY + EXPN +NMC +EZJ + SSE3, data=D)

add1(m23, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m24 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV +LLOY + EXPN +NMC +EZJ + SSE3 +CCL, data=D)

add1(m24, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m25 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV +LLOY + EXPN +NMC +EZJ + SSE3 +CCL +RR, data=D)

add1(m25, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

m26 <- lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV +LLOY + EXPN +NMC +EZJ + SSE3 +CCL +RR +CNA3, data=D)

add1(m26, scope= ~ STJ + RB + MIN3 + PRU + CCH + EXPN + VOD + GVC + logAHT + CPG +
       CCL + RR + DLG + TUI + LLOY + RMV +SSE3 + SDR + SMT + EZJ + NMC + BATS + SPX + TSCO +CNA3 +RTO + ANTO ,
     test="F")

forwardmodel <-  lm(BA ~ STJ + DLG + BATS + VOD +RTO + GVC +CPG+SPX + logAHT
                    + MIN3 + RB + PRU+ TSCO + CCH +SDR +SMT +RMV +LLOY + EXPN 
                    +NMC +EZJ + SSE3 +CCL +RR +CNA3, data=D)

summary(forwardmodel)



finalmodel <- lm(BA ~ STJ + VOD + CPG+ DLG  +NMC+ BATS + 
                   CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, data= D)
summary(finalmodel)

# checking the assumptions
# constant variance 
plot(finalmodel, which = 1)

# normal q-q
plot(finalmodel, which= 2)

# errors 
acf(residuals(finalmodel))

# transforming depandant 
boxcox(finalmodel)

root.finalmodel <- lm(BA~ STJ + VOD + CPG+ DLG  +NMC+ BATS + 
                        CNA3 + RTO + ANTO+ LLOY + AHT+ RTO, data= D)
summary(root.finalmodel)
acf(residuals(root.finalmodel))

## MODEL ACCORDING TO STEPWISE SELECTION

stepwisemodel <-lm(formula = BA ~ STJ + DLG + BATS + VOD + RTO + GVC + CPG + 
                  SPX + logAHT + MIN3 + RMV + SSE3 + CCL + TSCO + CCH + SMT + 
                  RB + PRU + SDR + LLOY + EXPN + NMC + TUI + RR, data = lse_leaps)
summary(stepwisemodel)

CP_PRESS <- function(model, sigma_full){
res <- resid(model)
hat_mod <- hatvalues(model)
CP <- sum(res^2)/sigma_full + 2*length(coef(model)) - length(res)
PRESS <- sum(res^2/(1-hat_mod)^2)
list(Cp=CP, PRESS=PRESS)
}
sigma_q <- summary(full.mod)$sigma^2
size8_stat <- CP_PRESS(size15, sigma_q)
size9_stat <- CP_PRESS(size17, sigma_q)
size10_stat <- CP_PRESS(size22, sigma_q)
sel_stat <- CP_PRESS(mod, sigma_q)
