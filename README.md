##########################################################################################################################################################
# ImmuneCircadianSystem
Source code for "Modeling the circadian regulation of the immune system: Sexually dimorphic effects of shift work. PLoS computational biology, 17(3), e1008514".

Author summary: Shift work has a negative impact on health and can lead to chronic diseases and illnesses. Under regular work schedules, rest is a night time activity and work a daytime activity. Shift work relies on irregular work schedules which disrupt the natural sleep-wake cycle. This can in turn disrupt our biological clock, called the circadian clock, a network of molecular interactions generating biochemical oscillations with a near 24-hour period. Clock genes regulate cytokines before and during infection and immune agents can also impact the clock function. We provide a mathematical model of the circadian clock in the rat lung coupled to an acute inflammation model to study how the disruptive effect of shift work manifests itself in males and females during inflammation. Our results show that the extent of sequelae experienced by male and female rats depends on the time of infection. The goal of this study is to provide a mechanistic insight of the dynamics involved in the interplay between these two systems.
##########################################################################################################################################################

There are three main models:
1) Control model --> mainMod
2) CJL male model --> maleMod
3) CJL female model --> femMod
Each model can be called/simulated using the associated "call function": call_mainMod, call_maleMod, and call_femMod.
#---------------------------------------------------------------------------------------------------------------------------------------------------------

There are three figure files to reproduce all figures in the published version of the manuscript
1) Figs_validation: reproduces figures 2-4
2) Figs_KOexp: reproduces knockout (KO) experiment figure 7
3) Figs_CJL: reproducs CJL-related figures. Namely, figures 5, 6, 8, and 9
* Note: Figs_KOexp has an assocated function called KOexp.m which allows the user to choose the type of KO experiement to perform
#---------------------------------------------------------------------------------------------------------------------------------------------------------

There are three driver files
1) driver_period: computes the period of oscillations
2) driver_phase: computes phase differences between oscillatory signals in the control model vs male/female CJL models
3) driver_CJLscaling: computes percentage change in mean gene expression levels due to CJL
#---------------------------------------------------------------------------------------------------------------------------------------------------------

Two .zip files are provided containing all figures from the manuscript and all figures from the supporting information document
