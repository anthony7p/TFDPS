%% EXPERIENCIA 2
function [P,Q,R,S,ampP,ampQ,ampR,ampS] = pqrs(t,ECG,fs)
    %%Factor R
    [ampR,R] = findpeaks(ECG,t,MinPeakHeight=0.65);
    
    %%Factor S
    [ampS,S] = findpeaks(-ECG,t,MinPeakHeight=0.6);
    ampS = -ampS;
    
    %%Factor Q
    [z,min_locz] = findpeaks(-ECG,t,MinPeakDistance=0.09);
    muestraz = round(min_locz*fs + 1);
    Q = min_locz(ECG(muestraz)>-0.4 & ECG(muestraz)<-0.17);
    Qfin=[];
    for k=0:length(R)-1
        if k==0
            val = Q>0 & Q<R(k+1);
        else
            val = Q>R(k) & Q<R(k+1);
        end
        val=find(val==1, 1, 'last');
        Qfin=[Qfin Q(val)];
    end
    Q=Qfin;
    ampQ=ECG(round(Q*fs)+1);
    
    %%Factor P
    [w,min_locw] = findpeaks(ECG,t,MinPeakDistance=0.205);
    muestraw = round(min_locw*fs + 1);
    P = min_locw(ECG(muestraw)>0.14 & ECG(muestraw)<0.4); 
    Pfin=[];
    for k=0:length(Q)-1
        if k==0
            val=P>0 & P<Q(k+1);
        else
            val=P>Q(k) & P<Q(k+1);
        end
        val = find(val==1, 1,'last');
        Pfin = [Pfin P(val)];
    end
    P=Pfin;
    ampP=ECG(round(P*fs)+1);
end