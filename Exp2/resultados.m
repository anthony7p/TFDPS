%%----------------------------------------------------
function text_result = resultados(P,Q,R,S,ampR,ampS)
    %%Frecuencia instantánea
    Frec_ins_text = "Las frecuencias instantáneas son:";
    Tins = zeros(1,length(R)-1);
    for i=1:length(R)-1
        Tins(i) = R(i+1) - R(i);   %Periodo Instantáneo
        Fins = round(Tins(i)*60);
        text = "    # " + string(i) + "   " + string(Fins) + " bpm";
        Frec_ins_text = [Frec_ins_text;text];
    end
    
    %%Frecuencia cardíaca
    TCar = R(end) - R(1);
    FCar = round(((length(R)-1)/TCar)*60);
    Frec_car_text = "Frecuencia cardíaca";
    text = "La frecuencia cardíaca es de " + string(FCar) + " bpm";
    Frec_car_text = [Frec_car_text;text];
    
    %%Análisis del ritmo cardíaco
    arritmia=[];
    a=1;
    for i=1:length(Tins)-1
        dT = abs(Tins(i+1)-Tins(i));
        if dT >= 0.004
            arritmia(a)=dT;
            a=a+1;
        end
    end
    
    %%Hallando diferencia de amplitudes
    %QRS
    %Falla amplitud R-S
    ampR_S = ampR - ampS;
    
    falla_amp_RS=[];
    
    for i=1:length(ampR_S)-1
        dT = abs(ampR_S(i+1)-ampR_S(i));
        if dT > 0.05
            falla_amp_RS = [falla_amp_RS,dT];
        end
    end
    
    vec_arritmia = length(arritmia);
    vec_falla_amp_RS = length(falla_amp_RS);
    
    if FCar<60
        rit_car_text="El paciente tiene bradicardia";
    elseif FCar>=60 && FCar<95
        rit_car_text="El paciente tiene un ritmo cardíaco normal";
    else
        rit_car_text="El paciente tiene taquicardia";
    end
    
    if(vec_arritmia>=1)
        arritmia_text = "El paciente presenta arritmia";
    else
        arritmia_text = "El paciente no presenta arritmia";
    end
    
    if(vec_falla_amp_RS>=1)
        falla_amp_RS_text = "El paciente presenta falla de amplitud R-S";
    else
        falla_amp_RS_text = "El paciente no presenta falla de amplitud R-S";
    end
    
    intPR = round(Q - P, 5);
    
    falla_int_PR = not(intPR >= 0.12 & intPR <= 0.2);
    
    vec_falla_int_PR = nnz(falla_int_PR);
    
    if(vec_falla_int_PR>=1)
        falla_int_PR_text = "El paciente presenta falla de intervalo P-R (conducción anormal del impulso eléctrico desde el nodo sinoauricular (SA) hasta los ventrículos)";
    else
        falla_int_PR_text = "El paciente no presenta falla de intervalo P-R (conducción normal del impulso eléctrico desde el nodo sinoauricular (SA) hasta los ventrículos)";
    end
    
    intQRS = round(S - Q, 5);
    
    falla_int_QRS = not(intQRS >= 0.06 & intQRS <= 0.12);
    
    vec_falla_int_QRS = nnz(falla_int_QRS);
    
    if(vec_falla_int_QRS>=1)
        falla_int_QRS_text = "El paciente presenta falla de intervalo QRS (propagación anormal  del impulso eléctrico a través de los ventrículos)";
    else
        falla_int_QRS_text = "El paciente no presenta falla de intervalo QRS (propagación normal del impulso eléctrico a través de los ventrículos)";
    end
    
    text_result = [Frec_ins_text;"";Frec_car_text;"";rit_car_text;arritmia_text;"";falla_amp_RS_text;"";falla_int_PR_text;"";falla_int_QRS_text];
end