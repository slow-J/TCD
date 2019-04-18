#!/usr/bin/env python
# in python3
import sys
from decimal import *

PDeadIfDead = 1

PExerciseDead=0.1
PRelaxDead=0.01

PFitExerciseFit = 0.891 #0.99
PFitExerciseUnfit = 0.009 
PUnfitExerciseUnfit = 0.72 #0.8
PUnfitExerciseFit = 0.18 #0.2

PFitRelaxFit = 0.693 #0.7
PFitRelaxUnfit = 0.297
PUnfitRelaxUnfit = 0.99
PUnfitRelaxFit = 0

RDead = 0

RExerciseFit = 8
RExerciseUnfit = 0

RRelaxFit = 10
RRelaxUnfit = 5


def main():
    
    S = ["fit", "unfit", "dead"]
    A = ["exercise", "relax"]
    
    global QExerciseIfFit
    QExerciseIfFit = []
    global QExerciseIfUnfit
    QExerciseIfUnfit = []
    
    global QRelaxIfFit
    QRelaxIfFit = []
    global QRelaxIfUnfit
    QRelaxIfUnfit = []

    global VFit
    VFit = []
    global VUnfit
    VUnfit = []
    
    global RAlive
    RAlive = 1
    global G
    global startingState
    
    maxCount = int(input("Enter no of iterations: "))
    G = float(input("Enter G (between 0-1): "))
    while G > 1 or G < 0:
        G = float(input("Enter G (between 0-1): "))
        
    startingState = input("Enter starting state: ")    
    while startingState not in S :
        startingState = input("Enter starting state: ")
 
    if startingState == 'dead':
        RAlive=RDead
    count = 0
    q0()
    if startingState == 'fit':    
        print("count=", count, "exercise", QExerciseIfFit[count])
        print("count=", count, "relax", QRelaxIfFit[count])
    elif startingState == 'unfit':
        print("count=", count, "exercise", QExerciseIfUnfit[count])
        print("count=", count, "relax", QRelaxIfUnfit[count])
    else:
        print("count=", count, "dead", QExerciseIfFit[count])
        
    while count < maxCount:
        vn(count)
        qn(count)
        if startingState == 'fit':    
            print("count=", count+1, "exercise", QExerciseIfFit[count])
            print("count=", count+1, "relax", QRelaxIfFit[count])
        elif startingState == 'unfit':
            print("count=", count+1, "exercise", QExerciseIfUnfit[count])
            print("count=", count+1, "relax", QRelaxIfUnfit[count])
        else:
            print("count=", count+1, "dead", QExerciseIfFit[count])
        count = count+1
    
    # so box doesnt disappear
    input()


def q0():
    # q0(s,a) = p(s, a, fit)r(s, a, fit) + p(s, a, unfit)r(s, a, unfit)
    QExerciseIfFit.append(RAlive*(PFitExerciseFit * RExerciseFit + PFitExerciseUnfit * RExerciseFit )) 
    
    QExerciseIfUnfit.append(RAlive*(PUnfitExerciseUnfit * RExerciseUnfit + PUnfitExerciseFit * RExerciseUnfit))

    QRelaxIfFit.append(RAlive*(PFitRelaxFit * RRelaxFit + PFitRelaxUnfit * RRelaxFit))

    QRelaxIfUnfit.append(RAlive*(PUnfitRelaxFit * RRelaxUnfit + PUnfitRelaxUnfit * RRelaxUnfit))

   

def vn(count):
    # max(qn(s, exercise), qn(s, relax))
    # has to be same s in calculation on each line
    VFit.append(max(QExerciseIfFit[count], QRelaxIfFit[count]))
    VUnfit.append(max(QExerciseIfUnfit[count], QRelaxIfUnfit[count]))
    #VDead.append(max(QDeadIfExercise[count], QDeadIfRelax[count]))

def qn(count):
    # q0(s, a) + G(p(s, a, fit)Vn(fit) + p(s, a, unfit)Vn(unfit))
    qexercisefit = RAlive*(QExerciseIfFit[0] + G * (PFitExerciseFit * VFit[count] + PFitExerciseUnfit * VUnfit[count]))
    QExerciseIfFit.append(qexercisefit)

    qexerciseunfit = RAlive*(QExerciseIfUnfit[0] + RAlive*G * (PUnfitExerciseFit * VFit[count] + PUnfitExerciseUnfit * VUnfit[count]))
    QExerciseIfUnfit.append(qexerciseunfit)

    qrelaxfit  = RAlive*(QRelaxIfFit[0] + RAlive*G * (PFitRelaxFit * VFit[count] + PFitRelaxUnfit * VUnfit[count]))
    QRelaxIfFit.append(qrelaxfit)

    qrelaxunfit = RAlive*(QRelaxIfUnfit[0] + RAlive*G * (PUnfitRelaxFit * VFit[count] + PUnfitRelaxUnfit * VUnfit[count]))
    QRelaxIfUnfit.append(qrelaxunfit)


if __name__ == '__main__':
    main()
